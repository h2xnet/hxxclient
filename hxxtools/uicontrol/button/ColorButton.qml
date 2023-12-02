import QtQuick 2.0
import QtQuick 2.0
import QtQuick.Controls 2.12

/*
 * ClassName: ColorButton
 * Desc: 颜色按钮
 * Author: zfs
 * Date: 2023-10-24 21:49
 */

Rectangle {
    id: controlId

    signal colorButtonClick();

    property var hoverOpacity: 0.5
    property int borderRadius: 8
    property bool enableChecked: true // 是否允许选中标志，false不允许，true允许
    property bool isChecked: false // 选中状态
    property bool mouseHover: false

    property int borderWidth: 1
    property var borderColor: "#156EFF"

    property int labelTextFontSize: 14
    property var labelText: "" // 按钮文本

    property var backgroundColor: "#FFFFFF"
    property var labelTextColor: "#156EFF"

    //property var customWhiteColor: "#FFFFFF"
    //property var custowmBlueColor: "#156EFF"

    // 文本对齐方式，默认居中对齐
    property bool labelAlimnLeft: false
    property int labelLeftPadding: 15

    radius: borderRadius
    border.width: (mouseHover ||isChecked) ? borderWidth : 0
    border.color: borderColor
    color: backgroundColor
    clip: true

    // 居中显示
    Text {
        anchors.centerIn: parent

        visible: !labelAlimnLeft
        font.pixelSize: labelTextFontSize
        color: labelTextColor

        text: labelText
    }

    // 左边显示
    Text {
        anchors {
            left: parent.left
            leftMargin: labelLeftPadding
            verticalCenter: parent.verticalCenter
        }

        visible: labelAlimnLeft
        font.pixelSize: labelTextFontSize
        color: labelTextColor

        text: labelText
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            if (enableChecked) {
                isChecked = !isChecked
            }

            colorButtonClick();
        }

         onEntered: {
             if (!isChecked) {
                controlId.opacity = hoverOpacity;
             }
             mouseHover = true;

         }

         onReleased: {
             controlId.opacity = 1.0;
             mouseHover = false;

         }

         onExited: {
            controlId.opacity = 1.0;
             mouseHover = false;

         }

    }

    function setChecked(state) {
        isChecked = state;
    }
    function getChecked() {
        return isChecked;
    }


}
