import QtQuick 2.0
import QtQuick 2.12

import webClient.net.pc  1.0

import "../../uicontrol/web"
import "../../uicontrol/bar"

Rectangle {
    id: controlId

    // 初始化页面事件
    signal initPage(var args);
    signal showOrHide(bool isShow);

    property var primaryKeyId: "" // 主键ID
    property var pageText: "" // 页面文本

    // 页面执行参数
    property var execWay: ""
    property var execCmd: ""
    property var execPath: ""

    property var backgroundColor: "transparent"
    property int borderRadius: 4

    property int leftPaddingWeb: 0
    property int topPaddingWeb: 0
    property int rightPaddingWeb: 0
    property int bottomPaddingWeb: 0

    // web工具栏
    property int webToolBarLeftPadding: 10
    property int webToolBarBottomPadding: 10

    anchors.fill: parent

    color: backgroundColor
    radius: borderRadius

    // web浏览器
    WebEngineCustom {
        id: webEngineCustomId

        anchors {
            left: parent.left
            leftMargin: leftPaddingWeb
            top: parent.top
            topMargin: topPaddingWeb
        }

        leftPadding: leftPaddingWeb
        topPadding: topPaddingWeb
        rightPadding: rightPaddingWeb
        bottomPadding: bottomPaddingWeb

        width: parent.width - leftPaddingWeb - rightPaddingWeb
        height: parent.height - topPaddingWeb - bottomPaddingWeb

        onWebEngineCertificateError: function(error) {

        }

        onWebEngineViewLoading: function(isLoading) {
            AppId.loadingChanged(isLoading, "WebPage");

        }

        onWebEngineViewLoadProgressChanged: function(percent) {

        }

        onWebEngineViewRecv: function(code, result) {
            console.log("WebPage.qml onWebEngineViewRecv params, code:" + code + ", result:" + JSON.stringify(result));

        }

    } // end webEngineCustomId WebEngineCustom

    // web工具栏
    WebToolBar {
        id: webToolBarId

        z: 1000

        x: webToolBarLeftPadding
        y: (parent.height - webToolBarId.height - webToolBarBottomPadding)

        onWebToolBarButtonClick: function(index, itemObj) {
            onToolBarButtonClickEvent(index, itemObj);
        }

    } // end webToolBarId WebToolBar

    Component.onCompleted: {
        console.log("WebPage.qml Component.onCompleted");

        init();

    }

    Component.onDestruction: {
        console.log("WebPage.qml Component.onDestruction");
    }

    //
    // onInitPage : 初始化页面
    //
    onInitPage: function(args) {
        console.log("WebPage.qml onInitPage params, " + JSON.stringify(args));

        primaryKeyId = args["id"];
        pageText = args["text"];
        execWay = args["execWay"];
        execCmd = args["execCmd"];
        execPath = args["execPath"];

        if (args.hasOwnProperty('page')) {
            onInitPageAttr(args['page']);
        }

        // webToolBar
        if (args.hasOwnProperty('webToolBar')) {
            onInitWebToolBarAttr(args['webToolBar']);
        }

        // 打开页面
        let nativeExecPath = GlobalHandlerId.nativeToPath(execPath);

        console.log("WebPage.qml onInitPage execPath:" + execPath + ", nativeExecPath:" + nativeExecPath);

        webEngineCustomId.openUrl(nativeExecPath);


    }

    //
    // onShowOrHide : 显示或隐藏页面
    //
    onShowOrHide: function(isShow) {
        console.log("WebPage.qml onShowOrHide params, isShow:" + isShow);
        controlId.visible = isShow;
    }

    //
    // init : 初始化
    //
    function init() {
        // 初始化工具栏
        let toolDataList = [
            {
                    "id": "backId",
                    "text": "返回",
                    "imagePath": "qrc:/statics/imgs/toolbar/left.png"
            },
            {
                    "id": "forwardId",
                    "text": "前进",
                    "imagePath": "qrc:/statics/imgs/toolbar/right.png"
            },
            {
                    "id": "freshId",
                    "text": "刷新",
                    "imagePath": "qrc:/statics/imgs/toolbar/fresh.png"
            },
            {
                    "id": "homeId",
                    "text": "主页",
                    "imagePath": "qrc:/statics/imgs/toolbar/home.png"
            },
        ];

        webToolBarId.init(toolDataList);

    }

    //
    // onInitPageAttr : 初始化页面属性
    //
    function onInitPageAttr(attrObj) {
        console.log("WebPage.qml onInitPageAttr params, " + JSON.stringify(attrObj));

        if (attrObj.hasOwnProperty('backgroundColor')) {
            backgroundColor = attrObj['backgroundColor'];
        }

        if (attrObj.hasOwnProperty('radius')) {
            borderRadius = attrObj['radius'];
        }

        if (attrObj.hasOwnProperty('leftPadding')) {
            leftPaddingWeb = attrObj['leftPadding'];
        }

        if (attrObj.hasOwnProperty('topPadding')) {
            topPaddingWeb = attrObj['topPadding'];
        }

        if (attrObj.hasOwnProperty('rightPadding')) {
            rightPaddingWeb = attrObj['rightPadding'];
        }

        if (attrObj.hasOwnProperty('bottomPadding')) {
            bottomPaddingWeb = attrObj['bottomPadding'];
        }

    }

    //
    // onInitWebToolBarAttr : 初始化工具栏属性
    //
    function onInitWebToolBarAttr(attrObj) {
        if (attrObj.hasOwnProperty('radius')) {
            webToolBarId.borderRadius = attrObj['radius'];
        }
        if (attrObj.hasOwnProperty('borderWidth')) {
            webToolBarId.borderWidth = attrObj['borderWidth'];
        }
        if (attrObj.hasOwnProperty('borderColor')) {
            webToolBarId.borderColor = attrObj['borderColor'];
        }
        if (attrObj.hasOwnProperty('backgroundColor')) {
            webToolBarId.backgroundColor = attrObj['backgroundColor'];
        }
        if (attrObj.hasOwnProperty('leftPadding')) {
            webToolBarLeftPadding = attrObj['leftPadding'];
        }
        if (attrObj.hasOwnProperty('bottomPadding')) {
            webToolBarBottomPadding = attrObj['bottomPadding'];
        }

    }

    //
    // onToolBarButtonClickEvent : 工具栏按钮事件
    //
    function onToolBarButtonClickEvent(index, itemObj) {
        console.log("WebPage.qml onToolBarButtonClickEvent params, index:" + index + ", itemObj:" + JSON.stringify(itemObj));

        if (itemObj["id"] === "backId") {
            // 返回
            webEngineCustomId.gotoBack();
        }
        else if (itemObj["id"] === "forwardId") {
            // 前进
            webEngineCustomId.gotoForward()
        }
        else if (itemObj["id"] === "freshId") {
            // 刷新
            webEngineCustomId.reload();
        }
        else if (itemObj["id"] === "homeId") {
            // 主页
            webEngineCustomId.gotoHome();
        }

    }

}
