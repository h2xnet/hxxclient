#ifndef MAIN_HANDLER_H
#define MAIN_HANDLER_H

#include <QObject>
#include <QDebug>

/*
 * ClassName: MainHandler
 * Desc: 主窗口事件处理类
 * Author: zfs
 * Date: 2023-10-16 21:25
 */
class MainHandler : public QObject
{
    Q_OBJECT
public:
    MainHandler();
    virtual ~MainHandler();

    /*
     * Func: mainWndInitComplated
     * Desc: 主窗口初始化完成
     * Author: zfs
     * Date: 2023-11-01 07:19
     */
    Q_INVOKABLE int mainWndInitComplated();

public:
signals:

public slots:



private:

};

#endif // MAIN_HANDLER_H
