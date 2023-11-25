import QtQuick 2.0
import QtQuick.Controls 2.12

import "../../../js/helper.js" as Helper;

import "../../../uicontrol/button"

Rectangle {
    id: controlId

    property var parentControl: null // 父控制指针

    property int menuBtnSpaceWidth: 10
    property int menuBtnHeight: 35
    property int menuBtnSeparatorHeight: 10
    property var menuBtnSeparatorColor: "#CCCCCC"

    ListModel {
        id: dataModelId
    }

    anchors.fill: parent

    color: "transparent"

    Rectangle {
        id: bodyWinId;

        anchors.centerIn: parent

        width: parent.width
        height: parent.height

        color: "transparent"

        Column {
            spacing: menuBtnSpaceWidth

            width: bodyWinId.width
            height: bodyWinId.height

            Repeater {
                model: dataModelId

                Rectangle {

                    width: bodyWinId.width
                    height: ((type === "separator") ? menuBtnSeparatorHeight : menuBtnHeight)
                    color: "transparent"

                    // 分隔线
                    Rectangle {
                        anchors.centerIn: parent

                        visible: type === "separator"
                        color: menuBtnSeparatorColor
                        width: parent.width - 20
                        height: 2
                        radius: 2
                    }

                    // 菜单按钮
                    ColorButton {

                        anchors.centerIn: parent

                        visible: type === "button"
                        enableChecked: false
                        labelAlimnLeft: true
                        labelLeftPadding: 20
                        labelTextColor: "#000000"
                        borderColor: menuBtnSeparatorColor
                        width: bodyWinId.width - 10
                        height: menuBtnHeight
                        labelText: text

                        onColorButtonClick: function() {
                            onSettingsMenuButtonClick(index);

                        }

                    } // end ColorButton

                } // end Rectangle



            } // end Repeater

        } // end Column

    } // end bodyWinId Rectangle

    Component.onCompleted: {
        let settingsMenuButtons = Helper.getSettingsMenuButtons();
        console.log("SettingsPage.mql Component.onCompleted getSettingsMenuButtons : " + JSON.stringify(settingsMenuButtons));

        init(settingsMenuButtons);

    }

    Component.onDestruction: {

    }

    function init(list) {
        console.log("SettingsPage.qml init params, list:" + JSON.stringify(list));

        dataModelId.clear();

        for(let idx = 0; idx < list.length; idx++) {
            let itemObj = list[idx];

            dataModelId.append(itemObj);
        }

    }

    //
    // onSettingsMenuButtonClick : 菜单按钮单击事件
    //
    function onSettingsMenuButtonClick(idx) {
        console.log("SettingsPage.qml SettingsPage.qml param, idx:" + idx);

        let itemObj = dataModelId.get(idx);

        if (parentControl) {
            parentControl.onMenuButtonClick(idx, itemObj);
        }

    }


}
