#include "system_util.h"

#include <QSysInfo>

namespace base {

SystemUtil::SystemUtil()
{

}

int SystemUtil::getOsType() {
    QString kernerlType = QSysInfo::kernelType().toLower(); // 内核类型
   QString kernelVersion = QSysInfo::kernelVersion().toLower(); // 内核版本

   QString productType = QSysInfo::productType().toLower(); // 系统类型
   QString productVersion = QSysInfo::productVersion().toLower(); // 系统版本
   QString prettyProductName = QSysInfo::prettyProductName().toLower(); // 系统名称

   QString Info = QString("run os info: kernerlType:%1  kernelVersion:%2 productType:%3 productVersion:%4 prettyProductName:%5").arg(kernerlType.
           toLocal8Bit().data()).arg(kernelVersion.toLocal8Bit().data()).arg(productType.toLocal8Bit().data()).
           arg(productVersion.toLocal8Bit().data()).arg(prettyProductName.toLocal8Bit().data());
   qInfo(Info.toLocal8Bit().data());

   int ostype = eOsType::eUnknowOs;

   if (productType.compare(QString("windows")) == 0) {
       // windows
       ostype = eOsType::eWindowsOs;
   }
   else if (productType.compare(QString("kylin")) == 0) {
       // 麒麟
       ostype = eOsType::eKylinOs;
   }
   else if (productType.compare(QString("osx")) == 0 ||
            kernerlType.compare(QString("darwin")) == 0) {
       // macos
       ostype = eOsType::eMacOs;
   }
   else if (kernerlType.compare(QString("linux")) == 0) {
       // 内核linux系统
       ostype = eOsType::eLinuxOs;
   }

   return ostype;
}


} // end namespace base
