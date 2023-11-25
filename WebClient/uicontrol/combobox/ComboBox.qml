import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

/*
 * ClassName: ComboBox
 * Desc: 定制下拉列表框
 * Author: zfs
 * Date: 2023-11-08 07:18
 */
ComboBox {
    id: controlId

    // 当前选中值发生改变
    signal comboBoxCurrentTextChanged(string value);

    property var defDisplayText: "" // 默认显示名
    property var textRoleName: "name"
    property int ctrlWidth: 90
    property int ctrlHeight: 30
    property int dropDownHeight: 120
    property var bkColor: "#FFFFFF"
    property int borderWidth: 1
    property var borderColor: "#CCCCCC"
    property int borderRadius: 2
    property var highLightBkColor: "#CCCCCC"    // 高亮背景颜色
    property var fontFamily: "Microsoft YaHei UI"
    property int textPixelSize: 14
    property var textColor: "#999999"
    property int displayTextPadLeft: 15 // 选中文本缩进
    property int textPadLeft: 18 // 下拉列表文本缩进

    ListModel {
        id: dataModel
    }

    textRole: textRoleName
    model: dataModel

    width: ctrlWidth
    height: ctrlHeight

    // 下拉列表框项
    delegate: ItemDelegate {
        width: controlId.width

        contentItem: Text {
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: textPadLeft
            }
            font.family: fontFamily
            font.pixelSize: textPixelSize
            color: textColor
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
            text: {
                /*modelData*/
                let itemObj = dataModel.get(index);
                return (itemObj !== null && itemObj !== undefined) ? itemObj[textRoleName] : ""
            }
        }

        // 高亮
        highlighted: controlId.highlightedIndex === index
    }

    // 选中项
    contentItem: Text {

        anchors {
            verticalCenter: parent.verticalCenter
            left: controlId.left
            leftMargin: displayTextPadLeft
        }

        font.family: fontFamily
        font.pixelSize: textPixelSize
        color: textColor
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        text: controlId.displayText
    }

    // 选中项向下箭头
    indicator: Image {
        anchors {
            verticalCenter: controlId.verticalCenter
            right: controlId.right
            rightMargin: 11
        }
        sourceSize.width: 12
        sourceSize.height: 12
        source: "qrc:/image/mainFrame/turnpage_bottom.png"
    }

    // 选中项背景
    background: Rectangle {
        width: controlId.width
        height: controlId.height
        color: bkColor
        border.width: borderWidth
        border.color: borderColor
        radius: borderRadius
    }

    // 弹出窗口
    popup: Popup {
        y: controlId.height
        padding: 2

        width: controlId.width
        implicitHeight: contentItem.implicitHeight
        //implicitHeight: listViewId.implicitHeight

        contentItem: ListView {
            id: listViewId

            model: controlId.popup.visible ? controlId.delegateModel : null

            implicitHeight: contentHeight
            currentIndex: controlId.highlightedIndex

            clip: true
        }

        background: Rectangle {
            color: bkColor
            border.width: borderWidth
            border.color: borderColor
            radius: borderRadius
        }
    }

    onCurrentIndexChanged: {
        let itemObj = dataModel.get(currentIndex);
        if (itemObj !== null) {
            let itemDisplayText = itemObj[textRoleName];
            controlId.displayText = itemDisplayText;
        }
    }

    //
    // 选中值发生变化
    //

    onCurrentTextChanged: {
        comboBoxCurrentTextChanged(controlId.displayText);
    }

    onDisplayTextChanged: {
        //comboBoxExCurrentTextChanged(controlId.displayText);
    }

    function init(list, selIndex) {
        console.log("ComboBox.qml init list : " + JSON.stringify(list) + ", selIndex:" + selIndex)

        dataModel.clear();

        if (list !== null && list !== undefined && list.length > 0) {
            for(let idx = 0; idx < list.length; idx++) {
                let itemObj = list[idx];
                dataModel.append(itemObj)
            }

            if (selIndex >= 0 && selIndex < list.length) {
                controlId.currentIndex = selIndex
            }
        }

        if (selIndex < 0 || selIndex >= dataModel.count) {
            // 默认显示名
            controlId.displayText = defDisplayText
        }

    }

    //
    // getItemData : 获取当前选中项数据对象
    //
    function getItemData(getIdx = -1) {
        let idx =  getIdx === -1 ? controlId.currentIndex : getIdx;
        if (idx >= 0 && idx < dataModel.count) {
            return dataModel.get(idx);
        }
        return null;
    }

    //
    // getExtentValue : 获取指定扩展值
    //
    function getExtentValue(key) {
        if (key === undefined || key === null || key === "") {
            return null;
        }

        let idx = controlId.currentIndex;
        if (idx >= 0 && idx < dataModel.count) {
            let itemObj = dataModel.get(idx);
            if (itemObj !== undefined && itemObj !== null) {
                return itemObj[key];
            }
        }

        return null;
    }

    //
    // getCurrentIndex : 获取当前选中项
    //
    function getCurrentIndex() {
        return controlId.currentIndex;
    }

    //
    // getItemExtentValue : 获取指定项扩展值
    //
    function getItemExtentValue(index, key) {
        if (key === undefined || key === null || key === "") {
            return null;
        }

        if (index < 0 || index >= dataModel.count) {
            return null;
        }

        let idx = index;
        if (idx >= 0 && idx < dataModel.count) {
            let itemObj = dataModel.get(idx);
            //console.log("ComboBox.qml getItemExtentValue item: " + JSON.stringify(itemObj))
            if (itemObj !== undefined && itemObj !== null) {
                return itemObj[key];
            }
        }

        return null;
    }

} // end controlId Rectangle

