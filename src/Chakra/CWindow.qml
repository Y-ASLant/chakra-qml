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
*/
ApplicationWindow {
    id: window

    color: "transparent"
    flags: Qt.Window | Qt.FramelessWindowHint

    property bool showTitleBar: true
    property bool showTitle: true
    property alias titleBarContent: titleBarContentLoader.sourceComponent
    property bool showThemeToggle: true
    property bool showMinimize: true
    property bool showMaximize: true
    property bool showClose: true
    property int titleBarHeight: 40
    property bool shadowEnabled: true
    property Item titleBarItem: null

    default property alias content: contentArea.data
    property alias overlay: overlayArea.data
    property alias framelessInstance: frameless

    CFrameless {
        id: frameless
        disabled: false

        Component.onCompleted: {
            window.titleBarItem = titleBar;
            if (window.showThemeToggle)
                frameless.setHitTestVisible(windowControls.themeBtn);
            if (window.showMinimize)
                frameless.setHitTestVisible(windowControls.minimizeBtn);
            if (window.showMaximize)
                frameless.setHitTestVisible(windowControls.maximizeBtn);
            if (window.showClose)
                frameless.setHitTestVisible(windowControls.closeBtn);
        }
        Component.onDestruction: frameless.onDestruction()
    }

    onVisibleChanged: {
        if (visible && frameless) {
            frameless.refreshShadow();
        }
    }

    Item {
        anchors.fill: parent

        Rectangle {
            id: contentWrapper
            anchors.fill: parent
            radius: window.visibility === Window.Maximized ? 0 : AppStyle.windowRadius
            color: AppStyle.backgroundColor

            Behavior on color {
                ColorAnimation {
                    duration: AppStyle.durationNormal
                    easing.type: Easing.OutCubic
                }
            }

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

        Item {
            id: titleBar
            visible: window.showTitleBar
            width: parent.width
            height: window.titleBarHeight
            z: 10

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

            Loader {
                id: titleBarContentLoader
                anchors.left: window.showTitle && window.title !== "" ? titleText.right : parent.left
                anchors.leftMargin: window.showTitle && window.title !== "" ? AppStyle.spacing3 : AppStyle.spacing4
                anchors.right: windowControls.left
                anchors.rightMargin: AppStyle.spacing2
                anchors.verticalCenter: parent.verticalCenter
            }

            CWindowControls {
                id: windowControls
                targetWindow: window
                showThemeToggle: window.showThemeToggle
                showMinimize: window.showMinimize
                showMaximize: window.showMaximize
                showClose: window.showClose
                anchors.right: parent.right
                anchors.rightMargin: AppStyle.spacing2
                anchors.verticalCenter: parent.verticalCenter
                onThemeToggled: AppStyle.toggleTheme()
            }
        }

        Item {
            id: contentArea
            anchors.fill: parent
            anchors.topMargin: window.showTitleBar ? window.titleBarHeight : 0
        }

        Item {
            id: overlayArea
            anchors.fill: parent
            z: 100
        }
    }
}
