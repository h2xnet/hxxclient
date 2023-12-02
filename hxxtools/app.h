#ifndef APP_H
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

    /*
     * Func: setClientName
     * Desc: 设置客户端名称
     * Author: zfs
     * Date: 2023-11-29 20:56
     */
    Q_INVOKABLE int setClientName(QString name);

    /*
     * Func: getClientName
     * Desc: 获取客户端名称
     * Author: zfs
     * Date: 2023-11-29 20:56
     */
    Q_INVOKABLE QString getClientName();

    /*
     * Func: setVersion
     * Desc: 设置版本号
     * Author: zfs
     * Date: 2023-11-29 20:57
     */
    Q_INVOKABLE int setVersion(QString version);

    /*
     * Func: getVersion
     * Desc: 获取版本号
     * Author: zfs
     * Date: 2023-11-29 20:57
     */
    Q_INVOKABLE QString getVersion();

    /*
     * Func: setBuilder
     * Desc: 设置编译号
     * Author: zfs
     * Date: 2023-11-29 20:58
     */
    Q_INVOKABLE int setBuilder(QString str);

    /*
     * Func: getBuilder
     * Desc: 获取编译号
     * Author: zfs
     * Date: 2023-11-29 20:58
     */
    Q_INVOKABLE QString getBuilder();

    Q_INVOKABLE QString getRunOS();

    Q_INVOKABLE QString getRunOSVer();

    Q_INVOKABLE int setGithubUrl(QString url);
    Q_INVOKABLE QString getGithubUrl();

    Q_INVOKABLE int setGiteeUrl(QString url);
    Q_INVOKABLE QString getGiteeUrl();


public slots:


public:
signals:


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

    QString m_client_name;
    QString m_version;
    QString m_builder;

    QString m_github_url;
    QString m_gitee_url;

};

extern App* getApp();

#endif // APP_H
