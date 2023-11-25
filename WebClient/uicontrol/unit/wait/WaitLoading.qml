import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

/*
 * ClassName: WaitLoading
 * Desc: 等待加载组件
 * Author: zfs
 * Date: 2023-10-29 08:55
 */
Popup {
    id: controlId

    property var imgPath: "qrc:/statics/imgs/animation/loading.gif"

    property int defWidth: 80
    property int defHeight: 80

    property var backgroundColor: "#00000000"
    property int borderRadius: 4

    anchors.centerIn: parent

    modal: true

    width: defWidth
    height: defHeight

    // 背景
    background: Rectangle {
         implicitWidth: parent.width
         implicitHeight: parent.height
         radius: borderRadius
         color: backgroundColor
     }

    Rectangle {

        width: defWidth
        height: defHeight
        radius: borderRadius
        color: "transparent"

        AnimatedImage{
            id: waitId

            anchors.fill: parent

            source: imgPath
        }

    }

    function beginShow() {
        if (!controlId.visible) {
            controlId.open();
        }
    }

    function endShow() {
        if (controlId.visible) {
            controlId.close();
        }
    }

}
