import QtQuick 2.0
import QtQuick.Controls 2.0

import webClient.net.pc  1.0

import "../../js/helper.js" as Helper;

import "../button"

/*
 * ClassName: TabHeadBar
 * Desc: TAB列表头控件
 * Author: zfs
 * Date: 2023-10-24 21:19
 */
Rectangle {
    id: controlId

    property var primaryKeyName: "id" // 主键属性名
    property var tabPageObjKeyName: "tabPageObj"    // tab页面对象属性名

    property int currentIndex: -1 // 当前显示页面序号

    property int defHeight: 30
    property var backgroundColor: "#228899"

    property int borderRadius: 4
    property int borderWidth: 1
    property var borderColor: "#CCCCCC"

    ListModel {
        id: dataModelId

    }

    height: defHeight
    color: backgroundColor
    radius: borderRadius

    border.width: borderWidth
    border.color: borderColor

    function clear() {
        if (dataModelId.count > 0) {
            dataModelId.clear();
        }
    }

    function append(obj) {
        dataModelId.append(obj);
    }

    function getCount() {
        return dataModelId.count;
    }

    function getItem(index) {
        if (index >= 0 && index < dataModelId.count) {
            return dataModelId.get(index);
        }
        return null;
    }

    function setItem(index, obj) {
        dataModelId.set(index, obj);
        return true;
    }

    function getItemValue(index, key, defValue = "") {
        if (index >= 0 && index < dataModelId.count) {
            let itemObj = dataModelId.get(index);
            if (itemObj !== undefined && itemObj !== null) {
                return itemObj[key];
            }
        }
        return defValue;
    }

    function setItemValue(index, key, value) {
        if (index >= 0 && index < dataModelId.count) {
            dataModelId.setProperty(index, key, value);
            return true;
        }
        return false;
    }

    //
    // switchTab : 切换页面，如果切换成功，返回切换后的页面序号，如果切换失败，返回-1
    //
    function switchPage(obj) {
        if (obj === undefined || obj === null) {
            return -1;
        }

        let ret = -1;

        let oldSelItemObj = null;
        let oldSelItemIndex = -1;

        // 查找旧页面
        let itemPrimaryKeyValue = obj[primaryKeyName];
        for(let idx = 0; idx < dataModelId.count; idx++) {
            let itemObj = dataModelId.get(index);
            if (itemPrimaryKeyValue === itemObj[primaryKeyName]) {
                // 找到页面
                oldSelItemIndex = idx;
                oldSelItemObj = itemObj;
            }
            else {
                onShowOrHidePage(idx, itemObj, false);
            }
        }

        if (oldSelItemIndex === -1 ||
                oldSelItemObj === null) {
            // 添加新页面
        }
        else {
            ret = onShowOrHidePage(idx, itemObj, true);
        }

        return ret;
    }

    //
    // onShowOrHidePage : 显示或隐藏页面
    // @index: 页面所在序号
    // @itemObj: 页面所在项数据
    // @isShow: 是否显示状态，true为显示,false为隐藏
    //
    function onShowOrHidePage(index, itemObj, isShow) {

    }

    //
    // onAddPage : 添加新页面
    //
    function onAddPage(obj, isShow) {
        if (obj === undefined ||
                obj === null ||
                obj[primaryKeyName] === "" ||
                obj[primaryKeyName] === null ||
                obj[primaryKeyName] === undefined) {
            return -1;
        }
    }

}
