pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import Chakra
import "sections"

CWindow {
    id: window
    visible: true
    width: 1200
    height: 800
    minimumWidth: 640
    minimumHeight: 480
    title: "Chakra UI 组件库演示"
    showMaximize: false

    titleBarContent: Component {
        Text {
            text: fpsCounter.fps.toFixed(1) + " FPS"
            font.pixelSize: AppStyle.fontSizeMd
            font.weight: Font.Medium
            color: {
                if (fpsCounter.fps >= 55)
                    return AppStyle.successColor;
                if (fpsCounter.fps >= 30)
                    return AppStyle.warningColor;
                return AppStyle.errorColor;
            }

            FrameAnimation {
                id: fpsCounter
                running: window.visible

                property real fps: 60
                property int frameCount: 0
                property real lastTime: 0

                onTriggered: {
                    frameCount++;
                    var currentTime = Date.now();

                    if (currentTime - lastTime >= 1000) {
                        fps = frameCount * 1000 / (currentTime - lastTime);
                        frameCount = 0;
                        lastTime = currentTime;
                    } else if (lastTime === 0) {
                        lastTime = currentTime;
                    }
                }
            }
        }
    }

    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth

        ScrollBar.vertical: CScrollBar {
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 2
            anchors.bottomMargin: 2
        }

        Column {
            width: parent.width
            spacing: AppStyle.spacing8
            topPadding: AppStyle.spacing4
            leftPadding: AppStyle.spacing6
            rightPadding: AppStyle.spacing6
            bottomPadding: AppStyle.spacing6

            // ========== 标题 ==========
            Text {
                text: "Chakra QML 组件库"
                font.pixelSize: AppStyle.fontSize4xl
                font.weight: Font.Bold
                color: AppStyle.textColor
            }

            Text {
                text: "这是一套受 Chakra UI 启发的 QML 组件库.\nBy ASLant."
                font.pixelSize: AppStyle.fontSizeLg
                color: AppStyle.textSecondary
            }

            // ========== 组件演示 ==========
            DemoButtons {}
            DemoInputs {}
            DemoSelectors {}
            DemoSegmentedControl {}
            DemoIcons {}
            DemoFeedback {}
            DemoBadgeTags {}
            DemoProgress {}
            DemoTooltip {}

            DemoMenu {}

            DemoCards {}

            DemoLayouts {}

            DemoPagination {}

            DemoScrollArea {}

            DemoOverlays {
                onOpenDialog: demoDialog.open()
                onOpenDrawer: demoDrawer.open()
                onOpenFramelessWindow: framelessWindow.show()
            }

            DemoActionBar {
                id: demoActionBarSection
            }

            Item {
                height: AppStyle.spacing6
            }
        }
    }

    // ActionBar 实例
    CActionBar {
        id: demoActionBar
        open: demoActionBarSection.check1.checked || demoActionBarSection.check2.checked || demoActionBarSection.check3.checked
        selectionCount: (demoActionBarSection.check1.checked ? 1 : 0) + (demoActionBarSection.check2.checked ? 1 : 0) + (demoActionBarSection.check3.checked ? 1 : 0)

        CButton {
            text: "删除"
            size: "sm"
            colorScheme: "error"
            variant: "ghost"
        }

        CButton {
            text: "移动"
            size: "sm"
            variant: "ghost"
        }

        CButton {
            text: "分享"
            size: "sm"
            variant: "ghost"
        }
    }

    // 无边框圆角窗口演示
    CWindow {
        id: framelessWindow
        width: 400
        height: 300
        title: "无边框圆角窗口"
        showTitle: true
        shadowEnabled: true

        Column {
            anchors.centerIn: parent
            spacing: AppStyle.spacing4

            Text {
                text: "这是一个无边框圆角窗口"
                font.pixelSize: AppStyle.fontSizeLg
                color: AppStyle.textColor
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "使用 CWindow 组件实现"
                font.pixelSize: AppStyle.fontSizeSm
                color: AppStyle.textSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            CButton {
                text: "关闭窗口"
                onClicked: framelessWindow.close()
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    // Dialog 和 Drawer（放在 overlay 层，覆盖整个窗口）
    overlay: [
        CDialog {
            id: demoDialog
            title: "Dialog Title"
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
            size: "md"

            footer: Component {
                Row {
                    spacing: AppStyle.spacing3

                    CButton {
                        width: 80
                        text: "Cancel"
                        variant: "outline"
                        onClicked: demoDialog.close()
                    }

                    CButton {
                        width: 80
                        text: "Save"
                        onClicked: demoDialog.close()
                    }
                }
            }
        },
        CDrawer {
            id: demoDrawer
            title: "Drawer 标题"
            placement: "right"
            edgeMargin: 6

            Column {
                spacing: AppStyle.spacing4

                Text {
                    width: parent.width
                    text: "这是一个 Drawer 侧边栏。"
                    font.pixelSize: AppStyle.fontSizeMd
                    color: AppStyle.textColor
                    wrapMode: Text.WordWrap
                }

                CInput {
                    width: parent.width
                    placeholderText: "输入内容..."
                }

                CCheckbox {
                    width: parent.width
                    text: "记住我的选择"
                }

                CButton {
                    width: parent.width
                    text: "提交"
                }
            }
        }
    ]
}
