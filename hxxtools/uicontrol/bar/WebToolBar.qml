import QtQuick 2.0
import QtQuick.Controls 2.0

import "../button"

/*
 * ClassName: WebToolBar
 * Desc: WEB工具栏组件
 * Author: zfs
 * Date: 2023-10-30 07:16
 */
Rectangle {
    id: controlId

    signal webToolBarButtonClick(int idx, var obj);

    property var backgroundColor: "#C3C3C3" //Qt.rgba(127/255, 127/255, 127/255, 0.8)
    property int borderRadius: 4
    property int borderWidth: 1
    property var borderColor: "#DDDDDD"

    property int leftPadding: 10
    property int topPadding: 5
    property int rightPadding: 10
    property int bottomPadding: 5

    property int toolBtnSpaceWidth: 10
    property int toolBtnWidth: 40
    property int toolBtnHeight: 40
    property int toolBtnImageWidth: 32
    property int toolBtnImageHeight: 32

    property int toolBtnBorderRadius : 8
    property int toolBtnBorderWidth: 1
    property var toolBtnBorderColor: "#CCCCCC"
    property var toolBtnBackgroundColor: "transparent"

    // 移动区域
    property int moveAreaWidth: 40
    property var moveAreaBackgroundColor: "#FFFFFF"
    property var moveImagePath: "qrc:/statics/imgs/toolbar/move.png"

    property int winWidth: (leftPadding + rightPadding + moveAreaWidth + (toolBtnSpaceWidth + toolBtnWidth) * dataModelId.count)
    property int winHeight: (topPadding + bottomPadding + toolBtnHeight)

    ListModel {
        id: dataModelId
    }

    color: backgroundColor
    radius: borderRadius
    border.width: borderWidth
    border.color: borderColor
    width: winWidth
    height: winHeight

    // 按钮区域
    Rectangle {

        width: parent.width - rightPadding - moveAreaWidth
        height: parent.height
        radius: borderRadius
        color: "transparent"

        Row {

            anchors {
                left: parent.left
                leftMargin: leftPadding
                top: parent.top
                topMargin: topPadding
            }

            width: parent.width
            height: parent.height

            spacing: toolBtnSpaceWidth

            Repeater {
                model: dataModelId

                // 工具栏按钮
                ImageToolButton {

                    width: toolBtnWidth
                    height: toolBtnHeight
                    imgWidth: toolBtnImageWidth
                    imgHeight: toolBtnImageHeight
                    imgPath: imagePath
                    tipText: text
                    borderRadius: toolBtnBorderRadius
                    backgroundColor: toolBtnBackgroundColor
                    borderWidth: toolBtnBorderWidth
                    borderColor: toolBtnBorderColor

                    onImageToolButtonClick: {
                        onToolButtonClick(index);
                    }

                } // end ImageToolButton

            } // end Repeater

        } // end Row

    } // end Rectangle

    // 移动区域
    Rectangle {
        id: moveAreaId

        anchors {
            top: parent.top
            topMargin: topPadding
            right: parent.right
            rightMargin: rightPadding
        }
        width: moveAreaWidth
        height: toolBtnHeight
        radius: toolBtnBorderRadius
        color: moveAreaBackgroundColor
        border.width: toolBtnBorderWidth
        border.color: toolBtnBorderColor

        Image {

            anchors.centerIn: parent
            source: moveImagePath
            sourceSize.width: parent.width - 2 * toolBtnBorderWidth
            sourceSize.height: parent.height - 2 * toolBtnBorderWidth
        }

        MouseArea {
            id: mouseAreaId

            anchors.fill: parent

            property real lastX: 0
            property real lastY: 0
            property int lastPosX: 0
            property int lastPosY: 0

            //hoverEnabled: true
            //cursorShape: Qt.PointingHandCursor

            onPressed: {
                    lastX = mouseX
                    lastY = mouseY
                    lastPosX = mouseAreaId.x
                    lastPosY = mouseAreaId.y
            }

            onPositionChanged: {
                if (pressed) {
                    controlId.x += mouseX - lastX
                    controlId.y += mouseY - lastY
                }
            }

        }


    } // end moveAreaId Rectangle



    Component.onCompleted: {

    }

    Component.onDestruction: {

    }

    function init(list) {
        if (dataModelId.count > 0) {
            dataModelId.clear();
        }

        for(let idx = 0; idx < list.length; idx++) {
            let itemObj = list[idx];

            dataModelId.append(itemObj);
        }

        console.log("WebToolBar.qml init params, list:" + JSON.stringify(list));

    }

    function onToolButtonClick(idx) {
        console.log("WebToolBar.qml onToolButtonClick index:" + idx);

        let itemObj = dataModelId.get(idx);

        webToolBarButtonClick(idx, itemObj);
    }


}
