import QtQuick 2.0
import QtQuick.Controls 2.12



import "../switch"
import "../combobox"

/*
 * ClassName: OptionRow
 * Desc: 选项行控件
 * Author: zfs
 * Date: 2023-11-06 07:20
 */
Rectangle {
    id: controlId

    signal optionRowSwitchCheckedChanged(bool isChecked);
    signal optionRowComboboxCurrentTextChanged(string value);

    property alias switchCtrlId: switchId
    property alias comboBoxCtrlId: comboBoxId

    property int rowHeight: 30
    property int borderWidth: 1
    property int borderRadius: 4
    property var backgroundColor: "#FFFFFF"

    // 选项标签属性
    property int labelWinWidth: 200
    property var labelText: ""
    property int labelRightPadding: 10
    property int labelFontPixelSize: 14
    property bool labelFontBold: true
    property var labelColor: "#999999"

    // 选项值属性
    property int valueLeftPadding: 10

    // 选项值类型:0文本显示，1开关控件，2为下拉列表框
    property int valueType: 1

    property var valueText: "" // 选项文本值
    property int valueFontPixelSize: 14
    property bool valueFontBold: false
    property var valueColor: "#999999"

    // 开关选项值属性
    property int valueSwitchWidth: 70
    property int valueSwitchHeight: 30

    // 下拉列表框
    property int valueComboboxWidth: 200
    property int valueComboboxHeight: 30

    width: parent.width
    height: rowHeight
    radius: borderRadius
    color: backgroundColor

    // 选项左边区域
    Rectangle {
        id: labelWinId

        anchors {
            left: parent.left
            leftMargin: borderWidth
        }

        width: labelWinWidth
        height: parent.height
        radius: borderRadius
        color: "transparent"

        Text {
            anchors {
                right: parent.right
                rightMargin: labelRightPadding
                verticalCenter: parent.verticalCenter
            }
            font.pixelSize: labelFontPixelSize
            font.bold: labelFontBold
            color: labelColor
            text: labelText
        }

    } // end labelWinId Rectangle

    // 选项右边区域
    Rectangle {
        id: rightWinId

        anchors {
            left: parent.left
            leftMargin: labelWinWidth + borderWidth
        }

        width: parent.width - labelWinWidth - 2 * borderWidth
        height: parent.height
        radius: borderRadius
        color: "transparent"

        // 选项文本值
        Text {
            anchors {
                left: parent.left
                leftMargin: valueLeftPadding
                verticalCenter: parent.verticalCenter
            }

            visible: valueType === 0
            text: valueText
            color: valueColor
            font.pixelSize: valueFontPixelSize
            font.bold: valueFontBold
        }

        // 开关控件
        Switch {
            id: switchId

            anchors {
                left: parent.left
                leftMargin: valueLeftPadding
                verticalCenter: parent.verticalCenter
            }

            visible: valueType === 1
            width: valueSwitchWidth
            height: valueSwitchHeight

            onClicked: {
                optionRowSwitchCheckedChanged(switchId.checked);
            }

        } // end switchId Switch

        // 下拉列表框
        ComboBox {
            id: comboBoxId

            anchors {
                left: parent.left
                leftMargin: valueLeftPadding
                verticalCenter: parent.verticalCenter
            }

            visible: valueType === 2
            width: valueComboboxWidth
            height: valueComboboxHeight

            onComboBoxCurrentTextChanged: function(value) {
                optionRowComboboxCurrentTextChanged(value);
            }

        } // end comboBoxId ComboBox


    } // end rightWinId Rectangle


}
