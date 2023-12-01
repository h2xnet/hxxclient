#include "system_util.h"

#include <QSysInfo>
#include <QDesktopServices>
#include <QUrl>

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

QString SystemUtil::getRunOS() {
    QString prettyProductName = QSysInfo::prettyProductName().toLower(); // 系统名称

    if (!prettyProductName.isEmpty()) {
        return prettyProductName;
    }

    QString productType = QSysInfo::productType().toLower(); // 系统类型
    QString productVersion = QSysInfo::productVersion().toLower(); // 系统版本
    if (!productType.isEmpty() && !productVersion.isEmpty()) {
        return QString("%1 %2").arg(productType).arg(productVersion);
    }

    QString kernerlType = QSysInfo::kernelType().toLower(); // 内核类型

    return kernerlType;
}

QString SystemUtil::getRunOSVer() {
    QString kernelVersion = QSysInfo::kernelVersion().toLower(); // 内核版本
    if (!kernelVersion.isEmpty()) {
        return kernelVersion;
    }

    QString productType = QSysInfo::productType().toLower(); // 系统类型
    QString productVersion = QSysInfo::productVersion().toLower(); // 系统版本
    if (!productType.isEmpty() && !productVersion.isEmpty()) {
        return QString("%1 %2").arg(productType).arg(productVersion);
    }

    return productType;
}

bool SystemUtil::openDesktopUrl(const QString& url) {
    if (url.isEmpty()) {
        return false;
    }
    return QDesktopServices::openUrl(QUrl(url));
}


} // end namespace base
