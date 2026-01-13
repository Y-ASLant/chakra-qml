pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import Chakra

/*
    CWindowButton - 窗口标题栏按钮组件

    == 属性 ==
    iconName     : 图标名称
    isClose      : 是否为关闭按钮（默认 false，关闭按钮有特殊悬停样式）
    hoveredColor : 悬停时颜色（可选，关闭按钮默认为红色）

    == 信号 ==
    clicked      : 点击时触发
*/
Rectangle {
    id: root

    property string iconName
    property bool isClose: false
    property color hoveredColor: isClose ? "#e53e3e" : (AppStyle.isDark ? Qt.rgba(1, 1, 1, 0.1) : Qt.rgba(0, 0, 0, 0.06))

    signal clicked()

    width: 32
    height: 32
    radius: AppStyle.radiusSm
    color: mouseArea.containsMouse ? hoveredColor : "transparent"

    Behavior on color {
        ColorAnimation {
            duration: AppStyle.durationFast
            easing.type: Easing.OutCubic
        }
    }

    CIcon {
        anchors.centerIn: parent
        name: root.iconName
        size: root.isClose ? 16 : (root.iconName === "square" ? 14 : 16)
        iconColor: root.isClose && mouseArea.containsMouse ? "white" : AppStyle.textSecondary

        Behavior on iconColor {
            ColorAnimation {
                duration: AppStyle.durationFast
                easing.type: Easing.OutCubic
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}
