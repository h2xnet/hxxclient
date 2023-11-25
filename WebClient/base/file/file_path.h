#ifndef FILE_PATH_H
#define FILE_PATH_H

#include <QString>

namespace base {


/*
 * ClassName: FilePath
 * Desc: 文件路径类
 * Author: zfs
 * Date: 2023-10-15 19:47
 */
class FilePath {
public:
    FilePath();

    /*
     * Func: getAppPath
     * Desc: 获取应用路径
     * Author: zfs
     * Date: 2023-10-15 19:48
     */
    static QString getAppPath();

    /*
     * Func: getInstallBasePath
     * Desc: 获取应用安装基础路径
     * Author: zfs
     * Date: 2023-10-15 19:48
     */
    static QString getInstallBasePath();

    /*
     * Func: getAppDataPath
     * Desc: 获取应用数据路径
     * Author: zfs
     * Date: 2023-10-15 19:48
     */
    static QString getAppDataPath();

    /*
     * Func: getLogPath
     * Desc: 获取日志路径
     * Author: zfs
     * Date: 2023-10-15 20:21
     */
    static QString getLogPath();

    /*
     * Func: pathIsExist
     * Desc: 判断路径是否存在，如果isCreate为true,如果不存在则会创建
     * Author: zfs
     * Date: 2023-10-15 20:24
     */
    static bool pathIsExist(const QString& path, bool isCreate);

    /*
     * Function: getPluginPath
     * Desc: 获取插件路径
     * Author: zfs
     * Date: 2023-10-15 20:35
     */
    static QString getPluginPath();


};


} // end namespace base

#endif // FILE_PATH_H
