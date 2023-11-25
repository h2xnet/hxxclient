import QtQuick 2.0
import QtQuick.Controls 2.12

import webClient.net.pc  1.0

import "../../../uicontrol/button"

/*
 * ClassName: SystemSet
 * Desc: 系统设置页面
 * Author: zfs
 * Date: 2023-11-05 15:11
 */
Popup {
    id: controlId

    property int bodyWidth: 480
    property int bodyHeight: 360
    property int borderWidth: 0
    property int borderRadius: 4
    property var borderColor: "#CCCCCC"
    property var backgroundColor: "#FFFFFF"

    property int titleBarHeight: 35
    property var titleBarText: ""
    property var logoImg: ""

    property int leftPanelWidth: 100
    property int leftPanelBtnSpaceWidth: 0

    property int leftPanelBtnHeight: 30
    property int leftPanelBtnWidth: 80

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

    // 真正内容窗口
    Rectangle {
        id: bodyWinId

        anchors.centerIn: parent

        width: bodyWidth
        height: bodyHeight
        radius: borderRadius
        color: "transparent"

        // 标题栏
        Rectangle {
            id: titleBarWinId

            anchors {
                left: parent.left
                leftMargin: borderWidth
                top: parent.top
                topMargin: borderWidth
            }

            width: parent.width - 2 * borderWidth
            height: titleBarHeight
            radius: borderRadius
            color: "transparent"
            border.width: borderWidth
            border.color: borderColor
            clip: true

            Image {
                id: logoImgId

                anchors {
                    left: parent.left
                    leftMargin: 10
                    verticalCenter: parent.verticalCenter
                }

                source: logoImg
                sourceSize.width: 24
                sourceSize.height: 24
            }

            Text {
                id: labelTextId

                anchors {
                    left: parent.left
                    leftMargin: 40
                    verticalCenter: parent.verticalCenter
                }

                text: titleBarText
                font.pixelSize: 14
                font.bold: true
            }

            // 关闭按钮
            SvgImageButton {
                id: closeBtnId

                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: 15
                }

                visible: true

                borderVisiable: false
                hoverBorderVisiable: true

                borderWidth: 1
                borderColor: "#CCCCCC"

                backgroundColor: "transparent"

                imgPath: "qrc:/statics/imgs/close_svg.svg"

                imgWidth: 14
                imgHeight: 15

                width: 24
                height: 24

                //tipText: ""

                onSvgImageButtonClicked: function() {
                    endShow();
                }

            } // end systemMenuCloseBtnId SvgImageButton

        } // end

        // 左侧面板
        Rectangle {
            id: leftPanelWinId

            anchors {
                left: parent.left
                leftMargin: borderWidth
                top: parent.top
                topMargin: borderWidth + titleBarHeight
            }

            width: leftPanelWidth
            height: parent.height - titleBarHeight - 2 * borderWidth
            color: "transparent"
            radius: borderRadius

            Column {

                width: leftPanelWinId.width
                height: leftPanelWinId.height

                spacing: leftPanelBtnSpaceWidth

                Rectangle {
                    id: baseSetWinId

                    width: leftPanelWinId.width - leftPanelBtnSpaceWidth
                    height: leftPanelBtnHeight
                    color: "transparent"
                    radius: borderRadius

                    ColorButton {
                        anchors.centerIn: parent

                        enableChecked: false
                        labelAlimnLeft: true
                        borderRadius: controlId.borderRadius
                        width: parent.width
                        height: leftPanelBtnHeight
                        labelText: "基础设置"

                        onColorButtonClick: {
                            onLeftPanelBtnClick("baseSetId");
                        }

                    } // end ColorButton

                } // end Rectangle

                /*Rectangle {
                    id: downloadSetWinId

                    width: leftPanelWinId.width - leftPanelBtnSpaceWidth
                    height: leftPanelBtnHeight
                    color: "transparent"
                    radius: borderRadius

                    ColorButton {
                        anchors.centerIn: parent

                        enableChecked: false
                        labelAlimnLeft: true
                        borderRadius: controlId.borderRadius
                        width: parent.width
                        height: leftPanelBtnHeight
                        labelText: "下载"

                        onColorButtonClick: {
                            onLeftPanelBtnClick("downloadSetId");
                        }

                    } // end ColorButton

                } // end Rectangle*/




            } // end Column

        } // end leftPanelWinId Rectangle

        // 右侧内容
        Rectangle {
            id: rightPageWinId

            anchors {
                left: parent.left
                leftMargin: leftPanelWidth + borderWidth
                top: parent.top
                topMargin: titleBarHeight + borderWidth
            }

            width: parent.width - leftPanelWidth - 2 * borderWidth
            height: parent.height - titleBarHeight - 2 * borderWidth
            color: "transparent"
            radius: borderRadius

            StackView {
                id: stackViewId

                anchors.fill: parent

                //width: parent.width
                //height: parent.height

            } // end stackViewId StackView

        } // end rightPageWinId Rectangle

    } // end bodyWinId Rectangle

    onOpened: {
        console.log("SystemSet.qml onOpened");

        controlId.logoImg = AppId.getTitleBarLogoImg();
        console.log("SystemSet.qml Component.onCompleted logoImg:" + controlId.logoImg);

        onLeftPanelBtnClick("baseSetId");

    }

    onClosed: {
        console.log("SystemSet.qml onClosed")

    }

    function beginShow() {
        console.log("SystemSet.qml beginShow");
        if (!controlId.opened) {
            controlId.open();
        }

    }

    function endShow() {
        console.log("SystemSet.qml endShow");
        if (controlId.opened) {
            controlId.close();
        }
    }

    //
    // onInit: 初始化
    //
    function onLeftPanelBtnClick(id) {
        console.log("SystemSet.qml onLeftPanelBtnClick params, id:" + id);

        stackViewId.clear();

        let pageUrl = "";
        if (id === "baseSetId") {
            // 基础设置
            titleBarText = "基础设置"

            pageUrl = "qrc:/uipages/settings/systemset/content/SystemSetBase.qml";

        }

        console.log("SystemSet.qml onLeftPanelBtnClick pageUrl:" + pageUrl);

        if (pageUrl !== "") {
            stackViewId.push(pageUrl, {parentControl: controlId});
        }

    }

}
