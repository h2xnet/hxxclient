#ifndef CONFIGURE_SERVICE_H
#define CONFIGURE_SERVICE_H

#include <QString>
#include <QSettings>
#include <QDebug>
#include <QMutex>
#include <QMutexLocker>

namespace base {


/*
 * ClassName: ConfigureService
 * Desc: INI配置处理类
 * Author: zfs
 * Date: 2023-11-02 08:14
 */
class ConfigureService {
public:
    ConfigureService();
    virtual ~ConfigureService();

    QString getConfigureFileName();

    int getLogRange(int defValue = 3);
    bool setLogRange(int logRange);

    //
    // 默认最大化显示
    //
    int getDefMaximized(int defValue = 0);
    bool setDefMaximized(int value);

protected:
    int onGetIntValue(const QString& key, int defValue);
    bool onSetIntValue(const QString& key, int value);

    QString onGetStringValue(const QString& key, const QString& defValue);
    bool onSetStringValue(const QString& key, const QString& value);

    QMutex m_mutex;

};


} // end namespace base

#endif // CONFIGURE_SERVICE_H
