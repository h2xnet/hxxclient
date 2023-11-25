/*
 * theme.js : 主题代码处理器
 */

/*
 * Func: parseMainThemeObj
 * Desc: 解析主窗口主题对象
 * Author: zfs
 * Date: 2023-10-17 21:15
 */
function parseMainThemeObj(code, obj, targetId) {
    if (code !== 0) {
        return -1;
    }

    if (obj === undefined || obj === null) {
        return -2;
    }

    if (targetId === undefined || targetId === null) {
        return -3;
    }

    let count = 0;
    // 主窗口属性
    if (obj.hasOwnProperty('minWndWidth')) {
        targetId.minWndWidth = obj["minWndWidth"];
        count++;
    }

    if (obj.hasOwnProperty('minWndHeight')) {
        targetId.minWndHeight = obj['minWndHeight'];
        count++;
    }

    if (obj.hasOwnProperty('defWndWidth')) {
        //targetId.defWndWidth = obj['defWndWidth'];
        targetId.width = obj['defWndWidth'];
        count++;
    }

    if (obj.hasOwnProperty('defWndHeight')) {
        //targetId.defWndHeight = obj['defWndHeight'];
        targetId.height = obj['defWndHeight'];
        count++;
    }

    if (obj.hasOwnProperty('defMaximized')) {
        targetId.defMaximized = obj['defMaximized'];
        count++;
    }

    if (obj.hasOwnProperty('backgroundModel')) {
        targetId.backgroundModel = obj['backgroundModel'];
        count++;
    }

    if (obj.hasOwnProperty('backgroundColor')) {
        targetId.backgroundColor = obj['backgroundColor'];
        count++;
    }

    if (obj.hasOwnProperty('backgroundImage')) {
        targetId.backgroundImage = obj['backgroundImage'];
        count++;
    }

    // 主窗口边框属性
    if (obj.hasOwnProperty('radius')) {
        targetId.borderRadius = obj['radius'];
        count++;
    }

    if (obj.hasOwnProperty('borderWidth')) {
        targetId.borderWidth = obj['borderWidth'];
        count++;
    }

    if (obj.hasOwnProperty('borderColor')) {
        targetId.borderColor = obj['borderColor'];
        count++;
    }

    // 托盘属性
    if (obj.hasOwnProperty('systrap')) {
        let systrapObj = obj['systrap'];

        if (systrapObj.hasOwnProperty('visiable')) {
            targetId.systrapVisiable = systrapObj['visiable'];
        }

        if (systrapObj.hasOwnProperty('tipText')) {
            targetId.systrapTipText = systrapObj['tipText'];
        }

        if (systrapObj.hasOwnProperty('imgPath')) {
            targetId.systrapImgPath = GlobalHandlerId.nativeToPath(systrapObj['imgPath']);
        }

    }

    return count;
}

/*
 * Func: parseTitleBarThemeObj
 * Desc: 解析标题栏主题对象
 * Author: zfs
 * Date: 2023-10-17 21:35
 */
