import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import "../../uicontrol/button"

/*
 * ClassName: JsonFormatContent
 * Desc: JSOn格式化页面
 * Author: zfs
 * Date: 2023-12-02 10:57
 */
Rectangle {
    id: controlId

    property int borderWidth: 0
    property int borderRadius: 8

    property int rowHeight: 50
    property int rowWidth: controlId.width
    property int labelLeftPadding: 10

    property int textInputWidth: 300
    property int textInputLeftPadding: 200

    // 选项属性
    property int optionHeight: 80


    anchors.fill: parent

    color: "transparent"

    Column {

        spacing: 5

        Rectangle {

            width: rowWidth
            height: rowHeight
            color: "transparent"

            Text {
                anchors {
                    left: parent.left
                    leftMargin: labelLeftPadding
                    verticalCenter: parent.verticalCenter
                }
                font.bold: true
                text: qsTr("转换前文件")
            }

            ColorButton {
                id: inputSourceFileBtnId

                anchors {
                    right: parent.right
                    rightMargin: 50
                    verticalCenter: parent.verticalCenter
                }

                width: 120
                height: 32
                labelText: "加载转换前文件"
            }

        } // end Row Rectangle

        Rectangle {

            width: rowWidth
            height: rowHeight
            color: "transparent"

            Text {
                anchors {
                    left: parent.left
                    leftMargin: labelLeftPadding
                    verticalCenter: parent.verticalCenter
                }
                font.bold: true
                text: qsTr("转换后文件")
            }

            ColorButton {
                id: saveDstFileBtnId

                anchors {
                    right: parent.right
                    rightMargin: 50
                    verticalCenter: parent.verticalCenter
                }

                width: 120
                height: 32
                labelText: "设置转换后文件"
            }

        } // end Row Rectangle

    } // end Column

    // 选项窗口
    Rectangle {
        id: optionWindId

        anchors {
            left: parent.left
            leftMargin: borderWidth
            bottom: parent.bottom
            bottomMargin: borderWidth
        }

        width: parent.width - 2 * borderWidth
        height: optionHeight
        color: "transparent"
        radius: borderRadius

        // 转换按钮
        Rectangle {

            anchors.centerIn: parent

            width: 160
            height: 45
            color: "transparent"

            LoadingButton {
                id: changeBtnid

                loading: false
                labelText: "格式化"

            } // end changeBtnid

        } // end Rectangle


    } // end optionWindId Rectangle

}
