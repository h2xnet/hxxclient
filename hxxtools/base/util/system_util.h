#ifndef SYSTEM_UTIL_H
#define SYSTEM_UTIL_H

#include <QString>

namespace base {

/*
 * Enum: eOsType
 * Desc: 操作系统类型
 * Author: zfs
 * Date: 2023-1015 20:07
 */
enum eOsType {
    eUnknowOs = 0,
    eWindowsOs, // windows系统
    eKylinOs,   // 麒麟系统
    eUosOs,  // 统信系统
    eLinuxOs, // 类linux系统
    eMacOs // macos
};


/*
 * ClassName: SystemUtil
 * Desc: 系统相关信息处理类
 * Author: zfs
 * Date: 2023-10-15 20:08
 */
class SystemUtil
{
public:
    SystemUtil();

    /*
    * Func: getOsType
    * Desc: 获取系统类型
    * Author: zfs
    * Date: 2023-10-15 20:09
    */
   static int getOsType();

   /*
   * Func: getRunOS
   * Desc: 获取运行系统
   * Author: zfs
   * Date: 2023-11-29 21:26
   */
   static QString getRunOS();

   /*
   * Func: getRunOSVer
   * Desc: 获取运行系统版本信息
   * Author: zfs
   * Date: 2023-11-29 21:26
   */
   static QString getRunOSVer();

   /*
   * Func: openDesktopUrl
   * Desc: 打开桌面链接
   * Author: zfs
   * Date: 2023-12-1 08:04
   */
   static bool openDesktopUrl(const QString& url);


};


} // end namespace base

#endif // SYSTEM_UTIL_H
