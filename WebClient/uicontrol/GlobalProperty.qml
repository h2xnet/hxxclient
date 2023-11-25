import QtQuick 2.0

/*
 * ClassName: GlobalProperty
 * Desc: 全局属性类
 * Author: zfs
 * Date: 2023-10-21 07:31
 */
Item {

    property alias propertyControlId: globalPropertyId

    QtObject {
        id: globalPropertyId

        // 标题栏属性
        // 标题栏基本信息
        property int titleBarHeight: 60
        property int titleBarBorderRadius: 4
        property var titleBarBackgroundColor: "#F5F5F5"

        // 标题栏图标信息
        property var titleBarLogoImgPath: "qrc:/statics/logo/logo.png"
        property int titleBarLogoImgWidth: 32
        property int titleBarLogoImgHeight: 32
        property int titleBarLogoImgLeftPadding: 15
        property int titleBarLogoImgTopPadding: 8

        // 标题栏标题信息
        property var titleBarTitleText: "网络客户端"
        property var titleBarTitleTextAlign: "left"
        property int titleBarTitleTextLeftPadding: 55
        property int titleBarTitleTextTopPadding: 15
        property int titleTextFontPixelSize: 18
        property var titleTextFontColor: "#FF2288"
        property bool titleTextFontBold: false

        // 系统菜单按钮
        // 最小化按钮
        property var systemMenuMinBtnId: "systemMenuMinId"
        property bool systemMenuMinBtnVisiable: true
        property var systemMenuMinBtnTipText: "最小化"
        property var systemMenuMinBtnImgPath: "qrc:/statics/imgs/minus.png"
        property int systemMenuMinBtnWidth: 24
        property int systemMenuMinBtnHeight: 24
        property int systemMenuMinBtnImgWidth: 14
        property int systemMenuMinBtnImgHeight: 14
        property var systemMenuMinBtnBackgroundColor: "transparent"
        property int systemMenuMinBtnTopPadding: 10
        property int systemMenuMinBtnRightPadding: 95
        property int systemMenuMinBtnBorderWidth: 1
        property var systemMenuMinBtnBorderColor: "#CCCCCC"
        property bool systemMenuMinBtnBorderVisiable: true
        property bool systemMenuMinBtnHoverBorderVisiable: false

        // 最大化按钮
        property var systemMenuMaxBtnId: "systemMenuMaxId"
        property bool systemMenuMaxBtnVisiable: true
        property var systemMenuMaxBtnTipText: "最大化"
        property var systemMenuMaxBtnImgPath: "qrc:/statics/imgs/maximize.png"
        property int systemMenuMaxBtnWidth: 24
        property int systemMenuMaxBtnHeight: 24
        property int systemMenuMaxBtnImgWidth: 14
        property int systemMenuMaxBtnImgHeight: 14
        property var systemMenuMaxBtnBackgroundColor: "transparent"
        property int systemMenuMaxBtnTopPadding: 10
        property int systemMenuMaxBtnRightPadding: 55
        property int systemMenuMaxBtnBorderWidth: 1
        property var systemMenuMaxBtnBorderColor: "#CCCCCC"
        property bool systemMenuMaxBtnBorderVisiable: true
        property bool systemMenuMaxBtnHoverBorderVisiable: false

        // 关闭按钮
        property var systemMenuCloseBtnId: "systemMenuCloseId"
        property bool systemMenuCloseBtnVisiable: true
        property var systemMenuCloseBtnTipText: "关闭"
        property var systemMenuCloseBtnImgPath: "qrc:/statics/imgs/close_svg.svg"
        property int systemMenuCloseBtnWidth: 24
        property int systemMenuCloseBtnHeight: 24
        property int systemMenuCloseBtnImgWidth: 14
        property int systemMenuCloseBtnImgHeight: 15
        property var systemMenuCloseBtnBackgroundColor: "transparent"
        property int systemMenuCloseBtnTopPadding: 10
        property int systemMenuCloseBtnRightPadding: 15
        property int systemMenuCloseBtnBorderWidth: 1
        property var systemMenuCloseBtnBorderColor: "#CCCCCC"
        property bool systemMenuCloseBtnBorderVisiable: true
        property bool systemMenuCloseBtnHoverBorderVisiable: false

        // 状态栏
        property int statusBarHeight: 40
        property int statusBarBorderRadius: 4
        property var statusBarBackgroundColor: "#F5F5F5"
        property int statusBarBorderWidth: 1
        property var statusBarBorderColor: "#CCCCCC"

        // 左侧面板
        property bool foldState: true
        property int foldWidth: 120
        property int unfoldWidth: 220

        property var backgroundColor: "#333333"
        property int borderRadius: 4
        property int borderWidth: 1
        property var borderColor: "#CCCCCC"

        // 页面窗口
        property int pageBoxRadius: 4
        property var pageBoxBackgroundColor: "transparent"
        property int pageBoxSpaceWidth: 0
        property int pageBoxSpaceHeight: 0

        // TAB头控件
        property bool tabHeadBarVisiable: true
        property int tabHeadBarHeight: 40
        property var tabHeadBarBackgroundColor: "#228899"
        property int tabHeadBarBorderRadius: 4

        property int tabHeadBarBorderWidth: 1
        property var tabHeadBarBorderColor: "#CCCCCC"

        property int tabHeadBarLeftPadding: 200
        property int tabHeadBarTopPadding: 40
        property int tabHeadBarRightPadding: 200
        property int tabHeadBarBottomPadding: 0

        // webToolBar
        property int webToolBarBorderRadius: 4
        property int webToolBarBorderWidth: 1
        property var webToolBarBorderColor: "#DDDDDD"
        property var webToolBarBackgroundColor: "#C3C3C3"
        property int webToolBarLeftPadding: 10
        property int webToolBarBottomPadding: 20



    } // end globalPropertyId QtObject

}
