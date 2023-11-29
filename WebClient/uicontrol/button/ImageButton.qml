import QtQuick 2.0
import QtQuick.Controls 2.12

/*
 * ClassName: ImageButton
 * Desc: 图片按钮
 * Author: zfs
 * Date: 2023-10-19 07:23
 */

Rectangle {
    id: controlId

    signal imageButtonClicked();

    property var tipText: ""

    // 按钮文本
    property int labelTextFontSize: 14
    property var labelText: "" // 按钮文本
    property var labelTextColor: "#156EFF"

    property var backgroundColor: "transparent" // 背景颜色
    property int borderRadius: 4
    property var hoverOpacity: 0.8
    property bool hoverBorderVisiable: true
    property bool borderVisiable: false
    property int borderWidth: 1
    property var borderColor: "#CCCCCC"

    property var imgPath: "" // 图片文件路径路径

    // 图片显示的大小
    property int imgWidth: 14
    property int imgHeight: 2

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

    }

    // 居中显示
    Text {
        anchors.centerIn: parent

        visible: (labelText === "" ? false : true)
        font.pixelSize: labelTextFontSize
        color: labelTextColor

        text: labelText
    }

    ToolTip {
        id: toolTipId

        text: tipText
    }

    MouseArea {                             //处理鼠标事件
        anchors.fill: parent

        hoverEnabled: true                  //处理没有按下时的鼠标事件
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            imageButtonClicked();
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
