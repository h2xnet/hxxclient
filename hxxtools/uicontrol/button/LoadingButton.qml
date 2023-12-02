import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.0

Rectangle {
    id: containerId

    signal clicked()

    property var labelText: "登录"

    property bool loading: false // 正在加载状态

    property var normalBkColor: "#156EFF"
    property var enterBkColor: "#84B2FD"
    property var disableBkColor: "#84B2FD"
    property var normalTextColor: "#FFFFFF"
    property int borderRadius: 4
    property int labelTextFontSize: 20

    property int btnWidth: containerId.height
    property int btnHeight: containerId.height

    //
    // setLoadingState : 设置加载状态
    //
    function setLoadingState(state) {
        loading = state
    }

    function getLoadingState() {
        return loading;
    }

    anchors.fill: parent

    radius: borderRadius
    color: loading ? disableBkColor : normalBkColor
    //width: parent.width
    //height: parent.height

    Text {
        id: btnTextId

        anchors.centerIn: parent

        //font.family: printClientFontType
        //font.weight: printClientFontWeight
        font.pixelSize: labelTextFontSize
        color: normalTextColor

        text: labelText
    }

    Rectangle {

        anchors {
            verticalCenter: parent.verticalCenter
            left: btnTextId.right
            leftMargin: 5
        }

        visible: loading ? true : false
        width: btnHeight
        height: btnHeight
        color: "transparent"

        AnimatedImage {
            id: loadingImageId

            anchors.centerIn: parent

            width: parent.width
            height: parent.height
            source: "qrc:/statics/imgs/animation/loading.gif"
        }

    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: loading ? false : true                  //处理没有按下时的鼠标事件
        cursorShape: loading ? Qt.ArrowCursor : Qt.PointingHandCursor
        onClicked: {
            if (!loading) {
                containerId.clicked();
            }
        }

        onEntered: {
            if (!loading) {
                containerId.color = enterBkColor;
            }
        }

        onExited: {
            if (!loading) {
                containerId.color = normalBkColor
            }
        }

        onReleased: {
            if (!loading) {
                containerId.color = normalBkColor
            }
        }
    }

} // end containerId Rectangle
