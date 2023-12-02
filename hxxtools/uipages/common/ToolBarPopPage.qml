import QtQuick 2.0
import QtQuick.Controls 2.12

import hxxTools.net.pc  1.0

import "../../uicontrol/button"

/*
 * ClassName: ToolBarPopPage
 * Desc: 工具栏弹出页面
 * Author: zfs
 * Date: 2023-12-02 10:29
 */
Popup {
    id: controlId

    property var event_id: ""
    property var event_param: ""

    property var backgroundColor: "#FFFFFF"
    property int borderRadius: 8
    property int borderWidth: 1
    property var borderColor: "#C3C3C3"

    property int titleBarHeight: 50

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


    modal: true

    x: 20
    y: 70
    width: parent.width - 40
    height: parent.height - 90
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

        // 标题栏
        Rectangle {
            id: titleWinId

            width: parent.width
            height: titleBarHeight
            color: "transparent"
            radius: borderRadius

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

                borderWidth: systemMenuCloseBtnBorderWidth
                borderColor: systemMenuCloseBtnBorderColor

                backgroundColor: systemMenuCloseBtnBackgroundColor

                imgPath: systemMenuCloseBtnImgPath

                imgWidth: systemMenuCloseBtnImgWidth
                imgHeight: systemMenuCloseBtnImgHeight

                width: systemMenuCloseBtnWidth
                height: systemMenuCloseBtnHeight

                tipText: systemMenuCloseBtnTipText

                onSvgImageButtonClicked: function() {
                    endShow();
                }

            } // end systemMenuCloseBtnId SvgImageButton

        } // end titleWinId Rectangle

        StackView {
            id: stackViewId

            anchors {
                left: parent.left
                leftMargin: borderWidth
                top: parent.top
                topMargin: titleBarHeight
            }
            //anchors.fill: parent
            width: parent.width - 2 * borderWidth
            height: parent.height - titleBarHeight - 2 * borderWidth

        }


    }


    Component.onCompleted: {
        console.log("Settings.qml onCompleted");

        //onSwitchPage();

    }

    Component.onDestruction: {
        console.log("Settings.qml onDestruction");

    }



    function beginShow(eventId, params) {
        console.log("Setting.qml beginShow");
        if (!controlId.opened) {
            controlId.open();
        }

        event_id = eventId
        event_param = params;

        onSwitchPage();
    }

    function endShow() {
        console.log("ToolBarPopPage.qml endShow");
        if (controlId.opened) {
            controlId.close();
        }
    }

    //
    // onSwitchPage : 切换页面
    //
    function onSwitchPage() {
         console.log("ToolBarPopPage.qml onSwitchPage");

        //let pageUrl = "qrc:/uipages/settings/content/SettingsPage.qml"
        let pageUrl = '';

        if (event_id === "jsonBtnId") {
            pageUrl = "qrc:/uipages/content/JsonFormatContent.qml";
        }

        console.log("ToolBarPopPage.qml onSwitchPage pageUrl:" + pageUrl);

        if (pageUrl !== "") {
            stackViewId.clear();
            stackViewId.push(pageUrl, {parentControl: controlId, pageParam: event_param});

        }

    }



}

