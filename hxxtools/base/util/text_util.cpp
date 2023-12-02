#include "text_util.h"

#include <QFile>
#include <QTextStream>

#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>

namespace base {

TextUtil::TextUtil()
{

}

int TextUtil::jsonFileFormat(const QString& inputFileName,
                   const QString& outputFileName) {
    qDebug() << "TextUtil::jsonFileFormat params, inputFileName:" << inputFileName  \
             << ", oputputFileName:" << outputFileName;

    QFile file(inputFileName);
    if (!file.exists() || file.size() <= 0) {
        qInfo() << "TextUtil::jsonFileFormat param error, inputFile is not exists or isEmpty";
        return -1;
    }

    QString strContent("");
    if (file.open(QIODevice::ReadOnly | QIODevice::Text)) {
         QTextStream in(&file);
         in.setCodec("UTF-8");

         strContent = in.readAll();

         file.close();
    }

    if (strContent.isEmpty()) {
        qInfo() << "TextUtil::jsonFileFormat read file content fail, fileName:" << inputFileName;
        return -2;
    }

    // 创建输出文件
    QFile outFile(outputFileName);
    if (!outFile.open(QIODevice::WriteOnly | QIODevice::Text)) {
        qInfo() << "TextUtil::jsonFileFormat create output file fail, fileName:" << outputFileName;
        return -3;
    }

    QTextStream out(&outFile);
    out.setCodec("UTF-8");

    QString strOutContent = "";

    try {
        QJsonDocument doc = QJsonDocument::fromJson(strContent.toUtf8());
        if (doc.isArray()) {
            QJsonArray arrObj = doc.array();

            strOutContent = QString(doc.toJson(QJsonDocument::Indented));
        }
        else if (doc.isObject()) {
            QJsonObject obj = doc.object();
            strOutContent = QString(doc.toJson(QJsonDocument::Indented));
        }

        if (!strOutContent.isEmpty()) {
            out << strOutContent;
        }

    } catch (...) {
        qInfo() << "TextUtil::jsonFileFormat input file json format exception, inputFile:" << inputFileName;
    }

    outFile.close();

    if (strOutContent.isEmpty()) {
        qInfo() << "TextUtil::jsonFileFormat input file content json format error";
        return -4;
    }

    return 0;
}


} // end namespace base
