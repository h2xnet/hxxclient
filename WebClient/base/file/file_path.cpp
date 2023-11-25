#include "file_path.h"

#include "base/util/system_util.h"

#include <QDir>
#include <QStandardPaths>
#include <QCoreApplication>

namespace base {


FilePath::FilePath()
{

}

QString FilePath::getAppPath() {
    return QCoreApplication::applicationDirPath().toLatin1().data();
}

QString FilePath::getInstallBasePath() {
    int osType = SystemUtil::getOsType();
    QString path = getAppPath();
    if (osType == eOsType::eMacOs) {
        // 苹果必须退出到包的根目录，否则无法读写
    }
    return path;
}

QString FilePath::getAppDataPath() {
    return getInstallBasePath();
}

QString FilePath::getLogPath() {
    QString path = QString("%1/log").arg(getInstallBasePath());
    if (!pathIsExist(path, true)) {
        return getInstallBasePath();
    }
    return path;
}

bool FilePath::pathIsExist(const QString& path, bool isCreate) {
    if (path.isEmpty()) {
        return false;
    }

    QDir dir(path);
    if (!dir.exists()) {
        if (isCreate) {
            dir.mkpath(path);
        }
    }

    return dir.exists();
}

QString FilePath::getPluginPath() {
    QString path = getInstallBasePath();
    int pos = path.lastIndexOf("/");
    if (pos > 0) {
        path = path.left(pos);

        path += QString("/plugins");
    }

    return path;
}


} // end namespace base