function parseTitleBarThemeObj(code, obj, targetId) {
    if (code !== 0) {
        return -1;
    }

    if (obj === undefined || obj === null) {
        return -2;
    }

    if (targetId === undefined || targetId === null) {
        return -3;
    }

    let count = 0;

    if (obj.hasOwnProperty('height')) {
        targetId.titleBarHeight = obj['height'];
        count++;
    }

    if (obj.hasOwnProperty('radius')) {
        targetId.titleBarBorderRadius = obj['radius'];
        count++;
    }

    if (obj.hasOwnProperty('backgroundColor')) {
        targetId.titleBarBackgroundColor = obj['backgroundColor'];
        count++;
    }

    // 图标
    if (obj.hasOwnProperty('icon')) {
        let iconObj = obj['icon'];

        if (iconObj.hasOwnProperty('width')) {
            targetId.titleBarLogoImgWidth = iconObj['width'];
            count++;
        }

        if (iconObj.hasOwnProperty('height')) {
            targetId.titleBarLogoImgHeight = iconObj['height'];
            count++;
        }

        if (iconObj.hasOwnProperty('imgPath')) {
            targetId.titleBarLogoImgPath = GlobalHandlerId.nativeToPath(iconObj['imgPath']);
            count++;
        }

        if (iconObj.hasOwnProperty('leftPadding')) {
            targetId.titleBarLogoImgLeftPadding = iconObj['leftPadding'];
            count++;
        }

        if (iconObj.hasOwnProperty('topPadding')) {
            targetId.titleBarLogoImgTopPadding = iconObj['topPadding'];
            count++;
        }

    }

    // 标题
    if (obj.hasOwnProperty('title')) {
        let titleObj = obj['title'];

        if (titleObj.hasOwnProperty('text')) {
            targetId.titleBarTitleText = titleObj['text'];
            count++;
        }

        if (titleObj.hasOwnProperty('fontPixelSize')) {
            targetId.titleTextFontPixelSize = titleObj['fontPixelSize'];
            count++;
        }

        if (titleObj.hasOwnProperty('fontColor')) {
            targetId.titleTextFontColor = titleObj['fontColor'];
            count++;
        }

        if (titleObj.hasOwnProperty('align')) {
            targetId.titleBarTitleTextAlign = titleObj['align'];
            count++;
        }

        if (titleObj.hasOwnProperty('leftPadding')) {
            targetId.titleBarTitleTextLeftPadding = titleObj['leftPadding'];
            count++;
        }

        if (titleObj.hasOwnProperty('topPadding')) {
            targetId.titleBarTitleTextTopPadding = titleObj['topPadding'];
            count++;
        }


        if (titleObj.hasOwnProperty('bold')) {
            targetId.titleTextFontBold = titleObj['bold'];
            count++;
        }

    }

    // 系统菜单
    if (obj.hasOwnProperty('systemMenu')) {
        let systemMenuObj = obj['systemMenu'];

        if (systemMenuObj.hasOwnProperty('menus')) {
            let menusObj = systemMenuObj['menus'];
            let idx = 0;
            for(idx = 0; idx < menusObj.length; idx++) {
                let itemObj = menusObj[idx];

                if (itemObj['id'] === "systemMenuMinId") {
                    // 最小化按钮
                    if (itemObj.hasOwnProperty('visiable')) {
                        targetId.systemMenuMinBtnVisiable = itemObj['visiable'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('tipText')) {
                        targetId.systemMenuMinBtnTipText = itemObj['tipText'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('width')) {
                        targetId.systemMenuMinBtnWidth = itemObj['width'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('height')) {
                        targetId.systemMenuMinBtnHeight = itemObj['height'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('imageWidth')) {
                        targetId.systemMenuMinBtnImgWidth = itemObj['imageWidth'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('imageHeight')) {
                        targetId.systemMenuMinBtnImgHeight = itemObj['imageHeight'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('imgPath')) {
                        targetId.systemMenuMinBtnImgPath = GlobalHandlerId.nativeToPath(itemObj['imgPath']);
                        count++;
                    }

                    if (itemObj.hasOwnProperty('backgroundColor')) {
                        targetId.systemMenuMinBtnBackgroundColor = itemObj['backgroundColor'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('topPadding')) {
                        targetId.systemMenuMinBtnTopPadding = itemObj['topPadding'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('rightPadding')) {
                        targetId.systemMenuMinBtnRightPadding = itemObj['rightPadding'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('borderWidth')) {
                        targetId.systemMenuMinBtnBorderWidth = itemObj['borderWidth'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('borderColor')) {
                        targetId.systemMenuMinBtnBorderColor = itemObj['borderColor'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('borderVisiable')) {
                        targetId.systemMenuMinBtnBorderVisiable = itemObj['borderVisiable'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('hoverBorderVisiable')) {
                        targetId.systemMenuMinBtnHoverBorderVisiable = itemObj['hoverBorderVisiable'];
                        count++;
                    }

                }
                else if (itemObj['id'] === "systemMenuMaxId") {
                    // 最大化按钮
                    if (itemObj.hasOwnProperty('visiable')) {
                        targetId.systemMenuMaxBtnVisiable = itemObj['visiable'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('tipText')) {
                        targetId.systemMenuMaxBtnTipText = itemObj['tipText'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('width')) {
                        targetId.systemMenuMaxBtnWidth = itemObj['width'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('height')) {
                        targetId.systemMenuMaxBtnHeight = itemObj['height'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('imageWidth')) {
                        targetId.systemMenuMaxBtnImgWidth = itemObj['imageWidth'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('imageHeight')) {
                        targetId.systemMenuMaxBtnImgHeight = itemObj['imageHeight'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('imgPath')) {
                        targetId.systemMenuMaxBtnImgPath = GlobalHandlerId.nativeToPath(itemObj['imgPath']);
                        count++;
                    }

                    if (itemObj.hasOwnProperty('backgroundColor')) {
                        targetId.systemMenuMaxBtnBackgroundColor = itemObj['backgroundColor'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('topPadding')) {
                        targetId.systemMenuMaxBtnTopPadding = itemObj['topPadding'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('rightPadding')) {
                        targetId.systemMenuMaxBtnRightPadding = itemObj['rightPadding'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('borderWidth')) {
                        targetId.systemMenuMaxBtnBorderWidth = itemObj['borderWidth'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('borderColor')) {
                        targetId.systemMenuMaxBtnBorderColor = itemObj['borderColor'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('borderVisiable')) {
                        targetId.systemMenuMaxBtnBorderVisiable = itemObj['borderVisiable'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('hoverBorderVisiable')) {
                        targetId.systemMenuMaxBtnHoverBorderVisiable = itemObj['hoverBorderVisiable'];
                        count++;
                    }

                }
                else if (itemObj['id'] === "systemMenuCloseId") {
                    // 关闭按钮
                    if (itemObj.hasOwnProperty('visiable')) {
                        targetId.systemMenuCloseBtnVisiable = itemObj['visiable'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('tipText')) {
                        targetId.systemMenuCloseBtnTipText = itemObj['tipText'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('width')) {
                        targetId.systemMenuCloseBtnWidth = itemObj['width'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('height')) {
                        targetId.systemMenuCloseBtnHeight = itemObj['height'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('imageWidth')) {
                        targetId.systemMenuCloseBtnImgWidth = itemObj['imageWidth'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('imageHeight')) {
                        targetId.systemMenuCloseBtnImgHeight = itemObj['imageHeight'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('imgPath')) {
                        targetId.systemMenuCloseBtnImgPath = GlobalHandlerId.nativeToPath(itemObj['imgPath']);
                        count++;
                    }

                    if (itemObj.hasOwnProperty('backgroundColor')) {
                        targetId.systemMenuCloseBtnBackgroundColor = itemObj['backgroundColor'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('topPadding')) {
                        targetId.systemMenuCloseBtnTopPadding = itemObj['topPadding'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('rightPadding')) {
                        targetId.systemMenuCloseBtnRightPadding = itemObj['rightPadding'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('borderWidth')) {
                        targetId.systemMenuCloseBtnBorderWidth = itemObj['borderWidth'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('borderColor')) {
                        targetId.systemMenuCloseBtnBorderColor = itemObj['borderColor'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('borderVisiable')) {
                        targetId.systemMenuCloseBtnBorderVisiable = itemObj['borderVisiable'];
                        count++;
                    }

                    if (itemObj.hasOwnProperty('hoverBorderVisiable')) {
                        targetId.systemMenuCloseBtnHoverBorderVisiable = itemObj['hoverBorderVisiable'];
                        count++;
                    }

                }

            }

        }

    }

    return count;
}

//
// parseStatusBarThemeObj : 解析状态栏
//
function parseStatusBarThemeObj(code, obj, targetId) {
    if (code !== 0) {
        return -1;
    }

    if (obj === undefined || obj === null) {
        return -2;
    }

    if (targetId === undefined || targetId === null) {
        return -3;
    }

    let count = 0;

    if (obj.hasOwnProperty('height')) {
        targetId.statusBarHeight = obj['height'];
        count++;
    }

    if (obj.hasOwnProperty('backgroundColor')) {
        targetId.statusBarBackgroundColor = obj['backgroundColor'];
        count++;
    }

    if (obj.hasOwnProperty('borderWidth')) {
        targetId.statusBarBorderWidth = obj['borderWidth'];
        count++;
    }

    if (obj.hasOwnProperty('borderColor')) {
        targetId.statusBarBorderColor = obj['borderColor'];
        count++;
    }

    if (obj.hasOwnProperty('radius')) {
        targetId.statusBarBorderRadius = obj['radius'];
        count++;
    }

    return count;
}

//
// parseLeftPanelThemeObj : 解析左侧面板主题
//
function parseLeftPanelThemeObj(code, obj, targetId) {
    if (code !== 0) {
        return -1;
    }

    if (obj === undefined || obj === null) {
        return -2;
    }

    if (targetId === undefined || targetId === null) {
        return -3;
    }

    let count = 0;

    if (obj.hasOwnProperty('foldState')) {
        targetId.foldState = obj['foldState'];
        count++;
    }

    if (obj.hasOwnProperty('foldWidth')) {
        targetId.foldWidth = obj['foldWidth'];
        count++;
    }

    if (obj.hasOwnProperty('unfoldWidth')) {
        targetId.unfoldWidth = obj['unfoldWidth'];
        count++;
    }

    if (obj.hasOwnProperty('backgroundColor')) {
        targetId.backgroundColor = obj['backgroundColor'];
        count++;
    }

    if (obj.hasOwnProperty('radius')) {
        targetId.borderRadius = obj['radius'];
        count++;
    }

    if (obj.hasOwnProperty('borderWidth')) {
        targetId.borderWidth = obj['borderWidth'];
        count++;
    }

    if (obj.hasOwnProperty('borderColor')) {
        targetId.borderColor = obj['borderColor'];
        count++;
    }

    if (obj.hasOwnProperty('menuBackgroundColor')) {
        targetId.menuBackgroundColor = obj['menuBackgroundColor'];
        count++;
    }

    if (obj.hasOwnProperty('menuCheckedBackgroundColor')) {
        targetId.menuCheckedBackgroundColor = obj['menuCheckedBackgroundColor'];
        count++;
    }

    if (obj.hasOwnProperty('menuTopPadding')) {
        targetId.menuTopPadding = obj['menuTopPadding'];
        count++;
    }

    if (obj.hasOwnProperty('menuBottomPadding')) {
        targetId.menuBottomPadding = obj['menuBottomPadding'];
        count++;
    }

    if (obj.hasOwnProperty('menuSpaceWidth')) {
        targetId.menuSpaceWidth = obj['menuSpaceWidth'];
        count++;
    }

    if (obj.hasOwnProperty('menuHeight')) {
        targetId.menuHeight = obj['menuHeight'];
        count++;
    }

    if (obj.hasOwnProperty('menuBorderWidth')) {
        targetId.menuBordWidth = obj['menuBorderWidth'];
        count++;
    }

    if (obj.hasOwnProperty('menuBoorderColor')) {
        targetId.menuBordColor = obj['menuBoorderColor'];
        count++;
    }

    if (obj.hasOwnProperty('menuRadius')) {
        targetId.menuBordRadius = obj['menuRadius'];
        count++;
    }

    if (obj.hasOwnProperty('menuHoverOpacity')) {
        targetId.menuHoverOpacity = obj['menuHoverOpacity'];
    }

    if (obj.hasOwnProperty('menuAllowCancel')) {
        targetId.menuAllowCancel = obj['menuAllowCancel'];
        count++;
    }

    if (obj.hasOwnProperty('currentIndex')) {
        targetId.currentIndex = obj['currentIndex'];
        count++;
    }

    if (obj.hasOwnProperty('menus')) {
        let menusObj = obj['menus'];
        if (menusObj && menusObj.length > 0) {
            targetId.init(menusObj, obj['currentIndex']);
            count += targetId.getCount();
        }
    }

    return count;
}

//
// parsePageBoxThemeObj : 解析页面窗口主题
//
function parsePageBoxThemeObj(code, obj, targetId) {
    if (code !== 0) {
        return -1;
    }

    if (obj === undefined || obj === null) {
        return -2;
    }

    if (targetId === undefined || targetId === null) {
        return -3;
    }

    let count = 0;

    if (obj.hasOwnProperty('radius')) {
        targetId.pageBoxRadius = obj['radius'];
        count++;
    }

    if (obj.hasOwnProperty('backgroundColor')) {
        targetId.pageBoxBackgroundColor = obj['backgroundColor'];
        count++;
    }

    if (obj.hasOwnProperty('spaceWidth')) {
        targetId.pageBoxSpaceWidth = obj['spaceWidth'];
        count++;
    }

    if (obj.hasOwnProperty('spaceHeight')) {
        targetId.pageBoxSpaceHeight = obj['spaceHeight'];
        count++;
    }

    return count;
}


//
// parseWebToolBarThemeObj : 解析web工具栏
//
function parseWebToolBarThemeObj(code, obj, targetId) {
    if (code !== 0) {
        return -1;
    }

    if (obj === undefined || obj === null) {
        return -2;
    }

    if (targetId === undefined || targetId === null) {
        return -3;
    }

    let count = 0;

    if (obj.hasOwnProperty('radius')) {
        targetId.webToolBarBorderRadius = obj['radius'];
        count++;
    }

    if (obj.hasOwnProperty('backgroundColor')) {
        targetId.webToolBarBackgroundColor = obj['backgroundColor'];
        count++;
    }

    if (obj.hasOwnProperty('borderWidth')) {
        targetId.webToolBarBorderWidth = obj['borderWidth'];
        count++;
    }

    if (obj.hasOwnProperty('borderColor')) {
        targetId.webToolBarBorderColor = obj['borderColor'];
        count++;
    }

    if (obj.hasOwnProperty('leftPadding')) {
        targetId.webToolBarLeftPadding = obj['leftPadding'];
        count++;
    }

    if (obj.hasOwnProperty('bottomPadding')) {
        targetId.webToolBarBottomPadding = obj['bottomPadding'];
        count++;
    }

    return count;
}
