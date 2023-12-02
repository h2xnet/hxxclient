import QtQuick 2.0
import QtQuick.Controls 2.0

//import webClient.net.pc  1.0

import "../button"

/*
 * ClassName: TitleBar
 * Desc: 标题栏控件
 * Author: zfs
 * Date: 2023-10-16 08:16
 */
Rectangle {
    id: controlId

    signal systemMenuMinClick();
    signal systemMenuMaxClick();
    signal systemMenuCloseClick();

    // 标题栏基本信息
    property int defHeight: 60
    property int borderRadius: 4
    property var backgroundColor: "#F5F5F5"

    // 标题栏图标信息
    property var logoImgPath: "qrc:/statics/logo/logo.png"
    property int logoImgWidth: 32
    property int logoImgHeight: 32
    property int logoImgLeftPadding: 15
    property int logoImgTopPadding: 8

    // 标题栏标题信息
    property var titleText: "网络客户端"
    property var titleTextAlign: "left"
    property int titleTextLeftPadding: 55
    property int titleTextTopPadding: 15
    property int titleTextFontPixelSize: 18
    property var titleTextFontColor: "#FF2288"
    property bool titleTextFontBold: false

    // 最小化按钮
    property var systemMenuMinBtnId: "systemMenuMinId"
    property bool systemMenuMinBtnVisiable: true
    property var systemMenuMinBtnTipText: "最小化"
    property var systemMenuMinBtnImgPath: "qrc:/statics/imgs/minus.png"
    property int systemMenuMinBtnWidth: 24
    property int systemMenuMinBtnHeight: 24
    property int systemMenuMinBtnImgWidth: 14
    property int systemMenuMinBtnImgHeight: 14
    property var systemMenuMinBtnBackgroundColor: "transparent"
    property int systemMenuMinBtnTopPadding: 10
    property int systemMenuMinBtnRightPadding: 95
    property int systemMenuMinBtnBorderWidth: 1
    property var systemMenuMinBtnBorderColor: "#CCCCCC"
    property bool systemMenuMinBtnBorderVisiable: true
    property bool systemMenuMinBtnHoverBorderVisiable: false

    // 最大化按钮
    property var systemMenuMaxBtnId: "systemMenuMaxId"
    property bool systemMenuMaxBtnVisiable: true
    property var systemMenuMaxBtnTipText: "最大化"
    property var systemMenuMaxBtnImgPath: "qrc:/statics/imgs/maximize.png"
    property int systemMenuMaxBtnWidth: 24
    property int systemMenuMaxBtnHeight: 24
    property int systemMenuMaxBtnImgWidth: 14
    property int systemMenuMaxBtnImgHeight: 14
    property var systemMenuMaxBtnBackgroundColor: "transparent"
    property int systemMenuMaxBtnTopPadding: 10
    property int systemMenuMaxBtnRightPadding: 55
    property int systemMenuMaxBtnBorderWidth: 1
    property var systemMenuMaxBtnBorderColor: "#CCCCCC"
    property bool systemMenuMaxBtnBorderVisiable: true
    property bool systemMenuMaxBtnHoverBorderVisiable: false

    // 关闭按钮
    property var systemMenuCloseBtnId: "systemMenuCloseId"
    property bool systemMenuCloseBtnVisiable: true
    property var systemMenuCloseBtnTipText: "关闭"
    property var systemMenuCloseBtnImgPath: "qrc:/statics/imgs/close_svg.svg"
    property int systemMenuCloseBtnWidth: 24
    property int systemMenuCloseBtnHeight: 24
    property int systemMenuCloseBtnImgWidth: 14
    property int systemMenuCloseBtnImgHeight: 15
    property var systemMenuCloseBtnBackgroundColor: "transparent"
    property int systemMenuCloseBtnTopPadding: 10
    property int systemMenuCloseBtnRightPadding: 15
    property int systemMenuCloseBtnBorderWidth: 1
    property var systemMenuCloseBtnBorderColor: "#CCCCCC"
    property bool systemMenuCloseBtnBorderVisiable: true
    property bool systemMenuCloseBtnHoverBorderVisiable: false

    height: defHeight
    width: parent.width
    color: backgroundColor
    radius: borderRadius

    // 图标
    ImageButton {
        id: logoImgId

        anchors {
            left: parent.left
            leftMargin: logoImgLeftPadding
            top: parent.top
            topMargin: logoImgTopPadding
        }

        width: logoImgWidth
        height: logoImgHeight
        imgWidth: logoImgWidth
        imgHeight: logoImgHeight
        borderWidth: 0

        imgPath: logoImgPath
    }

    // 标题
    Text {
        id: titleTextId

        anchors {
            left: parent.left
            leftMargin: titleTextLeftPadding
            top: parent.top
            topMargin: titleTextTopPadding
        }

        visible: titleTextAlign === "left"

        text: titleText
        font.pixelSize: titleTextFontPixelSize
        font.bold: titleTextFontBold
        color: titleTextFontColor

    }

    Text {
        id: titleTextId2

        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }

        visible: titleTextAlign === "center"

        text: titleText
        font.pixelSize: titleTextFontPixelSize
        font.bold: titleTextFontBold
        color: titleTextFontColor

    }

    // 最小化按钮
    ImageButton {
        id: systemMenuMinBtnId

        anchors {
            top: parent.top
            topMargin: systemMenuMinBtnTopPadding
            right: parent.right
            rightMargin: systemMenuMinBtnRightPadding
        }

        visible: systemMenuMinBtnVisiable

        borderVisiable: systemMenuMinBtnBorderVisiable
        hoverBorderVisiable: systemMenuMinBtnHoverBorderVisiable

        borderWidth: systemMenuMinBtnBorderWidth
        borderColor: systemMenuMinBtnBorderColor

        backgroundColor: systemMenuMinBtnBackgroundColor

        imgPath: systemMenuMinBtnImgPath

        imgWidth: systemMenuMinBtnImgWidth
        imgHeight: systemMenuMinBtnImgHeight

        width: systemMenuMinBtnWidth
        height: systemMenuMinBtnHeight

        tipText: systemMenuMinBtnTipText

        onImageButtonClicked: function() {
            systemMenuMinClick();
        }

    } // end systemMenuMinBtnId ImageButton

    // 最大化按钮
    ImageButton {
        id: systemMenuMaxBtnId

        anchors {
            top: parent.top
            topMargin: systemMenuMaxBtnTopPadding
            right: parent.right
            rightMargin: systemMenuMaxBtnRightPadding
        }

        visible: systemMenuMaxBtnVisiable

        borderVisiable: systemMenuMaxBtnBorderVisiable
        hoverBorderVisiable: systemMenuMaxBtnHoverBorderVisiable

        borderWidth: systemMenuMinBtnBorderWidth
        borderColor: systemMenuMinBtnBorderColor

        backgroundColor: systemMenuMaxBtnBackgroundColor

        imgPath: systemMenuMaxBtnImgPath

        imgWidth: systemMenuMaxBtnImgWidth
        imgHeight: systemMenuMaxBtnImgHeight

        width: systemMenuMaxBtnWidth
        height: systemMenuMaxBtnHeight

        tipText: systemMenuMaxBtnTipText

        onImageButtonClicked: function() {
            systemMenuMaxClick();
        }

    } // end systemMenuMinBtnId ImageButton

    // 关闭按钮
    SvgImageButton {
        id: systemMenuCloseBtnId

        anchors {
            top: parent.top
            topMargin: systemMenuCloseBtnTopPadding
            right: parent.right
            rightMargin: systemMenuCloseBtnRightPadding
        }

        visible: systemMenuCloseBtnVisiable

        borderVisiable: systemMenuCloseBtnBorderVisiable
        hoverBorderVisiable: systemMenuCloseBtnHoverBorderVisiable

        borderWidth: systemMenuMinBtnBorderWidth
        borderColor: systemMenuMinBtnBorderColor

        backgroundColor: systemMenuCloseBtnBackgroundColor

        imgPath: systemMenuCloseBtnImgPath

        imgWidth: systemMenuCloseBtnImgWidth
        imgHeight: systemMenuCloseBtnImgHeight

        width: systemMenuCloseBtnWidth
        height: systemMenuCloseBtnHeight

        tipText: systemMenuCloseBtnTipText

        onSvgImageButtonClicked: function() {
            systemMenuCloseClick();
        }

    } // end systemMenuCloseBtnId SvgImageButton


}
