﻿#include "app.h"

#include "base/file/file_util.h"

//extern App g_app;

App::App()
{

}

App::~App() {

}

bool App::init(int argc, char* argv[]) {
    qInfo() << "App::init 应用初始化，输入参数个数为:" << argc;

    qInfo() << "App::init 应用初始化输入参数列表";
    for(int i = 0; i < argc; i++) {
        qInfo() << "    argv[" << i << "] = " << argv[i];
    }

    int ret = -1;

    return 0;
}

int App::uninit() {

    return 0;
}

int App::initCompletedApp() {

    // 加载主题配置信息
    QString themeFileName = base::FileUtil::getThemeConfigFileName();
    qInfo() << " App::initCompletedApp 主题配置文件名: " << themeFileName;

    QJsonObject themeObj = base::FileUtil::getJsonObjectFromFile(themeFileName);
    if (themeObj.isEmpty()) {
        qInfo() << " App::initCompletedApp 加载主题配置信息失败 ";
        return -1;
    }

    // 加载主窗口主题
    if (themeObj.contains("mainTheme")) {
        QString mainThemeFileName = themeObj.value("mainTheme").toString();
        QString mainThemeFullFileName = base::FileUtil::getThemeFullFileName(mainThemeFileName);
        QJsonObject mainThemeObj = base::FileUtil::getJsonObjectFromFile(mainThemeFullFileName);

        qDebug() << " App::initCompletedApp 主题文件名: " << mainThemeFileName   \
                 << " ,完整主题文件名: " << mainThemeFullFileName;

        if (!mainThemeObj.isEmpty()) {
            emit mainThemeDataEvent(0, mainThemeObj);
        }
    }

    return 0;
}

int App::exitApp(int exitCode) {
    qInfo() << " 应用退出代码: " << exitCode;

    return 0;
}

int App::settingsRequest(const QString& source, const QJsonObject& args) {
    emit settingsRequestEvent(source, args);
    return 0;
}

int App::loadingChanged(bool isLoading, const QString& source) {
    emit loadingChangedEvent(isLoading, source);
    return 0;
}

int App::setTitleBarLogoImg(QString imgPath) {
    qInfo() << "App::setTitleBarLogoImg params, imgPath:" << imgPath;
    if (imgPath.isEmpty()) {
        return -1;
    }
    m_title_bar_logo_img = imgPath;
    return 0;
}

QString App::getTitleBarLogoImg() {
    if (m_title_bar_logo_img.isEmpty()) {
        m_title_bar_logo_img = "qrc:/statics/logo/logo.png";
    }
    return m_title_bar_logo_img;
}
