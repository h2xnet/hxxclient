QT += quick
QT += qml sql
QT += network
QT += core
QT += multimedia
QT += webview
QT += webengine
QT += xml
QT += widgets

CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

DEFINES += QT_DEPRECATED_WARNINGS

# windows utf-8 encode
msvc {
    QMAKE_CFLAGS += /utf-8
    QMAKE_CXXFLAGS += /utf-8
}

unix:!mac{
    QMAKE_LFLAGS += "-Wl,-rpath,\'\$$ORIGIN/lib\':\'\$$ORIGIN/../lib\'"
}

CONFIG(debug, debug|release):{
    message("config debug")

}
else:CONFIG(release, debug|release):{
    message("config release")

}

SOURCES += \
        app.cpp \
        base/file/file_path.cpp \
        base/file/file_util.cpp \
        base/log/log.cpp \
        base/schema_data.cpp \
        base/service/configure_service.cpp \
        base/util/system_util.cpp \
        base/util/tool_util.cpp \
        handler/global_handler.cpp \
        handler/main_handler.cpp \
        main.cpp \
        uicontrol/tray/systemCursor/system_cursor_deal.cpp \
        uicontrol/tray/systemTray/system_tray_icon.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    app.h \
    base/file/file_path.h \
    base/file/file_util.h \
    base/log/log.h \
    base/schema_data.h \
    base/service/configure_service.h \
    base/util/system_util.h \
    base/util/tool_util.h \
    handler/global_handler.h \
    handler/main_handler.h \
    platform/build_platform.h \
    uicontrol/tray/systemCursor/system_cursor_deal.h \
    uicontrol/tray/systemTray/system_tray_icon.h

DISTFILES +=
