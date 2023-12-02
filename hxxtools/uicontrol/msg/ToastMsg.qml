import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3

/*
 * ClassName: ToastMsg
 * Desc: 有限显示消息窗口
 * Author: zfs
 * Date: 2022-09-06 19:09
 */
Popup {
    id: containerId

    property int msgType: 0 // 类型，0为成功，1为失败
    property int ctrlWidth: 210
    property int ctrlHeight: 46

    property int deplayTimes: 3000  // 延迟时间

    property var fontFamily: "Microsoft YaHei UI"
    property var bkColor: "#F0F9EB"
    property var failBkColor: "#FEF0F0"
    property var borderRadius: 4
    property int borderWidth: 0
    property var borderColor: "#67D034"
    property var labelTextColor: "#67D034"
    property var failBorderColor: "#D81E06"
    property var failLabelTextColor: "#D81E06"
    property int labelTextPixelSize: 14

    property int padLeft: 16
    property int padTop: 16
    property int padRight: 16
    property int padBottom: 16

    property var msgText: ""

    Timer {
        id: tm
        interval: deplayTimes
        onTriggered: {
            tm.stop();
            containerId.close();
        }
    }

    MouseArea {
        anchors.fill: parent

        onClicked: {
            if (tm.running()) {
                tm.stop();
            }
            containerId.close();
        }
    }

    anchors.centerIn: parent

    modal: true

    x: 0
    y: 0
    width: ctrlWidth
    height: ctrlHeight

    closePolicy: Popup.CloseOnPressOutside

    // 背景窗口
    background: Rectangle {
        anchors.fill: parent

        color: msgType === 0 ? bkColor : failBkColor
        radius: borderRadius
        border.width: borderWidth
        border.color: borderColor
    }

    Rectangle {
        id: msgWinId

        anchors.fill: parent

        color: "transparent"

        // 图标
        Image {
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: padLeft
            }
            sourceSize.width: 14
            sourceSize.height: 14
            source: msgType === 0 ? "qrc:/statics/imgs/success.png" : "qrc:/statics/imgs/fail.png"
        }

        // 文本内容
        Text {
            id: labelTextId

            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 34
            }
            font.family: fontFamily
            font.pixelSize: labelTextPixelSize
            color: msgType === 0 ? labelTextColor : failLabelTextColor
            text: msgText
        }

    } // end msgWinId Rectangle

    //
    // beginShow : 开始显示
    //
    function beginShow(msg, delayTime = 3000, type = 0) {
        msgType = type
        msgText = msg
        deplayTimes = delayTime

        // 调整窗口尺寸
        onWindowSize();

        containerId.open();
        tm.start();
    }

    //
    // onWindowSize : 计算调整窗口尺寸
    //
    function onWindowSize() {
        if (msgText === undefined || msgText === null || msgText === "") {
            ctrlWidth = 210;
            ctrlHeight = 46;
        }
        else {
            ctrlWidth = 34 + padRight + labelTextId.implicitWidth + 14
            ctrlHeight = padTop + padBottom + labelTextId.implicitHeight
        }
    }

} // end containerId Popup
