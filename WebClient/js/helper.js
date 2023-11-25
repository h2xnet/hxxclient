

/*
 * Func: getExewayAllowChecked
 * Desc: 判断执行方式是否允许选中，默认是允许
 * Author: zfs
 * Date: 2023-10-22 21:19
 */
function getExewayAllowChecked(execWay) {
    console.log("helper.mql getExewayAllowChecked params, execWay:" + execWay);
    if (execWay === "poppage") {
        return false;
    }

    return true;
}

/*
 * Func: execWayPageIsWebEngine
 * Desc: 判断是否是用web浏览器打开
 * Author: zfs
 * Date: 2023-10-25 21:23
 */
function execWayPageIsWebEngine(execWay) {
    return (execWay === "embedweb" ? true : false);
}

/*
 * Func: execWayPageIsPopup
 * Desc: 判断是否是是弹出页面
 * Author: zfs
 * Date: 2023-11-01 07:49
 */
function execWayPageIsPopup(execWay) {
    return (execWay === "poppage" ? true : false);
}

/*
 * Func: createInitPageComponent
 * Desc: 创建初始化页面组件
 * Author: zfs
 * Date: 2023-10-26 07:26
 */
function createInitPageComponent(pageUrl, args, parent) {
    console.log("helper.js createInitPageComponent params, pageUrl:" + pageUrl + ", args:" + JSON.stringify(args));

    let obj = null;

    var component = Qt.createComponent(pageUrl);
    if (component.status === Component.Ready) {
        // success
        var pageObj = component.createObject(parent);

        obj = {};
        obj["pageUrl"] = pageUrl;
        obj["params"] = args;
        obj["pageObj"] = pageObj;

        pageObj.initPage(args);
    }
    else {
        // fail
        console.error("helper.js createInitPageComponent 创建页面组件失败, 页面地址: " + pageUrl + ", 错误信息:" + component.errorString());
        obj = null;
    }

    return obj;
}

/*
 * Func: createOpenPageComponent
 * Desc: 创建打开页面组件
 * Author: zfs
 * Date: 2023-10-26 07:26
 */
function createOpenPageComponent(pageUrl, operation, args, parent,
                                 posX = -1, posY = -1, defWidth = -1, defHeight = -1) {
    console.log("helper.js createOpenPageComponent params, pageUrl:" + pageUrl + ", operation:" + operation + ", args:" + JSON.stringify(args));

    let obj = null;

    var component = Qt.createComponent(pageUrl);
    if (component.status === Component.Ready) {
        // success
        var pageObj = component.createObject(parent);
        pageObj.initPage(args);

        obj = {};
        obj["pageUrl"] = pageUrl;
        obj["params"] = args;
        obj["pageObj"] = pageObj;

        if (posX >= 0) {
            pageObj.x = posX;
        }
        else {
            posX = getPosX(args["id"], pageObj, parent);
            if (posX >= 0) {
                pageObj.x = posX;
            }
        }

        if (posY >= 0) {
            pageObj.y = posY;
        }
        else {
            posY = getPosY(args["id"], pageObj, parent);
            if (posY >= 0) {
                pageObj.y = posY;
            }
        }

        if (defWidth > 0) {
            pageObj.width = defWidth;
        }

        if (defHeight > 0) {
            pageObj.height = defHeight;
        }

        pageObj.beginShow();
    }
    else {
        // fail
        console.error("helper.js createOpenPageComponent 创建页面组件失败, 页面地址: " + pageUrl + ", 错误信息:" + component.errorString());
        obj = null;
    }

    return obj;
}

function getPosX(pageId, pageObj, parentId) {
    if (pageId === "menuSettingsId" && pageObj !== null && parentId !== null) {
        // 设置按钮
        return (parentId.width + 5);
    }
    return -1;
}

function getPosY(pageId, pageObj, parentId) {
    if (pageId === "menuSettingsId" && parentId !== null) {
        // 设置按钮
        return (parentId.height - pageObj.height - 10);
    }
    return -1;
}

/*
 * Func: appendWebToolBarArgs
 * Desc: 追加工具栏参数
 * Author: zfs
 * Date: 2023-11-03 07:58
 */
function appendWebToolBarArgs(args, sourceId) {
    let obj = args;
    if (obj === undefined || obj === null) {
        obj = {};
    }

    let appendObj = {};
    appendObj["radius"] = sourceId.webToolBarBorderRadius;
    appendObj["borderWidth"] = sourceId.webToolBarBorderWidth;
    appendObj["borderColor"] = sourceId.webToolBarBorderColor;
    appendObj["backgroundColor"] = sourceId.webToolBarBackgroundColor;
    appendObj["leftPadding"] = sourceId.webToolBarLeftPadding;
    appendObj["bottomPadding"] = sourceId.webToolBarBottomPadding;

    obj["webToolBar"] = appendObj;

    return obj;
}

/*
 * Func: getSettingsMenuButtons
 * Desc: 获取系统设置菜单按钮列表
 * Author: zfs
 * Date: 2023-11-05 09:22
 */
function getSettingsMenuButtons() {
    let list = [];

    list.push({
                  "id": "systemSettingId",
                  "type":"button",
                  "text":"系统设置"
              });

    list.push({
                  "id": "aboutId",
                  "type":"button",
                  "text":"关于"
              });

    // separator
    list.push({
                  "id": "separatorId",
                  "type":"separator"
              });

    list.push({
                  "id": "exitAppId",
                  "type":"button",
                  "text":"退出"
              });

    return list;
}

/*
 * Func: getLogOptions
 * Desc: 获取日志选项列表
 * Author: zfs
 * Date: 2023-11-08 07:39
 */
function getLogOptions() {
    let list = [];

    list.push({
                  "id": "1",
                  "name":"调试",
                  "value":0
              });

    list.push({
                  "id": "2",
                  "name":"警告",
                  "value":2
              });

    list.push({
                  "id": "3",
                  "name":"信息",
                  "value":3
              });

    list.push({
                  "id": "4",
                  "name":"错误",
                  "value":4
              });


    return list;
}
