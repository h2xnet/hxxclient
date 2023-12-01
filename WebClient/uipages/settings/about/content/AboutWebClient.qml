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

    property var blueColor: "#156EFF"

    property var titleBarText: "" // 客户端名称
    property int titleBarHeight: 35

    property var logoImg: "" // logo

    // 版本信息
    property var version: "0.1.0.0"
    property var builder: ""

    property int labelLeftPadding: 120
    property int labelFontPixelSize1: 22
    property int labelFontPixelSize2: 18

    // 运行系统信息
    property var runOS: ""
    property var runOSVer: ""
    property var githubUrl: ""
    property var giteeUrl: ""

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
        /*Image {
            id: logoImgId

            anchors {
                left: parent.left
                leftMargin: 10
                verticalCenter: parent.verticalCenter
            }

            source: logoImg
            sourceSize.width: 24
            sourceSize.height: 24
        }*/

        Text {
            id: labelTextId

            anchors {
                left: parent.left
                leftMargin: 10
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

    } // end titleBarWinId Rectangle

    Rectangle {
        id: bodyWinId

        anchors {
            left: parent.left
            leftMargin: 0
            top: parent.top
            topMargin: titleBarHeight
        }

        width: parent.width
        height: parent.height - titleBarHeight
        color: "transparent"
        radius: borderRadius

        // logo 大图
        Image {
            id: aboutBigLogoImgId

            anchors {
                left: parent.left
                leftMargin: 30
                top: parent.top
                topMargin: 30
            }

            source: logoImg
            sourceSize.width: 64
            sourceSize.height: 64

        }

        // 客户端名称
        Text {
            id: clientNameLabelId

            anchors {
                left: parent.left
                leftMargin: labelLeftPadding
                top: parent.top
                topMargin: 30
            }

            text: titleBarText
            color: blueColor
            font.pixelSize: labelFontPixelSize1
        }

        // 版本信息
        Text {
            id: versionId

            anchors {
                left: parent.left
                leftMargin: labelLeftPadding
                top: parent.top
                topMargin: 80
            }
            text: "版本：V" + version + "（" + builder + "）"
            font.pixelSize: labelFontPixelSize2
        }

        // 运行系统
        Text {
            id: runOsId

            anchors {
                left: parent.left
                leftMargin: labelLeftPadding
                top: parent.top
                topMargin: 110
            }
            text: "环境信息：" + runOS
            font.pixelSize: labelFontPixelSize2
        }

        // 运行系统版本
        Text {
            id: runOSVerId

            anchors {
                left: parent.left
                leftMargin: labelLeftPadding
                top: parent.top
                topMargin: 140
            }
            text: "环境版本：" + runOSVer
            font.pixelSize: labelFontPixelSize2
        }

        // Github 按钮
        ImageButton {
            id: giteeBtnId

            anchors {
                left: parent.left
                leftMargin: 80
                bottom: parent.bottom
                bottomMargin: 30
            }

            visible: giteeUrl === "" ? false : true
            imgPath: "qrc:/statics/imgs/gray_button_normal.png"
            borderWidth: 0
            imgWidth: 120
            imgHeight: 50
            width: 120
            height: 50
            borderRadius: 8
            labelText: "Github"
            labelTextFontSize: 24
            labelTextColor: "#FFFFFF"

            onImageButtonClicked: {

                onGiteeBtnClick();

            }

        } // end giteeBtnId ImageButton

        // Github 按钮
        ImageButton {
            id: githubBtnId

            anchors {
                right: parent.right
                rightMargin: 80
                bottom: parent.bottom
                bottomMargin: 30
            }

            visible: githubUrl === "" ? false : true
            imgPath: "qrc:/statics/imgs/blue_button_normal.png"
            borderWidth: 0
            imgWidth: 120
            imgHeight: 50
            width: 120
            height: 50
            borderRadius: 8
            labelText: "Github"
            labelTextFontSize: 24
            labelTextColor: "#FFFFFF"

            onImageButtonClicked: {

                onGithubBtnClick();

            }

        } // end githubBtnId ImageButton


    } // end bodyWinId Rectangle



    Component.onCompleted: {
        controlId.logoImg = AppId.getTitleBarLogoImg();
        console.log("AboutWebClient.qml Component.onCompleted logoImg:" + controlId.logoImg);

        controlId.titleBarText = AppId.getClientName();
        console.log("AboutWebClient.qml Component.onCompleted titleBarText:" + controlId.titleBarText);

        // 版本信息
        controlId.version = AppId.getVersion();
        controlId.builder = AppId.getBuilder();

        controlId.runOS = AppId.getRunOS();
        controlId.runOSVer = AppId.getRunOSVer();

        controlId.githubUrl = AppId.getGithubUrl();
        controlId.giteeUrl = AppId.getGiteeUrl();

    }

    Component.onDestruction: {

    }

    function onGiteeBtnClick() {
        if (parentControl) {
            parentControl.gotoGitee(controlId.giteeUrl);
        }
    }

    //
    // Github goto
    //
    function onGithubBtnClick() {
        if (parentControl) {
            parentControl.gotoGithub(controlId.githubUrl);
        }
    }

}
