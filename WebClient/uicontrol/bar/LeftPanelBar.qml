import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.12

import "../../js/helper.js" as Helper

import "../button"

/*
 * ClassName: LeftPanelBar
 * Desc: 左侧面板控件
 * Author: zfs
 * Date: 2023-10-16 08:16
 */
Rectangle {
    id: controlId

    signal leftPanelBarInitCompleted(var list, int curSelIndex); // 初始化完成
    signal leftPanelButtonStateChanged(int idx, bool state); // 左侧面板按钮状态改变信号
    signal leftPanelButtonClick(int idx);

    property bool foldState: true
    property int foldWidth: 120
    property int unfoldWidth: 220

    property var backgroundColor: "#333333"
    property int borderRadius: 4
    property int borderWidth: 1
    property var borderColor: "#CCCCCC"

    // 菜单属性
    property var menuBackgroundColor: "transparent" // 菜单默认背景色
    property var menuCheckedBackgroundColor: "#F5F5F5" // 菜单选中情况下背景色
    property int menuTopPadding: 40
    property int menuBottomPadding: 60
    property int menuSpaceWidth: 10
    property int menuHeight: 60
    property int menuBordWidth: 1
    property var menuBordColor: "#CCCCCC"
    property int menuBordRadius: 4
    property var menuHoverOpacity: 0.8
    property bool menuAllowCancel: false // 菜单是否允许取消

    // 当前选中项序号
    property int currentIndex: -1

    // 有效的top对齐菜单个数
    property int menuValidTopCount: 0

    // 菜单列表
    ListModel {
        id: dataModelId
    }

    //ListModel {
    //    id: bottomDataModelId
    //}

    width: (foldState ? foldWidth : unfoldWidth)
    height: parent.height
    radius: borderRadius
    color: backgroundColor

    //
    // 从上到下菜单列表
    //
    Rectangle {
        id: topMenuWinId

        anchors {
            left: parent.left
            leftMargin: menuBordWidth + menuSpaceWidth
            top: parent.top
            topMargin: menuTopPadding
        }

        color: "transparent"
        radius: menuBordRadius
        width: (parent.width - 2 * menuBordWidth - 2 * menuSpaceWidth)
        height: (menuValidTopCount * (menuHeight + menuSpaceWidth))

        Column {

            anchors {
                left: parent.left
                leftMargin: 0
                top: parent.top
                topMargin: 0
            }

            spacing: menuSpaceWidth

            Repeater {
                model: dataModelId

                // 面板菜单按钮
                PanelButton {

                    id: leftPanelButtonId

                    visible: (align === "top" ? true : false)

                    foldState: controlId.foldState
                    btnFoldWidth: controlId.foldWidth - 2 * controlId.menuBordWidth - 2 * controlId.menuSpaceWidth
                    btnUnfoldWidth: controlId.unfoldWidth - 2 * controlId.menuBordWidth - 2 * controlId.menuSpaceWidth
                    btnHeight: controlId.menuHeight - 2 * controlId.menuBordWidth - 2 * menuSpaceWidth
                    backgroundColor: controlId.menuBackgroundColor
                    checkedBackgroundColor: controlId.menuCheckedBackgroundColor
                    borderWidth: controlId.menuBordWidth
                    borderColor: controlId.menuBordColor
                    borderRadius: controlId.menuBordRadius
                    hoverOpacity: controlId.menuHoverOpacity
                    allowCancel: controlId.menuAllowCancel
                    allowChecked: Helper.getExewayAllowChecked(execWay)

                    btnIndex: index
                    isChecked: checked

                    btnTipText: text
                    btnTextLeftPadding: textLeftPadding
                    btnTextFontPixelSize: textFontPixelSize
                    btnTextFontColor: textFontColor
                    btnTextBold: textBold

                    btnImgPath: imgPath
                    btnImgWidth: imgWidth
                    btnImgHeight: imgHeight
                    btnImgLeftPadding: imgLeftPadding
                    btnImgTopPadding: imgTopPadding

                    // 绑定状态改变事件
                    Connections {
                        target: controlId
                        onLeftPanelButtonStateChanged: function(idx, state) {
                            console.log("LeftPanelBar.qml topMenuWinId onLeftPanelButtonStateChanged params, idx:" + idx + ", state:" + state);

                            if (idx !== index) {
                                return;
                            }

                            isChecked = state;

                        }
                    }

                    onPanelButtonClick: function() {
                        onPanelBtnClick(index);
                    }

                }

            } // end Repeater

        } // end Column


    } // end topMenuWinId Rectangle

    //
    // 从下到上菜单列表
    //

    Rectangle {
        id: bottomMenuWinId

        anchors {
            left: parent.left
            leftMargin: menuBordWidth + menuSpaceWidth
            bottom: parent.bottom
            bottomMargin: menuBottomPadding
        }

        color: "transparent"
        radius: menuBordRadius
        width: parent.width - 2 * menuBordWidth - 2 * menuSpaceWidth
        height: (menuHeight + menuSpaceWidth) * (dataModelId.count - menuValidTopCount)

        Column {

            anchors {
                left: parent.left
                leftMargin: 0
                bottom: parent.bottom
                bottomMargin: 0
            }

            spacing: menuSpaceWidth

            Repeater {
                model: dataModelId

                // 面板菜单按钮
                PanelButton {

                    visible: (align === "bottom" ? true : false)

                    foldState: controlId.foldState
                    btnFoldWidth: controlId.foldWidth - 2 * controlId.menuBordWidth - 2 * controlId.menuSpaceWidth
                    btnUnfoldWidth: controlId.unfoldWidth - 2 * controlId.menuBordWidth - 2 * controlId.menuSpaceWidth
                    btnHeight: controlId.menuHeight - 2 * controlId.menuBordWidth - 2 * menuSpaceWidth
                    backgroundColor: controlId.menuBackgroundColor
                    checkedBackgroundColor: controlId.menuCheckedBackgroundColor
                    borderWidth: controlId.menuBordWidth
                    borderColor: controlId.menuBordColor
                    borderRadius: controlId.menuBordRadius
                    hoverOpacity: controlId.menuHoverOpacity
                    allowCancel: controlId.menuAllowCancel
                    allowChecked: Helper.getExewayAllowChecked(execWay)

                    btnIndex: index
                    isChecked: checked

                    btnTipText: text
                    btnTextLeftPadding: textLeftPadding
                    btnTextFontPixelSize: textFontPixelSize
                    btnTextFontColor: textFontColor
                    btnTextBold: textBold

                    btnImgPath: imgPath
                    btnImgWidth: imgWidth
                    btnImgHeight: imgHeight
                    btnImgLeftPadding: imgLeftPadding
                    btnImgTopPadding: imgTopPadding

                    // 绑定状态改变事件
                    Connections {
                        target: controlId
                        onLeftPanelButtonStateChanged: function(idx, state) {
                            console.log("LeftPanelBar.qml bottomMenuWinId onLeftPanelButtonStateChanged params, idx:" + idx + ", state:" + state);

                            if (idx !== index) {
                                return;
                            }

                            isChecked = state;

                        }
                    }

                    onPanelButtonClick: function() {
                        onPanelBtnClick(index);
                    }

                }

            } // end Repeater


        } // end Column


    } // end bottomMenuWinId Rectangle



    /*
     * Func: init
     * Desc: 初始化菜单列表
     * Author: zfs
     * Date: 2023-10-22 08:44
     */
    function init(list, defSelIdx) {
        console.log("LeftPanelBar.mql init params, defSelIdx:" + defSelIdx + ", list:" + JSON.stringify(list));

        dataModelId.clear();
        currentIndex = -1;
        menuValidTopCount = 0;

        if (list && list.length > 0) {

            if (defSelIdx >= 0 && defSelIdx < list.length) {
                currentIndex = defSelIdx;
            }
            else {
                currentIndex = 0;
            }

            for(let idx = 0; idx < list.length; idx++) {
                let itemObj = list[idx];
                if (currentIndex === idx) {
                    itemObj["checked"] = true;
                }
                else {
                    itemObj["checked"] = false;
                }

                if (itemObj["align"] === "top") {
                    menuValidTopCount++;
                }

                dataModelId.append(list[idx]);
            }

            console.log("LeftPanelBar.mql init menuValidTopCount:" + menuValidTopCount + ", currentIndex:" + currentIndex);

        }

        // 发送事件
        leftPanelBarInitCompleted(list, currentIndex);

    }

    /*
     * Func: clearAll
     * Desc: 清空
     * Author: zfs
     * Date: 2023-10-22 09:02
     */
    function clearAll() {
        if (dataModelId.count > 0) {
            dataModelId.clear();
            currentIndex = -1;
        }
    }

    /*
     * Func: getCount
     * Desc: 获取菜单列表个数
     * Author: zfs
     * Date: 2023-10-22 09:01
     */
    function getCount() {
        return dataModelId.count;
    }

    /*
     * Func: getCurrentIndex
     * Desc: 获取当前选中项序号
     * Author: zfs
     * Date: 2023-10-25 08:00
     */
    function getCurrentIndex() {
        return currentIndex;
    }

    /*
     * Func: getItem
     * Desc: 获取指定项的数据
     * Author: zfs
     * Date: 2023-10-25 07:52
     */
    function getItem(index) {
        if (index >= 0 && index < dataModelId.count) {
            return dataModelId.get(index);
        }
        return null;
    }

    /*
     * Func: getItemData
     * Desc: 获取指定项的指定属性值
     * Author: zfs
     * Date: 2023-10-25 07:52
     */
    function getItemData(index, key) {
        if (index >= 0 && index < dataModelId.count) {
            let itemObj = dataModelId.get(index);
            if (itemObj !== undefined && itemObj !== null) {
                return itemObj[key];
            }
        }
        return null;
    }

    /*
     * Func: onPanelBtnClick
     * Desc: 面板按钮事件
     * Author: zfs
     * Date: 2023-10-22 09:01
     */
    function onPanelBtnClick(index) {
        console.log("LeftPanelBar.qml onPanelBtnClick params, index:" + index);

        // 判断当前选中项是否允许更改状态
        let checkedItemObj = dataModelId.get(index);
        if (Helper.getExewayAllowChecked(checkedItemObj["execWay"])) {

            // 保存当前选中项
            currentIndex = index;

            // 修改选中状态
            for(let idx = 0; idx < dataModelId.count; idx++) {
                let item = dataModelId.get(idx);

               if (index === idx) {
                    if (item["checked"] === false) {
                        dataModelId.setProperty(idx, "checked", true);
                        controlId.leftPanelButtonStateChanged(idx, true); // 发送信号通知子控件修改状态
                    }
                }
                else {
                    if (item["checked"] === true) {
                        dataModelId.setProperty(idx, "checked", false);
                        controlId.leftPanelButtonStateChanged(idx, false);
                    }
                }
            }

        }

        // 发送通知事件
        leftPanelButtonClick(index);

    }



}
