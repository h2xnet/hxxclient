#include "app.h"
#include "base/file/file_path.h"
#include "base/log/log.h"
#include "base/util/system_util.h"
#include "handler/main_handler.h"
#include "handler/global_handler.h"
#include "base/service/configure_service.h"

// 系统托盘
#include "uicontrol/tray/systemTray/system_tray_icon.h"
#include "uicontrol/tray/systemCursor/system_cursor_deal.h"

#include <QApplication>
//#include <QGuiApplication>

#include <QQmlApplicationEngine>
//#include <QtWebView>
//#include <QtWebEngine/QtWebEngine>


using namespace SystemCursorDealSpace;


App* g_app = nullptr;  // 应用对象

GlobalHandler* g_handler = nullptr;

base::ConfigureService g_configure_service;

App* getApp() {
    if (!g_app) {
        g_app = new App();
    }
    return g_app;
}

//
// app_qobject_singletontype_provider : 应用单列提供者
//
static QObject* app_qobject_singletontype_provider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    //Q_UNUSED: 向编译器指示参数未在函数的主体中使用。这可用于抑制编译器警告
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)

    return getApp();
}

static QObject* global_handler_qobject_singletontype_provider(QQmlEngine *engine, QJSEngine *scriptEngine) {
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)

    if (!g_handler) {
        g_handler = new GlobalHandler();
    }

    return g_handler;
}

int main(int argc, char *argv[])
{

#ifdef Q_OS_WIN
    qputenv("QT_OPENGL", "angle");
    qputenv("QT_ANGLE_PLATFORM", "d3d9");
 #elif defined Q_OS_UNIX
    qputenv("QT_OPENGL", "angle");
 #elif defined Q_OS_LINUX
    qputenv("QT_OPENGL", "angle");
 #elif defined Q_OS_MAC
    qputenv("QT_OPENGL", "angle");
#endif

    // 禁用QWebEngine沙盒
    qputenv("QTWEBENGINE_DISABLE_SANDBOX", "1");

    //QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    // 苹果系统不可以启用软件opengl，否则会反应非常慢
    // 获取系统类型信息
    int osType= base::SystemUtil::getOsType();
    /*if (osType != base::eOsType::eMacOs) {
        QCoreApplication::setAttribute(Qt::AA_UseOpenGLES, false);
        QCoreApplication::setAttribute(Qt::AA_UseSoftwareOpenGL, true); // 兼容xp
    }*/

    // 如果是非windows系统，则强制指定插件路径，以及以XCB模式运行
    // export QT_PLUGIN_PATH=/path/to/your/custom/plugins
    // export LD_LIBRARY_PATH=/path/to/your/custom/libs:$LD_LIBRARY_PATH
    // export QT_QPA_PLATFORM=xcb
    if (base::eOsType::eWindowsOs != osType && base::eOsType::eMacOs != osType) {
        // 非windows系统
        QCoreApplication::setAttribute(Qt::AA_PluginApplication, true);

        QString pluginPath = base::FilePath::getPluginPath();
        qInfo() << "main pluginPath:" << pluginPath;

        // 设置插件库路径
        qputenv("QT_PLUGIN_PATH", pluginPath.toUtf8().data());
        QCoreApplication::addLibraryPath(pluginPath);

        // 强制使用 XCB 插件
        qputenv("QT_QPA_PLATFORM", "xcb");

    }

    QApplication app(argc, argv);
    //QGuiApplication app(argc, argv);

    int ret = -1;

    // 处理日志信息
    QString logPrefix = "WebClient.log";
    // 清理过期日志文件
    base::Log::clearOldLogFiles(logPrefix, 3);
    // 初始化日志
    int logRange = g_configure_service.getLogRange(0);
    ret = base::Log::initLog(logPrefix, logRange);
    qInfo() << "日志初始化状态:" << ret    \
            << ", 日志级别:" << logRange;

    qInfo() << "配置文件:" << g_configure_service.getConfigureFileName();

    // 初始化应用
    ret = getApp()->init(argc, argv);
    qInfo() << "应用初始化结果:" << ret;


   // QString str1 = "abcd\r\nefg";
   // int pos1 = str1.indexOf("d", 0);
   // int pos2 = str1.indexOf("\r\n", pos1 + 1);
   // qInfo() << "main str1:" << str1 \
    //        << ", pos1:" << pos1    \
    //        << ", pos2:" << pos2;

    // 系统托盘
    qmlRegisterType<MyMenu>("hxxTools.net.pc", 1, 0, "MyMenu");
    qmlRegisterType<MyAction>("hxxTools.net.pc", 1, 0, "MyAction");
    qmlRegisterType<MySeparator>("hxxTools.net.pc", 1, 0, "MySeparator");
    qmlRegisterType<SystemTrayIcon>("hxxTools.net.pc", 1, 0, "SystemTrayIcon");
    qmlRegisterType<SystemCursorDeal>("hxxTools.net.pc", 1, 0, "SystemCursorDeal");


    // 注册页面对象
    qmlRegisterSingletonType<App>("hxxTools.net.pc",
                                  1,
                                  0,
                                  "AppId",
                                  app_qobject_singletontype_provider);


    qmlRegisterSingletonType<GlobalHandler>("hxxTools.net.pc",
                                            1,
                                            0,
                                            "GlobalHandlerId",
                                            global_handler_qobject_singletontype_provider);

    // 注册页面事件
    qmlRegisterType<MainHandler>("hxxTools.net.pc", 1, 0, "MainHandler");



    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);

    ret = app.exec();

   qInfo() << "主程序退出循环，返回状态:" << ret;

   getApp()->uninit();

   base::Log::uninitLog();

   return ret;
}
