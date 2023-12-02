#include "configure_service.h"

#include "base/file/file_path.h"
#include "base/file/file_util.h"

namespace base {

ConfigureService::ConfigureService()
{

}

ConfigureService::~ConfigureService() {

}

QString ConfigureService::getConfigureFileName() {
    QString path = base::FilePath::getAppDataPath();
    return QString("%1/configure.ini").arg(path);
}

int ConfigureService::onGetIntValue(const QString& key, int defValue) {
    if (key.isEmpty()) {
        qInfo() << "ConfigureService::onGetIntValue 键为空";
        return -1;
    }

    QString fileName = getConfigureFileName();
    if (!base::FileUtil::fileIsExist(fileName)) {
         qInfo() << "ConfigureService::onGetIntValue 文件不存在:" << fileName;
        return defValue;
    }

    QSettings settings(fileName, QSettings::IniFormat);
    int ret = settings.value(key, defValue).toInt();

    qDebug() << "ConfigureService::onGetIntValue 获取配置文件整数数据, 返回值:" << ret   \
             << ", 键:" << key   \
             << ", 文件:" << fileName;

    return ret;
}

bool ConfigureService::onSetIntValue(const QString& key, int value) {
    if (key.isEmpty()) {
        qInfo() << "ConfigureService::onSetIntValue 键为空";
        return false;
    }
    QString fileName = getConfigureFileName();

    if (!base::FileUtil::fileIsExist(fileName)) {
         qInfo() << "ConfigureService::onSetIntValue 文件不存在:" << fileName;
        return false;
    }

    QSettings settings(fileName, QSettings::IniFormat);

    settings.setValue(key, value);
    return true;
}

QString ConfigureService::onGetStringValue(const QString& key, const QString& defValue) {
    if (key.isEmpty()) {
        qInfo() << "ConfigureService::onGetStringValue 键为空";
        return QString("");
    }

    QString fileName = getConfigureFileName();

    if (!base::FileUtil::fileIsExist(fileName)) {
         qInfo() << "ConfigureService::onGetStringValue 文件不存在:" << fileName;
        return defValue;
    }

    QSettings settings(fileName, QSettings::IniFormat);
    QString result = settings.value(key, defValue).toString();

    qDebug() << "ConfigureService::onGetStringValue 获取配置文件整数数据, 返回值:" << result   \
             << ", 键:" << key   \
             << ", 文件:" << fileName;

    return result;
}

bool ConfigureService::onSetStringValue(const QString& key, const QString& value) {
    if (key.isEmpty()) {
        qInfo() << "ConfigureService::onSetStringValue 键为空";
        return false;
    }
    QString fileName = getConfigureFileName();

    if (!base::FileUtil::fileIsExist(fileName)) {
         qInfo() << "ConfigureService::onSetStringValue 文件不存在:" << fileName;
        return false;
    }

    QSettings settings(fileName, QSettings::IniFormat);

    settings.setValue(key, value);
    return true;
}

int ConfigureService::getLogRange(int defValue) {
    QMutexLocker lock(&m_mutex);
    return onGetIntValue("config/logRange", defValue);
}

bool ConfigureService::setLogRange(int logRange) {
    QMutexLocker lock(&m_mutex);
    return onSetIntValue("config/logRange", logRange);
}

int ConfigureService::getDefMaximized(int defValue) {
    QMutexLocker lock(&m_mutex);
    return onGetIntValue("config/defMaximized", defValue);
}

bool ConfigureService::setDefMaximized(int value) {
    QMutexLocker lock(&m_mutex);
    return onSetIntValue("config/defMaximized", value);
}


} // end namespace base
