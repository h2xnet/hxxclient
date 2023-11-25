import QtQuick 2.0
import QtQuick.Controls 2.12

import webClient.net.pc  1.0

import "../../../../js/helper.js" as Helper;

import "../../../../uicontrol/list"
import "../../../../uicontrol/button"

/*
 * ClassName: AboutWebClient
 * Desc: 关于网络客户端
 * Author: zfs
 * Date: 2023-11-21 09:22
 */
Rectangle {
    id: controlId

    property var parentControl: null

    property int borderWidth: 0
    property int borderRadius: 4
    property var borderColor: "#CCCCCC"

    property var titleBarText: "关于智慧客户端"
    property int titleBarHeight: 35

    property var logoImg: ""

    anchors.fill: parent

    color: "transparent"
    radius: borderRadius

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

        // logo
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


    Component.onCompleted: {
        controlId.logoImg = AppId.getTitleBarLogoImg();
        console.log("AboutWebClient.qml Component.onCompleted logoImg:" + controlId.logoImg);
    }

    Component.onDestruction: {

    }

}
