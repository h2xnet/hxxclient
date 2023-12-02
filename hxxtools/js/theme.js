/*
 * theme.js : 主题代码处理器
 */

//
// getLeftPanelDatas : 获取左侧面板数据集
//
function getLeftPanelDatas() {
    let list = [];

    list.push({
                  "id":"menuTextId",
                  "align": "top",
                  "topPadding": 0,
                  "bottomPadding": 0,
                  "text": "文本",
                  "textLeftPadding": 45,
                  "textFontPixelSize": 16,
                  "textFontColor": "#333333",
                  "textBold": false,
                  "imgPath": "qrc:/statics/imgs/panel/panel1.png",
                  "imgWidth": 32,
                  "imgHeight": 32,
                  "imgLeftPadding": 8,
                  "imgTopPadding": 8,
                  "execWay": "embedweb",
                  "execPath": "",
                  "execCmd":"",
                  "execViewPath": "qrc:/uipages/text/JsonPage.qml",
                  "page": {
                      "backgroundColor": "#FFFFFF",
                      "radius": 4,
                      "leftPadding": 0,
                      "topPadding": 0,
                      "rightPadding": 0,
                      "bottomPadding": 0
                  }
              });

    return list;
}
