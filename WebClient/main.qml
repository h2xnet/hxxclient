import QtQuick 2.12
import QtQuick.Window 2.12
import QtGraphicalEffects 1.0

import webClient.net.pc  1.0

import "./js/theme.js" as Theme
import "./js/helper.js" as Helper;

import "./uicontrol"
import "./uicontrol/bar"
import "./uicontrol/box"
import "./uicontrol/background"
import "./uicontrol/window"
import "./uicontrol/unit/wait"
import "./uicontrol/msg"

import "./uipages/settings/systemset"
import "./uipages/settings/about"


Window {
    id: mainWndId

    // 登录状态，0为未登录，1为已登录
    property int loginState: 1

    // 主窗口属性
    property int minWndWidth: 400
    property int minWndHeight: 600
    property bool defMaximized: false

    property int tmpWndWidth: 0
    property int tmpWndHeight: 0

    property int borderWidth: 1
    property int borderRadius: 4
    property var borderColor: "#CCCCCC"

    // 窗口背景模式：颜色背景，图片背景，默认为颜色背景
    property var backgroundModel: "color"
    property var backgroundColor: "#FCFCFC"
    property var backgroundImage: ""

    // 系统托盘
    property bool systrapVisiable: true
    property var systrapTipText: "网络客户端"
    property var systrapImgPath: "qrc:/statics/logo/logo.png"

    // 全局属性
    GlobalProperty {
        id: globalPropertyId

    }


    /*// 定义全局变量
   QtObject {
       id: root

       // 全局属性变量
       property var $globalId: Global{}

       // 全局设置属性变量
       property var $settingId: Setting{}

   } // end root QtObject*/

    // 主处理器
    MainHandler {
        id: mainHandlerId

    }

    // 等待加载对象
    WaitLoading {
        id: waitLoadingId
        visible: false;
    }

    // 消息提示框
    MsgBox {
        id: msgBoxId
        visible: false

        onMsgBoxBtnClick: function(isYes, source, owner) {
            onMsgBoxBtnClickEvent(isYes, source, owner);
        }

    }

    // 消息弹框
    ToastMsg {
        id: toastMsgId
        visible: false
    }

    // 系统设置
    SystemSet {
        id: systemSetId
        visible: false
    }

    // 关于
    About {
        id: aboutId
        visible: false
    }

    //
    // 鼠标拖动改变大小
    //
    MouseDrag {
        id: mourseDragId

        target: mainWndId

    } // end MouseDrag

    // 系统托盘
    SystemTrayIcon{
        id: systemTrayId

        menu: menuId

        visible: systrapVisiable
        icon: systrapImgPath
        toolTip: systrapTipText

        onTrigger:{
            // 单击系统托盘

            // 托盘单击事件
            onSystemTrayClick();
        }

        MyMenu {
            id: menuId

            MyAction {
                id: exitItem
                text: qsTr("退出")
                onTriggered: {
                    onCloseApp(0);
                }
            }
        }
    }

    flags: {
        if (loginState > 0) {
            return Qt.FramelessWindowHint | Qt.CustomizeWindowHint;
        }
        else {
            return Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint | Qt.CustomizeWindowHint;
        }
    }

    //flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint | Qt.CustomizeWindowHint | Qt.MSWindowsFixedSizeDialogHint

    visible: true
    color: "transparent"

    minimumWidth: mainWndId.minWndWidth
    minimumHeight: mainWndId.minWndHeight

    title: qsTr("Hello World")

    // 页面背景
    BackgroundColor {
        id: backgroudControlId

        bordWidth: mainWndId.borderWidth
        borderRadius: mainWndId.borderRadius
        borderColor: mainWndId.borderColor

        backgroundColor: mainWndId.backgroundColor


    } // end backgroudControlId BackgroundColor

    // 标题栏
    TitleBar {
        id: titleBarControlId

        anchors {
            left: parent.left
            leftMargin: borderWidth
            top: parent.top
            topMargin: borderWidth
        }

        // 标题栏基本属性
        width: parent.width - 2 * mainWndId.borderWidth

        defHeight: globalPropertyId.propertyControlId.titleBarHeight
        borderRadius: globalPropertyId.propertyControlId.titleBarBorderRadius
        backgroundColor: globalPropertyId.propertyControlId.titleBarBackgroundColor

        // 标题栏图标属性
        logoImgPath: globalPropertyId.propertyControlId.titleBarLogoImgPath
        logoImgWidth: globalPropertyId.propertyControlId.titleBarLogoImgWidth
        logoImgHeight: globalPropertyId.propertyControlId.titleBarLogoImgHeight
        logoImgLeftPadding: globalPropertyId.propertyControlId.titleBarLogoImgLeftPadding
        logoImgTopPadding: globalPropertyId.propertyControlId.titleBarLogoImgTopPadding

        // 标题栏标题属性
        titleText: globalPropertyId.propertyControlId.titleBarTitleText
        titleTextAlign: globalPropertyId.propertyControlId.titleBarTitleTextAlign
        titleTextLeftPadding: globalPropertyId.propertyControlId.titleBarTitleTextLeftPadding
        titleTextTopPadding: globalPropertyId.propertyControlId.titleBarTitleTextTopPadding
        titleTextFontPixelSize: globalPropertyId.propertyControlId.titleTextFontPixelSize
        titleTextFontColor: globalPropertyId.propertyControlId.titleTextFontColor
        titleTextFontBold: globalPropertyId.propertyControlId.titleTextFontBold

        // 系统菜单按钮
        // 最小化按钮
        systemMenuMinBtnVisiable: globalPropertyId.propertyControlId.systemMenuMinBtnVisiable
        systemMenuMinBtnTipText: globalPropertyId.propertyControlId.systemMenuMinBtnTipText
        systemMenuMinBtnImgPath: globalPropertyId.propertyControlId.systemMenuMinBtnImgPath
        systemMenuMinBtnWidth: globalPropertyId.propertyControlId.systemMenuMinBtnWidth
        systemMenuMinBtnHeight: globalPropertyId.propertyControlId.systemMenuMinBtnHeight
        systemMenuMinBtnImgWidth: globalPropertyId.propertyControlId.systemMenuMinBtnImgWidth
        systemMenuMinBtnImgHeight: globalPropertyId.propertyControlId.systemMenuMinBtnImgHeight
        systemMenuMinBtnBackgroundColor: globalPropertyId.propertyControlId.systemMenuMinBtnBackgroundColor
        systemMenuMinBtnTopPadding: globalPropertyId.propertyControlId.systemMenuMinBtnTopPadding
        systemMenuMinBtnRightPadding: globalPropertyId.propertyControlId.systemMenuMinBtnRightPadding

        systemMenuMinBtnBorderWidth: globalPropertyId.propertyControlId.systemMenuMinBtnBorderWidth
        systemMenuMinBtnBorderColor: globalPropertyId.propertyControlId.systemMenuMinBtnBorderColor
        systemMenuMinBtnBorderVisiable: globalPropertyId.propertyControlId.systemMenuMinBtnBorderVisiable
        systemMenuMinBtnHoverBorderVisiable: globalPropertyId.propertyControlId.systemMenuMinBtnHoverBorderVisiable

        // 最大化按钮
        systemMenuMaxBtnVisiable: globalPropertyId.propertyControlId.systemMenuMaxBtnVisiable
        systemMenuMaxBtnTipText: globalPropertyId.propertyControlId.systemMenuMaxBtnTipText
        systemMenuMaxBtnImgPath: globalPropertyId.propertyControlId.systemMenuMaxBtnImgPath
        systemMenuMaxBtnWidth: globalPropertyId.propertyControlId.systemMenuMaxBtnWidth
        systemMenuMaxBtnHeight: globalPropertyId.propertyControlId.systemMenuMaxBtnHeight
        systemMenuMaxBtnImgWidth: globalPropertyId.propertyControlId.systemMenuMaxBtnImgWidth
        systemMenuMaxBtnImgHeight: globalPropertyId.propertyControlId.systemMenuMaxBtnImgHeight
        systemMenuMaxBtnBackgroundColor: globalPropertyId.propertyControlId.systemMenuMaxBtnBackgroundColor
        systemMenuMaxBtnTopPadding: globalPropertyId.propertyControlId.systemMenuMaxBtnTopPadding
        systemMenuMaxBtnRightPadding: globalPropertyId.propertyControlId.systemMenuMaxBtnRightPadding

        systemMenuMaxBtnBorderWidth: globalPropertyId.propertyControlId.systemMenuMaxBtnBorderWidth
        systemMenuMaxBtnBorderColor: globalPropertyId.propertyControlId.systemMenuMaxBtnBorderColor
        systemMenuMaxBtnBorderVisiable: globalPropertyId.propertyControlId.systemMenuMaxBtnBorderVisiable
        systemMenuMaxBtnHoverBorderVisiable: globalPropertyId.propertyControlId.systemMenuMaxBtnHoverBorderVisiable

        // 关闭按钮
        systemMenuCloseBtnVisiable: globalPropertyId.propertyControlId.systemMenuCloseBtnVisiable
        systemMenuCloseBtnTipText: globalPropertyId.propertyControlId.systemMenuCloseBtnTipText
        systemMenuCloseBtnImgPath: globalPropertyId.propertyControlId.systemMenuCloseBtnImgPath
        systemMenuCloseBtnWidth: globalPropertyId.propertyControlId.systemMenuCloseBtnWidth
        systemMenuCloseBtnHeight: globalPropertyId.propertyControlId.systemMenuCloseBtnHeight
        systemMenuCloseBtnImgWidth: globalPropertyId.propertyControlId.systemMenuCloseBtnImgWidth
        systemMenuCloseBtnImgHeight: globalPropertyId.propertyControlId.systemMenuCloseBtnImgHeight
        systemMenuCloseBtnBackgroundColor: globalPropertyId.propertyControlId.systemMenuCloseBtnBackgroundColor
        systemMenuCloseBtnTopPadding: globalPropertyId.propertyControlId.systemMenuCloseBtnTopPadding
        systemMenuCloseBtnRightPadding: globalPropertyId.propertyControlId.systemMenuCloseBtnRightPadding

        systemMenuCloseBtnBorderWidth: globalPropertyId.propertyControlId.systemMenuCloseBtnBorderWidth
        systemMenuCloseBtnBorderColor: globalPropertyId.propertyControlId.systemMenuCloseBtnBorderColor
        systemMenuCloseBtnBorderVisiable: globalPropertyId.propertyControlId.systemMenuCloseBtnBorderVisiable
        systemMenuCloseBtnHoverBorderVisiable: globalPropertyId.propertyControlId.systemMenuCloseBtnHoverBorderVisiable



        onSystemMenuMinClick: function() {
            console.log("main.qml onSystemMenuMinClick");
            onMinWndEvent("systemMenuMinBtn");
        }

        onSystemMenuMaxClick: function() {
            console.log("main.qml onSystemMenuMaxClick");
            onMaxWndEvent("systemMenuMaxBtn");
        }

        onSystemMenuCloseClick: function() {
            console.log("main.qml onSystemMenuCloseClick");
            //onCloseApp(0);
            onMinWndEvent("systemMenuCloseBtn");
        }

    } // end titleBarControlId TitleBar

    // TAB头控件
    /*TabHeadBar {
        id: tabHeadBarId

        anchors {
            left: parent.left
            leftMargin: globalPropertyId.propertyControlId.tabHeadBarLeftPadding
            top: parent.top
            topMargin: globalPropertyId.propertyControlId.tabHeadBarTopPadding
        }

        visible: globalPropertyId.propertyControlId.tabHeadBarVisiable
        backgroundColor: globalPropertyId.propertyControlId.tabHeadBarBackgroundColor
        borderRadius: globalPropertyId.propertyControlId.tabHeadBarBorderRadius
        borderWidth: globalPropertyId.propertyControlId.tabHeadBarBorderWidth
        borderColor: globalPropertyId.propertyControlId.tabHeadBarBorderColor

        defHeight: globalPropertyId.propertyControlId.tabHeadBarHeight
        width: (parent.width - globalPropertyId.propertyControlId.tabHeadBarLeftPadding -
                globalPropertyId.propertyControlId.tabHeadBarRightPadding)

    } // end tabHeadBarId TabHeadBar*/

    // 左侧面板
    LeftPanelBar {
        id: leftPanelBarId

        anchors {
            left: parent.left
            leftMargin: borderWidth
            top: parent.top
            topMargin: titleBarControlId.height + borderWidth
        }

        height: (parent.height - titleBarControlId.height -
                 2 * borderWidth - globalPropertyId.propertyControlId.statusBarHeight)

        // 初始化完成
        onLeftPanelBarInitCompleted:function(list, curSelIdx) {
             console.log("main.qml onLeftPanelBarInitCompleted, curSelIdx:" + curSelIdx + ", list:" + JSON.stringify(list));

            // 初始化页面
            onInitBoxPage(list, curSelIdx);

        }

        // 按钮单击事件
        onLeftPanelButtonClick: function(index) {
            console.log("main.qml leftPanelButtonClick, index:" + index);

            // 切换BOX页面
            let itemObj = getItem(index);
            onSwitchBoxPage(index, itemObj);

        }

    } // end leftPanelBarId LeftPanelBar

    // 页面内容
    PageBox {
        id: rightPageContentId

        anchors {
            left: parent.left
            leftMargin: borderWidth + leftPanelBarId.width + globalPropertyId.propertyControlId.pageBoxSpaceWidth
            top: parent.top
            topMargin: borderWidth + titleBarControlId.height + globalPropertyId.propertyControlId.pageBoxSpaceHeight;
        }

        width: parent.width - 2 * borderWidth - leftPanelBarId.width - 2 * globalPropertyId.propertyControlId.pageBoxSpaceWidth
        height: (parent.height -
                 2 * borderWidth - titleBarControlId.height -
                 2 * globalPropertyId.propertyControlId.pageBoxSpaceHeight -
                 globalPropertyId.propertyControlId.statusBarHeight)
        radius: globalPropertyId.propertyControlId.pageBoxRadius
        color: globalPropertyId.propertyControlId.pageBoxBackgroundColor


    } // end rightPageContentId PageBox

    // 状态栏
    StatusBar {
        id: statusBarId

        anchors {
            left: parent.left
            leftMargin: borderWidth
            bottom: parent.bottom
            bottomMargin: borderWidth
        }

        defHeight: globalPropertyId.propertyControlId.statusBarHeight
        borderRadius: globalPropertyId.propertyControlId.statusBarBorderRadius
        borderWidth: globalPropertyId.propertyControlId.statusBarBorderWidth
        borderColor: globalPropertyId.propertyControlId.statusBarBorderColor
        backgroundColor: globalPropertyId.propertyControlId.statusBarBackgroundColor

        width: parent.width - 2 * borderWidth

    }


    Component.onCompleted: {
        console.log("main.qml Component.onCompleted!")

        // 主题事件
        AppId.mainThemeDataEvent.connect(onMainThemeDataEventRecv);

        // 加载状态
        AppId.loadingChangedEvent.connect(onLoadingChangedEventRecv);

        // 设置请求事件
        AppId.settingsRequestEvent.connect(onSettingsRequestEvent);


        // 初始化应用
        onInitApp();

        // 主窗口初始化完成
        mainHandlerId.mainWndInitComplated();

    }

    Component.onDestruction: {
        console.log("main.qml Component.onDestruction!")

        // 主题事件
        AppId.mainThemeDataEvent.disconnect(onMainThemeDataEventRecv);

        // 加载状态
        AppId.loadingChangedEvent.disconnect(onLoadingChangedEventRecv);

        // 设置请求事件
        AppId.settingsRequestEvent.disconnect(onSettingsRequestEvent);


    }

    function onInitApp() {
        console.log("main.qml onInitApp")
        let ret = -1;
        ret = AppId.initCompletedApp();
        console.log("main.qml onInitApp initCompletedApp 返回状态: " + ret);


    }

    //
    // onCloseApp : 关闭应用
    //
    function onCloseApp(exitCode = 0) {
        console.log("main.qml onCloseApp params, exitCode:" + exitCode);

        Qt.quit();

        systrapVisiable = false


    }

    //
    // onMainThemeDataEventRecv : 主窗口主题数据事件
    //
    function onMainThemeDataEventRecv(code, obj) {
        console.log("main.qml onMainThemeDataEventRecv 参数, code:" + code + ", 数据:" + JSON.stringify(obj));

        let ret = -1;
        if (code === 0) {
            // 基本信息
            if (obj.hasOwnProperty('name')) {
                AppId.setClientName(obj['name']);
            }
            if (obj.hasOwnProperty('version')) {
                AppId.setVersion(obj['version']);
            }
            if (obj.hasOwnProperty('builder')) {
                AppId.setBuilder(obj['builder']);
            }
            if (obj.hasOwnProperty('github')) {
                AppId.setGithubUrl(obj['github']);
            }
            if (obj.hasOwnProperty('gitee')) {
                AppId.setGiteeUrl(obj['gitee']);
            }

            // 解析主窗口主题数据
            if (obj.hasOwnProperty('mainWnd')) {
                ret = Theme.parseMainThemeObj(code, obj["mainWnd"], mainWndId);
                console.log("main.qml onMainThemeDataEventRecv parseMainThemeObj status:" + ret);
            }

            // 解析标题栏，值存放到全局属性变量中
            if (obj.hasOwnProperty('titleBar')) {
                ret = Theme.parseTitleBarThemeObj(code, obj['titleBar'], globalPropertyId.propertyControlId);
                console.log("main.qml onMainThemeDataEventRecv parseTitleBarThemeObj status:" + ret);

                if (globalPropertyId.propertyControlId.titleBarLogoImgPath !== "") {
                    // 保存标题栏logo图片地址
                    AppId.setTitleBarLogoImg(globalPropertyId.propertyControlId.titleBarLogoImgPath);

                    // 设置消息提示框logo图片地址
                    msgBoxId.logoImg = globalPropertyId.propertyControlId.titleBarLogoImgPath;

                }

            }

            // 解析状态栏
            if (obj.hasOwnProperty('statusBar')) {
                ret = Theme.parseStatusBarThemeObj(code, obj['statusBar'], globalPropertyId.propertyControlId);
                console.log("main.qml onMainThemeDataEventRecv parseStatusBarThemeObj status:" + ret);
            }

            // 解析左侧面板
            if (obj.hasOwnProperty('leftPanel')) {
                ret = Theme.parseLeftPanelThemeObj(code, obj['leftPanel'], leftPanelBarId);
                console.log("main.qml onMainThemeDataEventRecv parseLeftPanelThemeObj status:" + ret);
            }

            // 页面窗口
            if (obj.hasOwnProperty('pageBox')) {
                ret = Theme.parsePageBoxThemeObj(code, obj['pageBox'], globalPropertyId.propertyControlId);
                console.log("main.qml onMainThemeDataEventRecv parsePageBoxThemeObj status:" + ret);
            }

            // webToolBar
            if (obj.hasOwnProperty('webToolBar')) {
                ret = Theme.parseWebToolBarThemeObj(code, obj['webToolBar'], globalPropertyId.propertyControlId);
                console.log("main.qml onMainThemeDataEventRecv parseWebToolBarThemeObj status:" + ret);
            }

        }

        // 初始化应用数据
        onInitAppData();

    }

    //
    // onInitAppData : 初始化应用数据
    //
    function onInitAppData() {
        console.log("main.qml onInitAppData");

        // 判断默认是否最大化显示
        let cfgDefMaximized = GlobalHandlerId.getDefMaximized();
        console.log("main.qml onInitAppData getDefMaximized:" + cfgDefMaximized);

        if (cfgDefMaximized > 0) {
            mainWndId.defMaximized = true;
        }
        else {
            mainWndId.defMaximized = false;
        }

        if (mainWndId.defMaximized) {
            onMaxWndEvent("onInitAppData");
        }

        // 初始化TAB页面
        let leftPanelCurrentIndex = leftPanelBarId.getCurrentIndex();
        let leftPanelCurrentItemObj = leftPanelBarId.getItem(leftPanelCurrentIndex);
        if (leftPanelCurrentIndex >= 0 && leftPanelCurrentItemObj !== null) {
            onSwitchBoxPage(leftPanelCurrentIndex, leftPanelCurrentItemObj);
        }


    }

    //
    // onMinWndEvent : 最小化窗口事件
    //
    function onMinWndEvent(source) {
        console.log("main.qml onMinWndEvent params, source:" + source);

        console.log("main.qml onMinWndEvent wnd width:" + mainWndId.width);
        console.log("main.qml onMinWndEvent wnd height:" + mainWndId.height);

        //mainWndId.showMinimized();
        mainWndId.hide();
    }

    //
    // onMaxWndEvent : 最大化窗口事件
    //
    function onMaxWndEvent(source) {
        console.log("main.qml onMaxWndEvent params, source:" + source);

        console.log("main.qml onMaxWndEvent wnd width:" + mainWndId.width);
        console.log("main.qml onMaxWndEvent wnd height:" + mainWndId.height);
        console.log("main.qml onMaxWndEvent screen width:" + Screen.desktopAvailableWidth);
        console.log("main.qml onMaxWndEvent screen height:" + Screen.desktopAvailableHeight);

        if (mainWndId.width >= Screen.desktopAvailableWidth
                && mainWndId.height >= Screen.desktopAvailableHeight) {

            mainWndId.width = mainWndId.tmpWndWidth;
            mainWndId.height = mainWndId.tmpWndHeight;

            mainWndId.showNormal();
            console.log("main.qml onMaxWndEvent showNormal");
        }
        else {
            mainWndId.tmpWndWidth = mainWndId.width;
            mainWndId.tmpWndHeight = mainWndId.height;

            mainWndId.x = 0;
            mainWndId.y = 0;
            mainWndId.width = Screen.desktopAvailableWidth;
            mainWndId.height = Screen.desktopAvailableHeight;

            mainWndId.showMaximized();
            console.log("main.qml onMaxWndEvent maximized");
        }

    }

    //
    // onShowWnd : 显示窗口
    //
    function onShowWnd() {
        console.log("main.qml onShowWnd");

        console.log("main.qml onShowWnd wnd width:" + mainWndId.width);
        console.log("main.qml onShowWnd wnd height:" + mainWndId.height);

        if (!mainWndId.visible) {
            mainWndId.show();
        }
        mainWndId.requestActivate();
    }

    //
    // onSystemTrayClick : 托盘单击事件
    //
    function onSystemTrayClick() {
        console.log("main.qml onSystemTrayClick");

        onShowWnd();

    }

    //
    // onLoadingChangedEventRecv : 加载状态改变事件
    //
    function onLoadingChangedEventRecv(isLoading, source) {
        console.log("main.qml onLoadingChangedEventRecv params, isLoading:" + isLoading + ", source:" + source);

        if (isLoading) {
            waitLoadingId.beginShow();
        }
        else {
            waitLoadingId.endShow();
        }

    }

    //
    // onSettingsRequestEvent : 设置请求事件
    //
    function onSettingsRequestEvent(source, args) {
        console.log("main.qml onExitAppRequestEvent params, source:" + source + ", args:" + JSON.stringify(args));

        if (source === "exitAppId") {
            // 退出
            let isconfirm = false;
            if (args.hasOwnProperty('confirm')) {
                isconfirm = args['confirm'];
            }
            console.log("main.qml onExitAppRequestEvent confirm:" + isconfirm);

            if (!isconfirm) {
                // 直接关闭
                onCloseApp(0);
            }

            msgBoxId.beginShow(2, "确定要退出应用吗", "警告", "exitAppEvent", args);

        }
        else if (source === "systemSettingId") {
            // 系统设置
            systemSetId.beginShow();

        }
        else if (source === "aboutId") {
            // 关于
            aboutId.beginShow();
        }

    }

    //
    // onMsgBoxBtnClickEvent : 消息提示框事件
    //
    function onMsgBoxBtnClickEvent(isYes, source, owner) {
        console.log("main.qml onMsgBoxBtnClickEvent params, isYes:" + isYes + ", source:" + source + ", owner:" + JSON.stringify(owner));

        if (source === "exitAppEvent") {
            // 关闭事件
            if (isYes) {
                onCloseApp(0);
            }
        }

    }

    //
    // onInitBoxPage : 初始化页面
    //
    function onInitBoxPage(list, curSelIdx) {
        console.log("main.qml onInitBoxPage params, curSelIdx:" + curSelIdx + ", list:" + JSON.stringify(list));

        // 创建页面列表
        for(let idx = 0; idx < list.length; idx++) {
            let itemObj = list[idx];

            let itemExecWay = itemObj["execWay"];
            if (Helper.execWayPageIsWebEngine(itemExecWay)) {
                // 创建web页面列表
                let pageUrl = itemObj["execViewPath"]
                if (pageUrl === undefined || pageUrl === null || pageUrl === "") {
                    pageUrl = "qrc:/uipages/webpage/WebPage.qml"
                }
                pageUrl = GlobalHandlerId.nativeToPath(pageUrl);
                console.log("main.qml onInitBoxPage native pageUrl:" + pageUrl);

                // 追加参数
                itemObj = Helper.appendWebToolBarArgs(itemObj, globalPropertyId.propertyControlId);

                let pageWndObj = Helper.createInitPageComponent(pageUrl, itemObj, rightPageContentId);
                if (pageWndObj === null) {
                    console.error("main.qml onInitBoxPage createInitPageComponent fail, pageUrl:" + pageUrl);
                    continue;
                }

                rightPageContentId.addPageComponent(pageWndObj, (idx === curSelIdx ? true : false));

            }
        }

    }

    //
    // onSwitchBoxPage : 切换页面
    //
    function onSwitchBoxPage(index, args) {
        console.log("main.qml onSwitchBoxPage params, index:" + index + ", args:" + JSON.stringify(args));

        // 判断是否允许切换，如果不允许则直接返回
        if (!Helper.getExewayAllowChecked(args["execWay"])) {
            console.log("main.qml onSwitchBoxPage getExewayAllowChecked false, execWay:" + args["execWay"]);

            if (Helper.execWayPageIsPopup(args["execWay"])) {
                // 打开页面
                let openObj = Helper.createOpenPageComponent(args["execPath"],
                                                             args["execWay"],
                                                             args,
                                                             leftPanelBarId);
                console.log("main.qml onSwitchBoxPage createOpenPageComponent status:" + (openObj !== null ? "ok" : "fail"));


            }

            return -2;
        }

        // 切换页面
        let ret = rightPageContentId.switchPage(args);
        console.log("main.qml onSwitchBoxPage switchPage status:" + ret);

        return ret;
    }



}
