import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.3

import hxxTools.net.pc  1.0

import "../../uicontrol/button"

/*
 * ClassName: JsonFormatContent
 * Desc: JSOn格式化页面
 * Author: zfs
 * Date: 2023-12-02 10:57
 */
Rectangle {
    id: controlId

    property var sourJsonFileName: ""
    property var targetJsonFileName: ""

    property int borderWidth: 0
    property int borderRadius: 8

    property int rowHeight: 50
    property int rowWidth: controlId.width
    property int labelLeftPadding: 10

    // 文本框属性
    property int textBorderWidth: 1
    property int textBorderRadius: 8
    property var textBorderColor: "#CCCCCC"
    property int textMargin: 5

    property int textLeftPadding: 100
    property int textWidth: 600
    property int textHeight: 35

    property int actionLeftPadding: 720

    property var errorMsg: ""
    property var errorTextColor: "#FF2222"

    // 最后打开文件夹位置
    property var lastFolder: ""


    // 选项属性
    property int optionHeight: 80

    FileDialog {
        id: fileDialog

        title: "加载JSON文件"
        folder: lastFolder == "" ? shortcuts.desktop : lastFolder
        selectExisting: true
        selectMultiple: false
        nameFilters: ["Json files (*.json)", "Text files (*.txt)", "All files (*.*)"]

        onAccepted: {
            let strFileUrl = fileDialog.fileUrl;
            console.log("JsonFormatContent.qml fileDialog chose: " + strFileUrl);

            // 处理所选文件的逻辑
            controlId.sourJsonFileName = strFileUrl;
            controlId.lastFolder = GlobalHandlerId.getFilePath(controlId.sourJsonFileName);
        }

        onRejected: {
            console.log("JsonFormatContent.qml fileDialog Canceled")
        }
    }

    FileDialog {
        id: saveFileDialog

        title: "保存格式化后JSON文件"
        folder: lastFolder == "" ? shortcuts.desktop : lastFolder
        selectExisting: false
        selectMultiple: false
        nameFilters: ["Json files (*.json)", "Text files (*.txt)", "All files (*.*)"]

        onAccepted: {
            let strFileUrl = saveFileDialog.fileUrl;
            console.log("sonFormatContent.qml saveFileDialog onAccepted chose: " + strFileUrl)
            // 处理所选文件的逻辑

            controlId.targetJsonFileName = strFileUrl;
            controlId.lastFolder = GlobalHandlerId.getFilePath(controlId.targetJsonFileName);
        }

        onFileUrlChanged: {
            let strFileUrl = saveFileDialog.fileUrl;
            console.log("sonFormatContent.qml saveFileDialog onFileUrlChanged chose: " + strFileUrl)

            controlId.targetJsonFileName = strFileUrl;
            controlId.lastFolder = GlobalHandlerId.getFilePath(controlId.targetJsonFileName);
        }

        onRejected: {
            console.log("sonFormatContent.qml saveFileDialog Canceled")
        }
    }


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

            // 文本输入区域
            Rectangle {

                anchors {
                    left: parent.left
                    leftMargin: textLeftPadding
                    verticalCenter: parent.verticalCenter
                }

                width: textWidth
                height: textHeight
                color: "transparent"
                radius: textBorderRadius
                border.width: textBorderWidth
                border.color: textBorderColor

                Text {

                    anchors.centerIn: parent

                    width: textWidth - 2 * textMargin
                    height: textHeight - 2 * textMargin
                    wrapMode: Text.NoWrap
                    elide: Text.ElideRight
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    text: sourJsonFileName
                }

            }

            ColorButton {
                id: inputSourceFileBtnId

                anchors {
                    left: parent.left
                    leftMargin: actionLeftPadding
                    verticalCenter: parent.verticalCenter
                }

                width: 120
                height: 32
                labelText: "加载转换前文件"

                onColorButtonClick: {
                    onLoadJsonFile();
                }

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

            // 文本输入区域
            Rectangle {

                anchors {
                    left: parent.left
                    leftMargin: textLeftPadding
                    verticalCenter: parent.verticalCenter
                }

                width: textWidth
                height: textHeight
                color: "transparent"
                radius: textBorderRadius
                border.width: textBorderWidth
                border.color: textBorderColor

                TextInput {

                    anchors.centerIn: parent

                    width: textWidth - 2 * textMargin
                    height: textHeight - 2 * textMargin
                    wrapMode: Text.NoWrap
                    //elide: Text.ElideRight
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    text: targetJsonFileName
                }

            }

            ColorButton {
                id: saveDstFileBtnId

                anchors {
                    left: parent.left
                    leftMargin: actionLeftPadding
                    verticalCenter: parent.verticalCenter
                }

                width: 120
                height: 32
                labelText: "设置转换后文件"

                onColorButtonClick: {
                    onSetSaveFile();
                }
            }

        } // end Row Rectangle

        // 错误信息
        Rectangle {
            id: errorWinId

            visible: (errorMsg === "" ? false : true)
            width: rowWidth
            height: rowHeight
            color: "transparent"
            radius: borderRadius

            Text {
                id: errorMsgTextId

                anchors {
                    left: parent.left
                    leftMargin: textLeftPadding
                    verticalCenter: parent.verticalCenter
                }

                color: errorTextColor
                text: errorMsg
            }

        } // end errorWinId Rectangle

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

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    onChangeFormat();
                }
            }

        } // end Rectangle


    } // end optionWindId Rectangle

    Component.onCompleted: {

    }

    Component.onDestruction: {

    }

    function setErrorMsg(msg) {
        errorMsg = msg;
    }

    function getErrorMsg() {
        return errorMsg;
    }

    //
    // onLoadJsonFile : 加载JSON文件
    //
    function onLoadJsonFile() {
        fileDialog.open();
    }

    //
    // onSetSaveFile : 设置保存文件
    //
    function onSetSaveFile() {
        saveFileDialog.open();
    }

    //
    // onChangeFormat : 转换格式
    //
    function onChangeFormat() {
        setErrorMsg("");
        if (controlId.sourJsonFileName === "") {
            setErrorMsg("请加载转换前文件");
            return;
        }

        if (controlId.targetJsonFileName === "") {
            setErrorMsg("请设置转换后文件");
            return;
        }

        // 开始转换
        setErrorMsg("格式化...");
        changeBtnid.loading = true;

        let tmpInputFileName = GlobalHandlerId.fileNameToNative(controlId.sourJsonFileName);
        let tmpOutputFileName = GlobalHandlerId.fileNameToNative(controlId.targetJsonFileName);

        let ret = GlobalHandlerId.jsonFileFormat(tmpInputFileName,
                                                 tmpOutputFileName);

         changeBtnid.loading = false;

        console.log("JsonFormatContent.qml onChangeFormat jsonFileFormat status:" + ret);

        if (ret === -1) {
            setErrorMsg("格式化参数错误");
        }
        else if (ret === -2) {
            setErrorMsg("格式化输入文件为空");
        }
        else if (ret === -3) {
            setErrorMsg("格式化出文件创建失败");
        }
        else if (ret === -4) {
            setErrorMsg("文件内容JSON格式错误");
        }
        else if (ret === 0) {
            setErrorMsg("格式化成功");
        }
        else {
            setErrorMsg("格式化失败");
        }

    }


}
