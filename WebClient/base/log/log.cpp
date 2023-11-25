#include "log.h"

#include "base/file/file_path.h"

#include <QDateTime>
#include <QDir>
#include <QCoreApplication>
#include <QDateTime>
#include <QFile>
#include <QMutex>
#include <QTextStream>

namespace  {

static QMutex mutex_;
static QFile* file_ = nullptr;
static QString log_file_name_ = QString("WebClient.log");
static int log_range_ = 3;
static double log_file_max_size = 500;  //per M
static double default_log_max_size = 10 ;//per M

static QString msgHead[]={
    QString("DEBUG"),
    QString("WARNING"),
    QString("CRITICAL"),
    QString("FATAL"),
    QString("INFO")
};

}

namespace base {

Log::Log()
{

}

Log::~Log() {

}

int Log::clearOldLogFiles(const QString& prefix, int keepDays) {
    if (keepDays < 0) {
        keepDays = 3;
    }

    QString path = base::FilePath::getLogPath();

    QString strSearchText = prefix;
    if (strSearchText.isEmpty()) {
        strSearchText = QString("WebClient.log");
    }

    QDateTime currentTime = QDateTime::currentDateTime();
    QDir dir(path);
    QFileInfoList fileInfoList = dir.entryInfoList(QDir::Files | QDir::NoDotAndDotDot);

    // 秒数
    qint64 dayOfSecs = 3600 * 24 * keepDays;

    int count = 0;
    foreach (auto fileInfo, fileInfoList) {
        if (fileInfo.isFile()) {
            QString strFilePath = fileInfo.absoluteFilePath();
            QString strFileName = fileInfo.fileName();
            qDebug("Log::clearOldLogFiles 清理文件信息 filePath:%s fileName:%s\r\n", strFilePath.toUtf8().data(), strFileName.toUtf8().data());

            QString strFileDate = strFileName.replace(QRegExp(strSearchText), "");
            qDebug("logfile.cpp ClearLogFiles fileData:%s\r\n", strFileDate.toUtf8().data());

            // 2022-05-31-20-32-51
            QDateTime fileTime = QDateTime::fromString(strFileDate, "yyyy-MM-dd-hh-mm-ss");

            // 计算时间差，秒数
            qint64 intervalTimes = fileTime.secsTo(currentTime);

            qDebug("logfile.cpp ClearLogFiles intervalTimes : %s\r\n", QString::number(intervalTimes).toUtf8().data());

           if (intervalTimes >= dayOfSecs) {
                QFile::remove(strFilePath);
                count++;
           }
        }
    }

    qInfo() << "Log::clearOldLogFiles 清理历史文件个数:" << count;

    return count;
}

int Log::initLog(const QString& prefix, int logRange) {
    log_file_name_ = prefix;
    log_range_ = logRange;
    QString path = base::FilePath::getLogPath();
    if (!base::FilePath::pathIsExist(path, true)) {
        return -1;
    }

    // 添加日志色子
    qInstallMessageHandler(Log::messageOutput);

    return 0;
}

void Log::uninitLog() {
    if (file_){
        QMutexLocker lock(&mutex_);
        if (file_->isOpen()) {
            file_->close();
        }
        delete file_;
        file_ =  nullptr;
    }
}

bool Log::OnLogCanOutput(QtMsgType logMsgType) {
    return (log_range_ <= (int)logMsgType ? true : false);
}

void Log::messageOutput(QtMsgType type, const QMessageLogContext& context, const QString& msg) {
    if (!OnLogCanOutput(type)) {
        return;
    }

    QByteArray localMsg = msg.toUtf8();
    QString current_date_time = QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss ddd");

    QMutexLocker lock(&mutex_);
    // 如果已经打开，则判断大小是否超额
    if (file_) {
        double fileSize = file_->size();

        if (fileSize >= log_file_max_size){
            if (file_){
                file_->close();
                delete file_;
                file_ =  nullptr;
            }
        }

    }

    // 如果没有打开，则打开
    if (!file_) {
        // log path
        QString strLogPath = base::FilePath::getLogPath();

        if (!base::FilePath::pathIsExist(strLogPath, true)) {
            return;
        }

        QDateTime currentTime = QDateTime::currentDateTime();//yyyy.MM.dd hh:mm:ss.zzz ddd
        QString currentTimeStr =currentTime .toString("yyyy-MM-dd-hh"); // "yyyy-MM-dd-hh-mm"

        QString logFileName = strLogPath + "/" + currentTimeStr + "-" + log_file_name_;

        // 打开文件
        file_ = new QFile(logFileName);
        if (!file_) {
            return;
        }

        if (!file_->open(QIODevice::WriteOnly | QIODevice::Text | QIODevice::Append)) {
            delete file_;
            file_ = nullptr;
            return;
        }

        qInstallMessageHandler(messageOutput);

    }

    // 保存日志
    if (file_) {
        QTextStream tWrite(file_);
        tWrite.setCodec("UTF-8");
        QString msgText="%3 [%1] %2\n";
        msgText = msgText.arg(msgHead[type].toStdString().data()).arg(localMsg.constData()).arg(current_date_time);
        tWrite << msgText;
    }

}


} // end namespace base
