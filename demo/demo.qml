import QtQuick
import QtQuick.Window
import "../src/Chakra"

Window {
    visible: true
    width: 640
    height: 360
    title: "Chakra UI QML - 基础示例"
    color: AppStyle.backgroundColor

    CCard {
        width: parent.width * 0.8
        title: "选择器示例"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        spacing: AppStyle.spacing4

        CCheckbox {
            text: "复选框选项"
        }

        CSwitch {
            text: "开关按钮"
        }
    }
}
