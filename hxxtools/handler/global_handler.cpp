#include "global_handler.h"

#include "app.h"
#include "./base/schema_data.h"
#include "./base/file/file_path.h"
#include "./base/util/system_util.h"

GlobalHandler::GlobalHandler()
{

}

GlobalHandler::~GlobalHandler() {

}

QString GlobalHandler::nativeToPath(const QString& path) {
    qDebug() << "GlobalHandler::imgPathToNative 输入参数: " << path;

    QString tempPath = path.simplified();

    int pos = -1;

    // qrc
    pos = tempPath.indexOf(base::SchemaData::getQrcKey(), 0, Qt::CaseInsensitive);
    if (pos >= 0) {
        return tempPath;
    }

    // file://
    pos = tempPath.indexOf(base::SchemaData::getFileKey(), 0, Qt::CaseInsensitive);
    if (pos >= 0) {
        return tempPath;
    }

    // 本地路径
    pos = tempPath.indexOf(base::SchemaData::getPathTagKey(), 0, Qt::CaseInsensitive);
    if (pos == 1) {
        return QString("file:///%1").arg(tempPath);
    }

    // data路径
    pos = tempPath.indexOf(base::SchemaData::getRelativeDataKey(), 0, Qt::CaseInsensitive);
    if (pos == 0) {
        return QString("file:///%1/%2").arg(base::FilePath::getAppDataPath()).arg(tempPath);
    }
    else if (pos == 1) {
        return QString("file:///%1%2").arg(base::FilePath::getAppDataPath()).arg(tempPath);
    }

    return path;
}

int GlobalHandler::getDefMaximized() {
    return g_configure_service.getDefMaximized(0);
}

int GlobalHandler::setDefMaximized(int defMaximized) {
    bool bret= g_configure_service.setDefMaximized(defMaximized);
    qDebug() << "GlobalHandler::setDefMaximized 修改默认最大化 状态:" << bret << ", 默认值:" << defMaximized;
    return bret ? 0 : -1;
}

int GlobalHandler::getLogRange(int defValue) {
    return g_configure_service.getLogRange(defValue);
}

int GlobalHandler::setLogRange(int logRange) {
    bool bret = g_configure_service.setLogRange(logRange);
    qDebug() << "GlobalHandler::setLogRange 修改日志级别 状态:" << bret << ", 默认值:" << logRange;
    return bret ? 0 : -1;
}

bool GlobalHandler::openLocalUrl(const QString& url) {
    bool bret = base::SystemUtil::openDesktopUrl(url);
    qDebug() << "GlobalHandler::openLocalUrl 打开链接状态:" << bret   \
             << ", 链接地址:" << url;
    return bret;
}

int GlobalHandler::toolBarRequest(const QString& eventId, const QString& params) {
    qDebug() << "GlobalHandler::toolBarRequest 工具栏请求事件, 事件ID:" << eventId  \
             << ", 事件参数:" << params;
    emit toolBarRequestEvent(eventId, params);
    return 0;
}
