import QtQuick 2.0
import QtQuick.Controls 2.12

import webClient.net.pc  1.0

/*
 * ClassName: Settings
 * Desc: 设置页面
 * Author: zfs
 * Date: 2023-11-01 07:27
 */
Popup {
    id: controlId

    property int defWidth: 180
    property int defHeight: 200

    property var backgroundColor: "#FFFFFF"
    property int borderRadius: 8
    property int borderWidth: 1
    property var borderColor: "#C3C3C3"


    modal: true

    x: 0
    y: 0
    width: defWidth
    height: defHeight
    opacity: 1.0

    closePolicy: Popup.CloseOnPressOutside

    // 背景窗口
    background: Rectangle {
        anchors.fill: parent

        color: backgroundColor
        radius: borderRadius
        border.width: borderWidth
        border.color: borderColor
    }

    // 页面窗口
    Rectangle {

        anchors.centerIn: parent

        color: "transparent"
        radius: borderRadius
        width: parent.width - 2 * borderWidth
        height: parent.height - 2 * borderWidth

        StackView {
            id: stackViewId

            anchors.fill: parent
        }

    }

    Component.onCompleted: {
        console.log("Settings.qml onCompleted");

        onSwitchPage();

    }

    Component.onDestruction: {
        console.log("Settings.qml onDestruction");

    }

    function initPage(args) {
        console.log("Setting.qml initPage params, args:" + JSON.stringify(args));

        if (Object.prototype.hasOwnProperty.call(args, 'page')) {
            let pageObj = args['page'];
            if (pageObj.hasOwnProperty('backgroundColor')) {
                controlId.backgroundColor = pageObj['backgroundColor'];
            }
            if (pageObj.hasOwnProperty('radius')) {
                controlId.borderRadius = pageObj['radius'];
            }
            if (pageObj.hasOwnProperty('borderWidth')) {
                controlId.borderWidth = pageObj['borderWidth'];
            }
            if (pageObj.hasOwnProperty('borderColor')) {
                controlId.borderColor = pageObj['borderColor'];
            }
        }

    }

    function beginShow() {
        console.log("Setting.qml beginShow");
        if (!controlId.opened) {
            controlId.open();
        }
    }

    function endShow() {
        console.log("Setting.qml endShow");
        if (controlId.opened) {
            controlId.close();
        }
    }

    //
    // onSwitchPage : 切换页面
    //
    function onSwitchPage() {
         console.log("Settings.qml onSwitchPage");

        let pageUrl = "qrc:/uipages/settings/content/SettingsPage.qml"

        stackViewId.clear();
        stackViewId.push(pageUrl, {parentControl: controlId});

    }

    //
    // onMenuButtonClick : 菜单按钮事件
    //
    function onMenuButtonClick(idx, obj) {
        console.log("Settings.qml Settings.qml params, idx:" + idx + ", obj:" + JSON.stringify(obj));

        // 关闭设置窗口
        endShow();

        if (obj["id"] === "exitAppId") {
            // 退出
            //obj["confirm"] = true;
            let exitArgs = {};
            exitArgs["id"] = obj["id"];
            exitArgs["confirm"] = true;
            exitArgs["text"] = obj["text"];
            AppId.settingsRequestEvent(obj["id"], exitArgs);
        }
        else {
            AppId.settingsRequestEvent(obj["id"], obj);

        }


    }

}
