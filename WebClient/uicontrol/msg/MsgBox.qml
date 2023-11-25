import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

import "../button"

/*
 * ClassName: MsgBox
 * Desc: 消息提示框组件
 * Author: zfs
 * Date: 2023-10-29 08:55
 */
Popup {
    id: controlId

    signal msgBoxBtnClick(bool isYes, var source, var owner);

    property var type: 0 // 0为确定，1为确定和取消，2为是和否
    property var labelText: ""
    property var backColor: "#000000"
    property int borderRadius: 4
    property var pageColor: "#FFFFFF"
    property int pageWidth: 340
    property int pageHeight: 170
    property int titleBarHeight: 30
    property var titleBarBackgroundColor: "transparent"
    property int titleBarBorderWidth: 1
    property var titleBarBorderColor: "#CCCCCC"
    property int flootBarHeight: 60
    property int btnWidth: 82
    property int btnHeight: 35
    property int btnTopPadding: 5
    property int labelTextFontSize: 14
    property var labelTextColor: "#333333"

    property var sourceTag: "" // 来源
    property var ownerData: null

    anchors.centerIn: parent

    modal: true

    x: 0
    y: 0
    width: parent.width
    height: parent.height

    closePolicy: Popup.CloseOnPressOutside

    // 背景窗口
    background: Rectangle {
        anchors.fill: parent

        color: backColor
        radius: borderRadius
        opacity: 0.65
    }

    // 页面窗口
    Rectangle {
        id: pageWinId

        anchors.centerIn: parent

        width: pageWidth
        height: pageHeight
        color: pageColor
        radius: borderRadius

        Column {
            spacing: 0

            width: pageWinId.width
            height: pageWinId.height

            // 标题栏
            Rectangle {
                id: titleWinId

                width: pageWinId.width
                height: titleBarHeight
                color: titleBarBackgroundColor
                radius: borderRadius
                border.width: titleBarBorderWidth
                border.color: titleBarBorderColor
            } // end titleWinId Rectangle

            // 内容区域
            Rectangle {
                id: contentWinId

                width: pageWinId.width
                height: pageWinId.height - titleBarHeight - flootBarHeight
                color: "transparent"
                radius: borderRadius
                clip: true

                Text {

                    anchors.centerIn: parent

                    color: labelTextColor
                    font.pixelSize: labelTextFontSize
                    text: labelText
                }

            } // end contentWinId Rectangle

            // 底部区域
            Rectangle {
                id: flootWinId

                width: parent.width
                height: flootBarHeight
                color: "transparent"
                radius: borderRadius

                // 居中确定按钮
                RoundButton {
                    id: okBtn1Id

                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        top: parent.top
                        topMargin: btnTopPadding
                    }

                    visible: (type == 0 ? true : false)
                    isChecked: true
                    enableChecked: false
                    labelText: "确定"
                    width: btnWidth
                    height: btnHeight
                    borderRadius: 4

                    onRoundButtonClick: {
                        endShow();
                        messageWindowBtnClick(true, sourceTag, ownerData);
                    }
                } // end okBtn1Id RoundButton

                // 确定按钮
                RoundButton {
                    id: okBtnId

                    anchors {
                        left: parent.left
                        leftMargin: parent.width / 5
                        top: parent.top
                        topMargin: btnTopPadding
                    }

                    visible: ((type == 1 || type == 2) ? true : false)
                    labelText: type === 1 ? "确定" : "是"
                    isChecked: true
                    enableChecked: false
                    width: btnWidth
                    height: btnHeight
                    borderRadius: 4

                    onRoundButtonClick: {
                        endShow();
                        msgBoxBtnClick(true, sourceTag, ownerData);
                    }

                } // end okBtnId RoundButton

                // 取消按钮
                RoundButton {
                    id: cancelBtnId

                    anchors {
                        right: parent.right
                        rightMargin: parent.width / 5
                        top: parent.top
                        topMargin: btnTopPadding
                    }

                    visible: ((type == 1 || type == 2) ? true : false)
                    labelText: type === 1 ? "取消" : "否"
                    isChecked: false
                    enableChecked: false
                    width: btnWidth
                    height: btnHeight
                    borderRadius: 4

                    onRoundButtonClick: {
                        endShow();
                        msgBoxBtnClick(false, sourceTag, ownerData);
                    }
                } // end cancelBtnId RoundButton

            } // end flootWinId Rectangle

        } // end Column

    } // end pageWinId Rectangle

    onOpened: {
        console.debug("MessageWindow.qml onOpened.");
    }

    onClosed: {
        console.debug("MessageWindow.qml onClosed.");
    }

    function beginShow(messageType, message, source = "", owner = null) {
        type = messageType;
        labelText = message;
        sourceTag = source
        ownerData = owner;

        controlId.open();
    }

    function endShow() {
        controlId.close();
    }

    function getOwner() {
        return ownerData;
    }

    function getSourceTag() {
        return sourceTag;
    }

}
