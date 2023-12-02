import QtQuick 2.0
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12

/*
 * ClassName: SvgImageButton
 * Desc: SVG图标按钮
 * Author: zfs
 * Date: 2023-10-18 07:40
 */

Rectangle {
    id: controlId

    signal svgImageButtonClicked();

    property var tipText: ""

    property var backgroundColor: "transparent" // 背景颜色
    property int borderRadius: 4
    property var hoverOpacity: 0.8 // 高亮背景透明度
    property bool hoverBorderVisiable: true
    property bool borderVisiable: false
    property int borderWidth: 1
    property var borderColor: "#CCCCCC"

    property var imgPath: "" // 图片文件路径路径
    property var svgOverlayColor: "#156EFF" // 图片颜色

    // 图片显示的大小
    property int imgWidth: 14
    property int imgHeight: 15

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

    // 设置SVG颜色
    ColorOverlay {
        anchors.fill: imgId

        source: imgId
        color: svgOverlayColor
        transform: rotation
        antialiasing: true
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
            svgImageButtonClicked();
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

            if (hoverBorderVisiable && !borderVisiable) {
                controlId.border.width = 0;
                controlId.border.color = "transparent";
            }
        }
    }

}
