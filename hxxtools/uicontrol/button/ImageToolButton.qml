import QtQuick 2.0
import QtQuick.Controls 2.12

/*
 * ClassName: ImageToolButton
 * Desc: 图标工具按钮
 * Author: zfs
 * Date: 2023-10-30 21:20
 */

Rectangle {
    id: controlId

    signal imageToolButtonClick();

    property var tipText: ""

    property var backgroundColor: "#FFFFFF" // 背景颜色
    property int borderRadius: 8
    property var hoverOpacity: 0.8
    property bool hoverBorderVisiable: true
    property bool borderVisiable: false
    property int borderWidth: 1
    property var borderColor: "#CCCCCC"

    property var imgPath: "" // 图片文件路径路径

    // 图片显示的大小
    property int imgWidth: 64
    property int imgHeight: 64

    radius: borderRadius
    color: backgroundColor

    border.width: (borderVisiable ? borderWidth : 0)
    border.color: (borderVisiable ? borderColor : "transparent")

    Image {
        id: imgId

        anchors.centerIn: parent

        source: imgPath
        sourceSize.width: imgWidth
        sourceSize.height: imgHeight

    } // end imgId Image

    ToolTip {
        id: toolTipId

        text: tipText
    }

    MouseArea {                             //处理鼠标事件
        anchors.fill: parent

        hoverEnabled: true                  //处理没有按下时的鼠标事件
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            console.log("ImageToolButton.qml onClicked, tipText:" + tipText);
            imageToolButtonClick();
        }

        onEntered: {
            controlId.opacity = hoverOpacity;

            if (hoverBorderVisiable) {
                controlId.border.width = borderWidth;
                controlId.border.color = borderColor;
            }

            if (tipText !== "") {
                toolTipId.visible = true;
            }
        }
        onPressed: {
            controlId.opacity = hoverOpacity;

            if (hoverBorderVisiable) {
                controlId.border.width = borderWidth;
                controlId.border.color = borderColor;
            }
        }
        onExited: {
            controlId.opacity = 1.0;

            if (hoverBorderVisiable && !borderVisiable) {
                controlId.border.width = 0;
                controlId.border.color = "transparent";
            }

            toolTipId.visible = false;
        }
        onReleased: {
            controlId.opacity = 1.0;

            if (hoverBorderVisiable && borderVisiable) {
                controlId.border.width = 0;
                controlId.border.color = "transparent";
            }
        }
    }

}
