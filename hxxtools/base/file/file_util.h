#ifndef FILE_UTIL_H
#define FILE_UTIL_H

#include <QString>
#include <QJsonObject>

namespace base {


/*
 * ClassName: FileUtil
 * Desc: 文件类
 * Author: zfs
 * Date: 2023-10-16 20:52
 */

class FileUtil
{
public:
    FileUtil();

    /*
     * Func: getThemeConfigFileName
     * Desc: 获取主题配置文件名
     * Author: zfs
     * Date: 2023-10-16 20:54
     */
    static QString getThemeConfigFileName();

    /*
     * Func: getThemeFullFileName
     * Desc: 根据文件名获取完整的主题文件名
     * Author: zfs
     * Date: 2023-10-17 08:19
     */
    static QString getThemeFullFileName(const QString& fileName);

    /*
     * Func: getJsonObjectFromFile
     * Desc: 从文件中获取JSON对象
     * Author: zfs
     * Date: 2023-10-16 20:54
     */
    static QJsonObject getJsonObjectFromFile(const QString& fileName);

    /*
     * Func: fileIsExist
     * Desc: 判断文件是否存在
     * Author: zfs
     * Date: 2023-11-02 08:27
     */
    static bool fileIsExist(const QString& fileName);


};

} // end namespace base

#endif // FILE_UTIL_H
