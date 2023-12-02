#include "tool_util.h"

#include <QJsonDocument>

namespace base {

ToolUtil::ToolUtil()
{

}

QJsonObject ToolUtil::qstringToQJsonObject(const QString& str) {
    QJsonObject obj;

    if (!str.isEmpty()) {
        try {
            QJsonDocument doc = QJsonDocument::fromJson(str.toUtf8());
            if (!doc.isNull()) {
                if (doc.isObject()) {
                    obj = doc.object();
                }
                else {
                    qInfo() << " ToolUtil::qstringToQJsonObject doc 不是个有效对象 ";
                }
            }
            else {
                qInfo() << " ToolUtil::qstringToQJsonObject doc 对象为空 ";
            }
        }
        catch (...) {
            qInfo() << " ToolUtil::qstringToQJsonObject JSON字符串解析失败, JSON字符串: " << str;
        }
    }

    return obj;
}

QJsonArray ToolUtil::qstringToQJsonArray(const QString& str) {
    QJsonArray obj;

    if (!str.isEmpty()) {
        try {
            QJsonDocument doc = QJsonDocument::fromJson(str.toUtf8());
            if (!doc.isNull()) {
                if (doc.isArray()) {
                    obj = doc.array();
                }
            }
        }
        catch (...) {
            qInfo() << " ToolUtil::qstringToQJsonArray JSON字符串解析失败, JSON字符串: " << str;
        }
    }

    return obj;
}

QString ToolUtil::qjsonObjectToQstring(const QJsonObject& obj) {
    if (!obj.isEmpty()) {
        return QString(QJsonDocument(obj).toJson(QJsonDocument::Compact));
    }
    return QString("");
}

QString ToolUtil::qjsonArrayToQstring(const QJsonArray& obj) {
    if (!obj.isEmpty()) {
        return QString(QJsonDocument(obj).toJson(QJsonDocument::Compact));
    }
    return QString("");
}


} // end namespace base
