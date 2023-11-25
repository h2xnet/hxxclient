import QtQuick 2.0
import QtQuick.Controls 2.0

import webClient.net.pc  1.0

import "../../js/helper.js" as Helper;

import "../button"
import "../web"

/*
 * ClassName: PageBox
 * Desc: 标题栏控件
 * Author: zfs
 * Date: 2023-10-16 08:16
 */
Rectangle {
    id: controlId

    property var primaryKeyName: "id" // 主键属性名
    property var pageParamsKeyName: "params" // 页面参数对象属性名
    property var pageObjKeyName: "pageObj"    // 页面对象属性名

    property int currentIndex: -1 // 当前显示页面序号

    property var backgroundColor: "transparent"
    property int borderRadius: 4
    property int borderWidth: 1
    property var borderColor: "#CCCCCC"

    property int leftPadding: 10
    property int topPadding: 10
    property int rightPadding: 10
    property int bottomPadding: 10


    ListModel {
        id: dataModelId

    }

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
    // addPage : 添加新页面
    //
    function addPageComponent(componentObj, isShow) {
        if (componentObj === undefined ||
                componentObj === null) {
            console.error("PageBox.qml onAddPage param error, 添加内容页面参数错误 ");
            return -1;
        }

        dataModelId.append(componentObj);

        let ret = dataModelId.count - 1;

        console.log("PageBox.qml onAddPage 添加新页面序号:" + currentIndex);

        return ret;
    }

    //
    // switchTab : 切换页面，如果切换成功，返回切换后的页面序号，如果切换失败，返回-1
    //
    function switchPage(obj) {
        if (obj === undefined || obj === null) {
            return -1;
        }

        let ret = -1;

        let primaryId = obj[primaryKeyName];

        // 查找旧页面
        for(let idx = 0; idx < dataModelId.count; idx++) {
            let itemObj = dataModelId.get(idx);

            // 获取页面参数
            let itemPageParams = itemObj[pageParamsKeyName];
            if (itemPageParams === undefined || itemPageParams === null) {
                continue;
            }

            // 获取页面主键
            let itemPrimaryId = itemPageParams[primaryKeyName];
            console.log("switchPage loop compare item primaryId:" + primaryId + " idx:" + idx + ", itemPrimaryId:" + itemPrimaryId);

            if (primaryId === itemPrimaryId) {
                // 找到页面
                onShowOrHidePage(idx, itemObj[pageObjKeyName], true);
            }
            else {
                onShowOrHidePage(idx, itemObj[pageObjKeyName], false);
            }
        }

        return 0;
    }

    //
    // onShowOrHidePage : 显示或隐藏页面
    // @index: 页面所在序号
    // @itemObj: 页面所在项数据
    // @isShow: 是否显示状态，true为显示,false为隐藏
    //
    function onShowOrHidePage(index, pageWndObj, isShow) {
        console.info("PageBox.qml onShowOrHidePage params, index:" + index + ", isShow:" + isShow);
        let ret = -1;

        if (pageWndObj !== null && pageWndObj !== undefined) {
            pageWndObj.showOrHide(isShow);
            ret = 0;
        }

        return ret;
    }



}
