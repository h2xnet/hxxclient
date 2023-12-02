#ifndef TOOL_UTIL_H
#define TOOL_UTIL_H

#include <QString>
#include <QJsonObject>
#include <QJsonArray>
#include <QDebug>

namespace base {

/*
 * ClassName: ToolUtil
 * Desc: 工具类
 * Author: zfs
 * Date: 2023-10-16 21:07
 */
class ToolUtil
{
public:
    ToolUtil();

    //
    // 字符串转换
    //
    static QJsonObject qstringToQJsonObject(const QString& str);
    static QJsonArray qstringToQJsonArray(const QString& str);
    static QString qjsonObjectToQstring(const QJsonObject& obj);
    static QString qjsonArrayToQstring(const QJsonArray& obj);

};

} // end namespace base

#endif // TOOL_UTIL_H
