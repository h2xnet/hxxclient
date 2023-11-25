import QtQuick 2.0
import QtQuick.Controls 2.12
import QtWebEngine 1.8
import QtWebChannel 1.0

/*
 * ClassName: WebEngineCustom
 * Desc: 浏览器页面
 * Author: zfs
 * Date: 2023-10-23 20:53
 */
Rectangle {
    id: controlId

    signal webEngineViewRecv(int code, var result);
    signal webEngineCertificateError(var error);
    signal webEngineViewLoading(bool isLoading);
    signal webEngineViewLoadProgressChanged(int percent);

    property alias webEngineControlId: webEngineViewId

    property var backgroundColor: "transparent"
    property int borderRadius: 4
    property int borderWidth: 1
    property var borderColor: "#CCCCCC"

    property int leftPadding: 10
    property int topPadding: 10
    property int rightPadding: 10
    property int bottomPadding: 10

    property var baseUrl: "" // 打开的URL

    color: backgroundColor
    radius: borderRadius
    border.width: borderWidth
    border.color: borderColor

    width: parent.width
    height: parent.height

    WebEngineView {
        id: webEngineViewId

        anchors {
            left: parent.left
            leftMargin: leftPadding
            top: parent.top
            topMargin: topPadding
        }

        width: parent.width - leftPadding - rightPadding
        height: parent.height - topPadding - bottomPadding

        //user Scripts:
        webChannel: WebChannel {
            id: webChannelId
        }

        // 设置 WebEngine 设置以支持自动弹出子页面
        settings {
            javascriptEnabled: true

        }

        QtObject {
            id: jsBridgeId

            function send(code, result)
            {
                console.log("WebEngineCustom.qml send params, code:" + code + ", result:" + JSON.stringify(result));

                webEngineViewRecv(code, result);
            }
        }

        Component.onCompleted: {
            webChannelId.registerObject("jsBridge", jsBridgeId);


        }

        Component.onDestruction: {

        }

        onCertificateError: function(err) {
            webEngineCertificateError(err);

        }

        onLoadProgressChanged: function() {
            let percent = webEngineViewId.loadProgress;
            //console.log("WebEngineCustom.qml onLoadProgressChanged, percent:" + percent);

            webEngineViewLoadProgressChanged(percent);

        }

        onLoadingChanged: function(loadRequest) {
            let isLoading = webEngineViewId.loading;
            //console.log("WebEngineCustom.qml onLoadingChanged loading:" + isLoading);

            // 发送通知信号
            webEngineViewLoading(isLoading);

        }

        onNewViewRequested: function(request) {
            // 打开子页面
            let subUrl = request.requestedUrl
            console.log("WebEngineCustom.qml onNewViewRequested sub url: " + subUrl);

            openUrl(subUrl);

        }


    } // end webEngineViewId WebEngineView

    function openUrl(strUrl) {
        console.log("WebEngineCustom.qml openUrl params, url:" + strUrl);

        // 保存
        baseUrl = strUrl;

        webEngineViewId.url = strUrl;


    }

    //
    // reload : 刷新
    //
    function reload() {
        webEngineViewId.reload();
    }

    //
    // gotoBack : 返回
    //
    function gotoBack() {
        webEngineViewId.goBack();
    }

    //
    // gotoForward : 前进
    //
    function gotoForward() {
        webEngineViewId.goForward();
    }

    //
    // stop : 停止
    //
    function stop() {
        webEngineViewId.stop();
    }

    //
    // gotoHome : 返回主页
    //
    function gotoHome() {
        if (baseUrl !== "") {
            while(webEngineViewId.canGoBack) {
                webEngineViewId.goBack();
            }

        }
    }

}
