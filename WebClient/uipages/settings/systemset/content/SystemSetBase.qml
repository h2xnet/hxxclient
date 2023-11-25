import QtQuick 2.0
import QtQuick.Controls 2.12

import webClient.net.pc  1.0

import "../../../../js/helper.js" as Helper;

import "../../../../uicontrol/list"

/*
 * ClassName: SystemSetBase
 * Desc: 系统基本设置
 * Author: zfs
 * Date: 2023-11-05 17:29
 */
Rectangle {
    id: controlId

    property int borderWidth: 1
    property int leftLabelWidth: 150
    property int optionTopPadding: 10

    property int optionRowHeight: 30
    property var optionBackgroundColor: "#FFFFFF"
    property int optionRowSpaceWidth: 10

    anchors.fill: parent

    color: "transparent"
    radius: 4

    Column {
        spacing: optionRowSpaceWidth

        width: controlId.width
        height: controlId.height

        // 选项顶部空距离
        Rectangle {
            width: controlId.borderWidth
            height: optionTopPadding
            color: "transparent"
        }

        // 默认最大化显示
        OptionRow {
            id: defMaximizedOptionId

            height: optionRowHeight
            rowHeight: optionRowHeight
            labelWinWidth: leftLabelWidth
            borderWidth: controlId.borderWidth
            backgroundColor: controlId.optionBackgroundColor

            labelText: "主窗口最大化"

            // 设置开关选项值
            valueType: 1
            switchCtrlId.checked: true

            onOptionRowSwitchCheckedChanged: function(isChecked) {
                console.log("SystemSetBase.qml onOptionRowSwitchCheckedChanged isChecked:" + isChecked);
                onDefMaximizedValueChanged(isChecked ? 1 : 0);
            }


        } // end OptionRow

        // 日志级别
        OptionRow {
            id: logOptionId

            height: optionRowHeight
            rowHeight: optionRowHeight
            labelWinWidth: leftLabelWidth
            borderWidth: controlId.borderWidth
            backgroundColor: controlId.optionBackgroundColor
            valueComboboxWidth: 160

            labelText: "日志级别"
            valueType: 2

            onOptionRowComboboxCurrentTextChanged: function(name) {
                console.log("SystemSetBase.qml onOptionRowComboboxCurrentTextChanged name:" + name);

                let idx = logOptionId.comboBoxCtrlId.getCurrentIndex();
                let logRange = logOptionId.comboBoxCtrlId.getItemExtentValue(idx, "value");

                console.log("SystemSetBase.qml onOptionRowComboboxCurrentTextChanged current idx:" + idx + ", value:" + logRange);

                onLogRangeValueChanged(logRange);

            }


        } // end OptionRow



    } // end Column

    Component.onCompleted: {
        console.log("SystemSetBase.qml Component.onCompleted");

        onInit();

    }

    Component.onDestruction: {
        console.log("SystemSetBase.qml Component.onDestruction");

    }

    function onInit() {

        // 默认最大化标志
        let defMax = GlobalHandlerId.getDefMaximized();
        console.log("SystemSetBase.qml onInit defMaximized:" + defMax);
        defMaximizedOptionId.switchCtrlId.checked = (defMax > 0) ? true : false;

        // 初始化日志
        let defLogRange = GlobalHandlerId.getLogRange(3);
        let logOptionList = Helper.getLogOptions();

        let defLogRangeIndex = 0;
        for(let idx = 0; idx < logOptionList.length; idx++) {
            let itemOptionObj = logOptionList[idx];
            if (defLogRange === itemOptionObj["value"]) {
                defLogRangeIndex = idx;
                break;
            }
        }

        logOptionId.comboBoxCtrlId.init(logOptionList, defLogRangeIndex);

    }

    //
    // onDefMaximizedValueChanged : 默认最大化值改变
    //
    function onDefMaximizedValueChanged(defMaximized) {
        console.debug("SystemSetBase.qml onDefMaximizedValueChanged params, defMaximized:" + defMaximized);
        GlobalHandlerId.setDefMaximized(defMaximized);

    }

    //
    // onLogRangeValueChanged : 日志级别发生改变
    //
    function onLogRangeValueChanged(logRange) {
        console.log("SystemSetBase.qml onLogRangeValueChanged params, logRange:" + logRange);
        let defLogRange = GlobalHandlerId.getLogRange(3);
        if (defLogRange !== logRange) {
            GlobalHandlerId.setLogRange(logRange);
        }

    }


}
