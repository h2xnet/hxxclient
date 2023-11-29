import QtQuick 2.0
import QtQuick.Controls 2.12

import webClient.net.pc  1.0

/*
 * ClassName: About
 * Desc: 关于页面
 * Author: zfs
 * Date: 2023-11-05 15:12
 */
Popup {
    id: controlId

    property int bodyWidth: 480
    property int bodyHeight: 360
    property int borderWidth: 1
    property int borderRadius: 4
    property var borderColor: "#FFFFFF"
    property var backgroundColor: "#FFFFFF"

    anchors.centerIn: parent

    modal: true

    width: bodyWidth
    height: bodyHeight
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
        width: bodyWidth - 2 * borderWidth
        height: bodyHeight - 2 * borderWidth

        StackView {
            id: stackViewId

            anchors.fill: parent
            visible: true
        }

    }

    onOpened: {
        console.log("About.qml onOpened")

        onSwitchPage();

    }

    onClosed: {
        console.log("About.qml onClosed")

    }

    function beginShow() {
        console.log("About.qml beginShow");
        if (!controlId.opened) {
            controlId.open();
        }
    }

    function endShow() {
        console.log("About.qml endShow");
        if (controlId.opened) {
            controlId.close();
        }
    }

    //
    // onSwitchPage : 切换页面
    //
    function onSwitchPage() {
         console.log("About.qml onSwitchPage");

        let pageUrl = "qrc:/uipages/settings/about/content/AboutWebClient.qml"

        stackViewId.clear();
        stackViewId.push(pageUrl, {parentControl: controlId});

    }

    //
    // gotoGithub : 跳转Github
    //
    function gotoGithub() {
        console.log("About.qml gotoGithub");

        endShow();

    }


}
