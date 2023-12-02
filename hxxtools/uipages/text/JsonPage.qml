import QtQuick 2.0
import QtQuick 2.12

import hxxTools.net.pc  1.0

import "../../uicontrol/button"

Rectangle {
    id: controlId

    // 初始化页面事件
   signal initPage(var args);
   signal showOrHide(bool isShow);

    property int defBtnWidth: 120
    property int defBtnHeight: 40
    property int defBtnBorderRadius: 8

    property var backgroundColor: "transparent"
    property int borderRadius: 4


    anchors.fill: parent

   color: backgroundColor
   radius: borderRadius

   // json格式化按钮
   ColorButton {
        id: jsonBtnId

        anchors {
            left: parent.left
            leftMargin: 20
            top: parent.top
            topMargin: 20
        }

        labelText: "JSON文件格式化"
        width: defBtnWidth
        height: defBtnHeight
        borderRadius: defBtnBorderRadius

        onColorButtonClick: {
            onBtnClickEvent("jsonBtnId", "");
        }

   } // end jsonBtnId ColorButton

   Component.onCompleted: {
       console.log("JsonPage.qml Component.onCompleted");

   }

   Component.onDestruction: {
       console.log("JsonPage.qml Component.onDestruction");
   }

   //
   // onInitPage : 初始化页面
   //
   onInitPage: function(args) {
       console.log("JsonPage.qml onInitPage params, " + JSON.stringify(args));

   }

   //
   // onShowOrHide : 显示或隐藏页面
   //
   onShowOrHide: function(isShow) {
       console.log("JsonPage.qml onShowOrHide params, isShow:" + isShow);
       controlId.visible = isShow;
   }

   //
   // onBtnClickEvent : 按钮事件
   //
   function onBtnClickEvent(eventId, params) {
        GlobalHandlerId.toolBarRequest(eventId, params);
   }

}
