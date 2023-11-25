import QtQuick 2.0
import QtQuick.Controls 2.0

import webClient.net.pc  1.0

import "../button"

/*
 * ClassName: StatusBar
 * Desc: 状态栏控件
 * Author: zfs
 * Date: 2023-10-24 08:14
 */
Rectangle {
    id: controlId

    // 标题栏基本信息
    property int defHeight: 40
    property int borderRadius: 4
    property var backgroundColor: "#F5F5F5"
    property int borderWidth: 1
    property var borderColor: "#CCCCCC"

    color: backgroundColor
    radius: borderRadius
    border.width: borderWidth
    border.color: borderColor

    height: defHeight
    width: parent.width

}
