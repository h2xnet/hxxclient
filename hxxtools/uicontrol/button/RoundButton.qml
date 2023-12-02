import QtQuick 2.0
import QtQuick.Controls 2.12

/*
 * ClassName: RoundButton
 * Desc: 圆角控件
 * Author: zfs
 * Date: 2022-09-02 07:33
 */
Rectangle {
    id: containerId

    signal roundButtonClick();

    property int borderRadius: 15
    property bool enableChecked: true // 是否允许选中标志，false不允许，true允许
    property bool isChecked: false // 选中状态
    property int borderLineWidth: 1
    property int labelTextFontSize: 14
    property var labelText: "" // 按钮文本
    property var customWhiteColor: "#FFFFFF"
    property var custowmBlueColor: "#156EFF"

    radius: borderRadius
    border.width: isChecked ? 0 : borderLineWidth
    border.color: custowmBlueColor
    color: isChecked ? custowmBlueColor : customWhiteColor

    Text {
        anchors.centerIn: parent

        font.pixelSize: labelTextFontSize
        color: isChecked ? customWhiteColor : custowmBlueColor

        text: labelText
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            if (enableChecked) {
                isChecked = !isChecked
            }

            roundButtonClick();
        }
    }

    function setChecked(state) {
        isChecked = state;
    }
    function getChecked() {
        return isChecked;
    }

}
