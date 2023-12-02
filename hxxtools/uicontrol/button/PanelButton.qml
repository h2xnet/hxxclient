import QtQuick 2.0
import QtQuick.Controls 2.12

/*
 * ClassName: PanelButton
 * Desc: 面板按钮
 * Author: zfs
 * Date: 2023-10-22 09:05
 */

Rectangle {
    id: controlId

    signal panelButtonClick();

    property int btnIndex: -1 // 保存按钮序号

    property bool allowCancel: false // 是否允许取消标志
    property bool allowChecked: true // 允许选中
    property bool isChecked: false // 选中状态

    property bool foldState: true
    property int btnFoldWidth: 120
    property int btnUnfoldWidth: 200
    property int btnHeight: 60

    property var backgroundColor: "transparent" // 背景颜色
    property var checkedBackgroundColor: "#FCFCFC" // 选中后的背景颜色

    property int borderRadius: 4
    property var hoverOpacity: 0.8

    property int borderWidth: 1
    property var borderColor: "#CCCCCC"

    property var btnTipText: ""
    property int btnTextLeftPadding: 80
    property int btnTextFontPixelSize: 16
    property var btnTextFontColor: "#333333"
    property bool btnTextBold: false

    property var btnImgPath: ""
    property int btnImgWidth: 64
    property int btnImgHeight: 64
    property int btnImgLeftPadding: 10
    property int btnImgTopPadding: 10


    width: (foldState ? btnFoldWidth : btnUnfoldWidth)
    height: btnHeight
    color: (isChecked ? checkedBackgroundColor : backgroundColor)
    radius: borderRadius
    border.width: borderWidth
    border.color: borderColor
    clip: true

    // 图片
    Image {
        id: btnImgId

        anchors {
            left: parent.left
            leftMargin: btnImgLeftPadding
            top: parent.top
            topMargin: btnImgTopPadding
        }

        source: btnImgPath
        sourceSize.width: btnImgWidth
        sourceSize.height: btnImgHeight
    }

    // 文本
    Text {
        id: btnTextId

        anchors {
            left: parent.left
            leftMargin: btnTextLeftPadding
            verticalCenter: parent.verticalCenter
        }

        visible: !foldState

        text: btnTipText
        font.pixelSize: btnTextFontPixelSize
        color: btnTextFontColor
        width: parent.width - btnTextLeftPadding - borderWidth
        wrapMode: Text.NoWrap
        elide: Text.ElideRight

    }

    ToolTip {
        id: toolTipId

        x: parent.width + 2
        y: parent.height - 4

        text: btnTipText
    }

    MouseArea {
        anchors.fill: parent

        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            if (!allowCancel) {
                if (isChecked) {
                    return;
                }
            }

            if (allowChecked) {
                isChecked = !isChecked;
            }

            toolTipId.visible = false;

            panelButtonClick();
        }

        onEntered: {
            if (!isChecked) {
                controlId.opacity = hoverOpacity;

            }

            if (btnTipText !== "") {
                toolTipId.visible = true;
            }

        }
        onPressed: {
            if (!isChecked) {
                controlId.opacity = hoverOpacity;

            }

        }
        onExited: {
            if (!isChecked) {
                controlId.opacity = 1.0;
            }

            toolTipId.visible = false;

        }
        onReleased: {
            if (!isChecked) {
                controlId.opacity = 1.0;

            }

        }

    }

    function setFoldState(state) {
        foldState = state;
    }

    function setChecked(checked) {
        isChecked = checked;
    }

    function getChecked() {
        return isChecked;
    }

}
