import QtQuick 2.0
import QtQuick.Controls 2.12

/*
 * ClassName: Switch
 * Desc: 开关控件
 * Author: zfs
 * Date: 2023-11-06 07:54
 */
Switch {
    id: controlId

    property int defWidth: 48
    property int defHeight: 26
    property int borderRadius: 12

    property int textLeftPadding: 12
    property var textColor: "#000000"

    property var defBackgroundColor: "#FFFFFF"
    property var checkedBackgroundColor: "#156eff"
    property var downloadBackgroundColor: "#CCCCCC"

    property var defBorderColor: "#CCCCCC"
    property var checkedBorderColor: "#156eff"

    property var disableOpacity: 0.3 // 禁用透明度

    indicator: Rectangle {
        implicitWidth: defWidth
        implicitHeight: defHeight
        x: controlId.leftPadding
        y: parent.height / 2 - height / 2
        radius: borderRadius
        color: controlId.checked ? checkedBackgroundColor : defBackgroundColor
        border.color: controlId.checked ? checkedBorderColor : defBorderColor

        Rectangle {
            x: controlId.checked ? parent.width - width : 0
            width: 26
            height: 26
            radius: 13
            color: controlId.down ? downloadBackgroundColor : defBackgroundColor
            border.color: controlId.checked ? (controlId.down ? checkedBorderColor : checkedBorderColor) : defBorderColor
        }
    }

    contentItem: Text {
        text: controlId.text
        font: controlId.font
        opacity: enabled ? 1.0 : disableOpacity
        color: controlId.down ? textColor : textColor
        verticalAlignment: Text.AlignVCenter
        anchors.top: indicator.bottom
        anchors.left: indicator.left
        anchors.leftMargin: textLeftPadding
    }

}
