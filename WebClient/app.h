﻿#ifndef APP_H
#define APP_H

#include <QString>
#include <QObject>
#include <QDebug>

/*
 * ClassName: App
 * Desc: 应用类，一个应用程序只有一个应用类
 * Author: zfs
 * Date: 2023-10-15 20:54
 */
class App : public QObject
{
    Q_OBJECT
public:
    App();
    ~App();

    bool init(int argc, char* argv[]);

    int uninit();

    /*
     * Func: initCompletedApp
     * Desc: 初始化完成
     * Author: zfs
     * Date: 2023-10-17 07:59
     */
    Q_INVOKABLE int initCompletedApp();

    /*
     * Func: exitApp
     * Desc: 关闭应用
     * Author: zfs
     * Date: 2023-10-17 07:56
     */
    Q_INVOKABLE int exitApp(int exitCode);

    /*
     * Func: settingsRequest
     * Desc: 设置请求
     * Author: zfs
     * Date: 2023-11-05 11:12
     */
    Q_INVOKABLE int settingsRequest(const QString& source, const QJsonObject& args);

    /*
     * Func: loadingChanged
     * Desc: 加载状态改变
     * Author: zfs
     * Date: 2023-10-29 09:17
     * @isLoading: 加载状态, true 代表正在加载, false 代表加载完成
     * @source: 事件来源
     */
    Q_INVOKABLE int loadingChanged(bool isLoading, const QString& source);

    /*
     * Func: setTitleBarLogoImg
     * Desc: 设置标题栏LOGO图片
     * Author: zfs
     * Date: 2023-11-21 11:34
     */
    Q_INVOKABLE int setTitleBarLogoImg(QString imgPath);

    /*
     * Func: getTitleBarLogoImg
     * Desc: 获取标题栏LOGO图片
     * Author: zfs
     * Date: 2023-11-21 11:34
     */
    Q_INVOKABLE QString getTitleBarLogoImg();


public slots:


public:
signals:

    //
    // mainThemeDataEvent : 主窗口主题数据事件
    //
    void mainThemeDataEvent(int code, const QJsonObject& data);

    //
    // loadingChangedEvent : 加载状态改变事件
    // @isLoading: true代表开始加载, false代表加载停止
    // @source: 事件来源
    //
    void loadingChangedEvent(bool isLoading, const QString& source);

    //
    // settingsRequest : 设置请求事件
    //
    void settingsRequestEvent(const QString& source, const QJsonObject& args);


private:

    QString m_title_bar_logo_img; // 标题栏LOGO图片


};

extern App* getApp();

#endif // APP_H