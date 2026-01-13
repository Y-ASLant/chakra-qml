pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import Chakra

/*
    CWindowControls - 窗口控制按钮组

    == 属性 ==
    showThemeToggle : 是否显示主题切换按钮，默认 true
    showMinimize    : 是否显示最小化按钮，默认 true
    showMaximize    : 是否显示最大化按钮，默认 true
    showClose       : 是否显示关闭按钮，默认 true
    targetWindow    : 目标窗口引用（必须传入）

    == 暴露的按钮项 ==
    themeBtn       : 主题切换按钮
    minimizeBtn    : 最小化按钮
    maximizeBtn    : 最大化按钮
    closeBtn       : 关闭按钮

    == 信号 ==
    themeToggled    : 主题切换按钮点击
*/
Row {
    id: root

    property bool showThemeToggle: true
    property bool showMinimize: true
    property bool showMaximize: true
    property bool showClose: true
    property var targetWindow: null

    signal themeToggled()

    spacing: 10

    readonly property alias themeBtn: themeButton
    readonly property alias minimizeBtn: minimizeButton
    readonly property alias maximizeBtn: maximizeButton
    readonly property alias closeBtn: closeButton

    CWindowButton {
        id: themeButton
        visible: root.showThemeToggle
        iconName: AppStyle.isDark ? "sun" : "moon"
        onClicked: root.themeToggled()
    }

    CWindowButton {
        id: minimizeButton
        visible: root.showMinimize
        iconName: "minus"
        onClicked: if (root.targetWindow) root.targetWindow.showMinimized()
    }

    CWindowButton {
        id: maximizeButton
        visible: root.showMaximize
        iconName: root.targetWindow && root.targetWindow.visibility === Window.Maximized ? "copy" : "square"
        onClicked: {
            if (!root.targetWindow) return;
            if (root.targetWindow.visibility === Window.Maximized) {
                root.targetWindow.showNormal();
            } else {
                root.targetWindow.showMaximized();
            }
        }
    }

    CWindowButton {
        id: closeButton
        visible: root.showClose
        iconName: "x"
        isClose: true
        onClicked: if (root.targetWindow) root.targetWindow.close()
    }
}
