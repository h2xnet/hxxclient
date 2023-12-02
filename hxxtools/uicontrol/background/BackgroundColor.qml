import QtQuick 2.0
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0

/*
 * ClassName: BackgroudColor
 * Desc: 颜色曾背景控件
 * Author: zfs
 * Date: 2023-10-16 07:57
 */
Rectangle {
    id: controlId

    property var backgroundColor: "#FCFCFC"
    property int borderRadius: 4

    property int bordWidth: 1
    property var borderColor: "#CCCCCC"

    property var shadowColor: Qt.rgba(183/255, 183/255, 183/255, 0.43)

    anchors.fill: parent

    color: backgroundColor
    radius: borderRadius

    border.width: bordWidth
    border.color: borderColor

    // 窗口阴影
    /*DropShadow {
        anchors.fill: controlId

        source: controlId

        horizontalOffset: 2
        verticalOffset: 3
        radius: 7.0
        samples: 17
        spread: 0
        color: shadowColor
    }*/

}
