#ifndef GLOBAL_HANDLER_H
#define GLOBAL_HANDLER_H


#include "./base/service/configure_service.h"

#include <QObject>



extern base::ConfigureService g_configure_service;

/*
 * ClassName: GlobalHandler
 * Desc: 全局事件处理类
 * Author: zfs
 * Date: 2023-10-16 21:40
 */
class GlobalHandler : public QObject
{
    Q_OBJECT
public:
    GlobalHandler();
    virtual ~GlobalHandler();

    /*
     * Func: nativeToPath
     * Desc: 路径本地化
     * Author: zfs
     * Date: 2023-10-21 07:15
     */
    Q_INVOKABLE QString nativeToPath(const QString& path);

    /*
     * Func: getDefMaximized
     * Desc: 获取默认最大化标志
     * Author: zfs
     * Date: 2023-11-02 22:13
     */
    Q_INVOKABLE int getDefMaximized();

    Q_INVOKABLE int setDefMaximized(int defMaximized);

    Q_INVOKABLE int getLogRange(int defValue = 3);

    Q_INVOKABLE int setLogRange(int logRange);


public slots:


public:
signals:

};

#endif // GLOBAL_HANDLER_H
