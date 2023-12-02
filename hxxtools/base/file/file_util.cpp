#include "file_util.h"

#include "base/file/file_path.h"
#include "base/util/tool_util.h"

#include <QFile>

namespace base {

FileUtil::FileUtil()
{

}

//
// getThemeConfigFileName : 获取主题配置文件名
//
QString FileUtil::getThemeConfigFileName() {
    QString fileName = QString("%1/data/theme_config.json").arg(FilePath::getAppDataPath());
    return fileName;
}

QString FileUtil::getThemeFullFileName(const QString& fileName) {
    QString fullFileName = QString("%1/data/theme/%2").arg(FilePath::getAppDataPath()).arg(fileName);
    return fullFileName;
}

//
// getJsonObjectFromFile : 从文件中获取JSON对象
//
QJsonObject FileUtil::getJsonObjectFromFile(const QString& fileName) {
    QJsonObject obj;

    QFile file;
    file.setFileName(fileName);

    if (file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        QByteArray content = file.readAll();
        file.close();

        qDebug() << " FileUtil::getJsonObjectFromFile 加载文件内容: " << content  \
                 << "\n 文件名: " << fileName;

        if (!content.isEmpty()) {
            obj = base::ToolUtil::qstringToQJsonObject(content);
        }
    }

    if (obj.isEmpty()) {
        qInfo() << " FileUtil::getJsonObjectFromFile 加载主程序主题配置文件失败, 文件名: " << fileName;
    }
    else {
        qInfo() << " FileUtil::getJsonObjectFromFile 加载主程序主题配置文件成功, 文件名: " << fileName;
    }

    return obj;
}

bool FileUtil::fileIsExist(const QString& fileName) {
    QFile file(fileName);
    return file.exists();
}

QString FileUtil::fileNameToNative(const QString& fileName) {
    // "file:///D:/curProject/h2x/ainav/data/dbtarget.json"
    QString strKey1("file:///");
    if (fileName.startsWith(strKey1)) {
        return fileName.mid(strKey1.size());
    }
    return fileName;
}


} // end namespace base
