import QtQuick
import "../src/Chakra"

CWindow {
    visible: true
    width: 800
    height: 600
    title: "无边框窗口演示"

    Column {
        anchors.centerIn: parent
        spacing: 20

        Text {
            text: "无边框窗口功能演示"
            font.pixelSize: 24
            font.bold: true
            color: AppStyle.textColor
        }
    }
}
