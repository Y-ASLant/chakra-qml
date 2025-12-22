pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import Chakra

/*
    CWindow - 无边框圆角窗口组件

    == 组件库特有属性 ==
    showTitleBar      : 是否显示标题栏，默认 true
    showTitle         : 是否显示标题文字，默认 true
    showThemeToggle   : 是否显示主题切换按钮，默认 true
    showMinimize      : 是否显示最小化按钮，默认 true
    showMaximize      : 是否显示最大化按钮，默认 true
    showClose         : 是否显示关闭按钮，默认 true
    titleBarHeight    : 标题栏高度，默认 40
    titleBarContent   : 标题栏自定义内容（Component 类型）
    shadowEnabled     : 是否启用阴影，默认 true
    resizable         : 是否可调整大小，默认 true
    resizeMargin      : 调整大小的边缘宽度，默认 4
*/
ApplicationWindow {
    id: window

    color: "transparent"
    flags: Qt.Window | Qt.FramelessWindowHint

    // 是否显示标题栏
    property bool showTitleBar: true

    // 是否显示标题文字
    property bool showTitle: true

    // 标题栏自定义内容
    property alias titleBarContent: titleBarContentLoader.sourceComponent

    // 标题栏按钮控制
    property bool showThemeToggle: true
    property bool showMinimize: true
    property bool showMaximize: true
    property bool showClose: true

    // 标题栏高度
    property int titleBarHeight: 40

    // 阴影（由 CFrameless 原生 DWM 提供）
    property bool shadowEnabled: true

    // 标题栏项（供 CFrameless 识别拖拽区域）
    property Item titleBarItem: null

    // 内容区域
    default property alias content: contentArea.data

    // 覆盖层容器（用于 Dialog、Drawer 等需要覆盖整个窗口的组件）
    property alias overlay: overlayArea.data

    // 暴露 frameless 实例供其他组件使用
    property alias framelessInstance: frameless

    // 原生窗口框架（Windows 原生拖拽、调整大小、DWM 阴影）
    CFrameless {
        id: frameless
        disabled: false

        Component.onCompleted: {
            window.titleBarItem = titleBar;
            if (window.showThemeToggle)
                frameless.setHitTestVisible(themeToggleBtn);
            if (window.showMinimize)
                frameless.setHitTestVisible(minimizeBtn);
            if (window.showMaximize)
                frameless.setHitTestVisible(maximizeBtn);
            if (window.showClose)
                frameless.setHitTestVisible(closeBtn);
        }
        Component.onDestruction: {
            frameless.onDestruction();
        }
    }

    // 内容容器（原生 DWM 阴影不占用空间，无需边距）
    Item {
        anchors.fill: parent

        // 内容容器（带阴影和圆角）
        Rectangle {
            id: contentWrapper
            anchors.fill: parent
            radius: window.visibility === Window.Maximized ? 0 : AppStyle.windowRadius
            color: AppStyle.backgroundColor
            antialiasing: true
            smooth: true

            Behavior on color {
                ColorAnimation {
                    duration: AppStyle.durationNormal
                    easing.type: Easing.OutCubic
                }
            }

            // 阴影由 CFrameless 的原生 DWM 提供，这里只需要圆角遮罩
            // 最大化/全屏时禁用layer效果以优化性能
            layer.enabled: window.visibility !== Window.Maximized && window.visibility !== Window.FullScreen
            layer.smooth: true
            layer.samples: 8
            layer.effect: MultiEffect {
                maskEnabled: true
                maskThresholdMin: 0.5
                maskSpreadAtMin: 1.0
                maskSource: ShaderEffectSource {
                    sourceItem: Rectangle {
                        width: contentWrapper.width
                        height: contentWrapper.height
                        radius: AppStyle.windowRadius
                        antialiasing: true
                        smooth: true
                        layer.enabled: true
                        layer.smooth: true
                        layer.samples: 8
                    }
                    smooth: true
                    hideSource: true
                }
            }
        }

        // 自定义标题栏
        Item {
            id: titleBar
            visible: window.showTitleBar
            width: parent.width
            height: window.titleBarHeight
            z: 10

            // 标题文字
            Text {
                id: titleText
                visible: window.showTitle && window.title !== ""
                text: window.title
                font.pixelSize: AppStyle.fontSizeMd
                font.weight: Font.Medium
                color: AppStyle.textColor
                anchors.left: parent.left
                anchors.leftMargin: AppStyle.spacing4
                anchors.verticalCenter: parent.verticalCenter
            }

            // 自定义标题栏内容
            Loader {
                id: titleBarContentLoader
                anchors.left: window.showTitle && window.title !== "" ? titleText.right : parent.left
                anchors.leftMargin: window.showTitle && window.title !== "" ? AppStyle.spacing3 : AppStyle.spacing4
                anchors.right: windowControls.left
                anchors.rightMargin: AppStyle.spacing2
                anchors.verticalCenter: parent.verticalCenter
            }

            // 窗口控制按钮
            Row {
                id: windowControls
                anchors.right: parent.right
                anchors.rightMargin: AppStyle.spacing2
                anchors.verticalCenter: parent.verticalCenter
                spacing: 10

                // 主题切换
                Rectangle {
                    id: themeToggleBtn
                    visible: window.showThemeToggle
                    width: 32
                    height: 32
                    radius: AppStyle.radiusSm
                    color: themeArea.containsMouse ? (AppStyle.isDark ? Qt.rgba(255, 255, 255, 0.1) : Qt.rgba(0, 0, 0, 0.06)) : "transparent"

                    Behavior on color {
                        ColorAnimation {
                            duration: AppStyle.durationFast
                            easing.type: Easing.OutCubic
                        }
                    }

                    CIcon {
                        anchors.centerIn: parent
                        name: AppStyle.isDark ? "sun" : "moon"
                        size: 16
                        iconColor: AppStyle.textSecondary
                    }

                    MouseArea {
                        id: themeArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: AppStyle.toggleTheme()
                    }
                }

                // 最小化
                Rectangle {
                    id: minimizeBtn
                    visible: window.showMinimize
                    width: 32
                    height: 32
                    radius: AppStyle.radiusSm
                    color: minArea.containsMouse ? (AppStyle.isDark ? Qt.rgba(255, 255, 255, 0.1) : Qt.rgba(0, 0, 0, 0.06)) : "transparent"

                    Behavior on color {
                        ColorAnimation {
                            duration: AppStyle.durationFast
                            easing.type: Easing.OutCubic
                        }
                    }

                    CIcon {
                        anchors.centerIn: parent
                        name: "minus"
                        size: 16
                        iconColor: AppStyle.textSecondary
                    }

                    MouseArea {
                        id: minArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: window.showMinimized()
                    }
                }

                // 最大化/还原
                Rectangle {
                    id: maximizeBtn
                    visible: window.showMaximize
                    width: 32
                    height: 32
                    radius: AppStyle.radiusSm
                    color: maxArea.containsMouse ? (AppStyle.isDark ? Qt.rgba(255, 255, 255, 0.1) : Qt.rgba(0, 0, 0, 0.06)) : "transparent"

                    Behavior on color {
                        ColorAnimation {
                            duration: AppStyle.durationFast
                            easing.type: Easing.OutCubic
                        }
                    }

                    CIcon {
                        anchors.centerIn: parent
                        name: window.visibility === Window.Maximized ? "copy" : "square"
                        size: 14
                        iconColor: AppStyle.textSecondary
                    }

                    MouseArea {
                        id: maxArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (window.visibility === Window.Maximized) {
                                window.showNormal();
                            } else {
                                window.showMaximized();
                            }
                        }
                    }
                }

                // 关闭
                Rectangle {
                    id: closeBtn
                    visible: window.showClose
                    width: 32
                    height: 32
                    radius: AppStyle.radiusSm
                    color: closeArea.containsMouse ? "#e53e3e" : "transparent"

                    Behavior on color {
                        ColorAnimation {
                            duration: AppStyle.durationFast
                            easing.type: Easing.OutCubic
                        }
                    }

                    CIcon {
                        anchors.centerIn: parent
                        name: "x"
                        size: 16
                        iconColor: closeArea.containsMouse ? "white" : AppStyle.textSecondary

                        Behavior on iconColor {
                            ColorAnimation {
                                duration: AppStyle.durationFast
                                easing.type: Easing.OutCubic
                            }
                        }
                    }

                    MouseArea {
                        id: closeArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: window.close()
                    }
                }
            }
        }

        // 内容区域
        Item {
            id: contentArea
            anchors.fill: parent
            anchors.topMargin: window.showTitleBar ? window.titleBarHeight : 0
        }

        // 覆盖层区域（用于 Dialog、Drawer 等）
        Item {
            id: overlayArea
            anchors.fill: parent
            z: 100
        }
    }
}
