pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

/*
    CDialog - 对话框组件

    == 组件库特有属性 ==
    size                : 尺寸，可选 "xs" | "sm" | "md" | "lg" | "xl" | "full"，默认 "md"
    icon                : 图标名称，默认 ""
    title               : 标题文本，默认 ""
    description         : 描述文本，默认 ""
    showCloseButton     : 是否显示关闭按钮，默认 true
    closeOnOverlayClick : 是否点击遮罩关闭，默认 true
    closeOnEsc          : 是否按 ESC 关闭，默认 true
    footer              : 底部按钮区（Component 类型）

    == 信号 ==
    dialogOpened : 对话框打开时触发
    dialogClosed : 对话框关闭时触发
*/
Popup {
    id: root

    // 尺寸: xs, sm, md, lg, xl, full
    property string size: "md"

    // 图标
    property string icon: ""

    // 标题
    property string title: ""

    // 描述
    property string description: ""

    // 是否显示关闭按钮
    property bool showCloseButton: true

    // 是否点击遮罩关闭
    property bool closeOnOverlayClick: true

    // 是否按 ESC 关闭
    property bool closeOnEsc: true

    // 内容
    default property alias content: contentContainer.data

    // 底部按钮区
    property alias footer: footerLoader.sourceComponent

    // 信号
    signal dialogOpened
    signal dialogClosed

    property int dialogWidth: size === "full" ? (parent ? parent.width - 32 : 800) : AppStyle.getDialogWidth(size)

    anchors.centerIn: parent

    onOpened: dialogOpened()
    onClosed: dialogClosed()
    width: dialogWidth
    height: Math.min(mainColumn.implicitHeight, parent ? parent.height - 64 : 600)

    modal: true
    closePolicy: (closeOnOverlayClick ? Popup.CloseOnPressOutside : Popup.NoAutoClose) | (closeOnEsc ? Popup.CloseOnEscape : Popup.NoAutoClose)

    // 进入/退出动画
    enter: Transition {
        NumberAnimation {
            property: "opacity"
            from: 0
            to: 1
            duration: AppStyle.durationNormal
            easing.type: Easing.OutCubic
        }
        NumberAnimation {
            property: "scale"
            from: 0.95
            to: 1
            duration: AppStyle.durationNormal
            easing.type: Easing.OutCubic
        }
    }

    exit: Transition {
        NumberAnimation {
            property: "opacity"
            from: 1
            to: 0
            duration: AppStyle.durationFast
            easing.type: Easing.OutCubic
        }
        NumberAnimation {
            property: "scale"
            from: 1
            to: 0.95
            duration: AppStyle.durationFast
            easing.type: Easing.OutCubic
        }
    }

    // 遮罩层
    Overlay.modal: Rectangle {
        color: AppStyle.overlayColor
        radius: AppStyle.windowRadius

        Behavior on opacity {
            NumberAnimation {
                duration: AppStyle.durationNormal
                easing.type: Easing.OutCubic
            }
        }
    }

    background: Rectangle {
        color: AppStyle.surfaceColor
        radius: AppStyle.radiusLg

        Behavior on color {
            ColorAnimation {
                duration: AppStyle.durationNormal
                easing.type: Easing.OutCubic
            }
        }
    }

    contentItem: Column {
        id: mainColumn
        spacing: 0

        // 头部（标题 + 关闭按钮）
        Item {
            width: parent.width
            height: visible ? AppStyle.spacing12 : 0
            visible: root.title !== "" || root.showCloseButton

            Row {
                spacing: AppStyle.spacing2
                anchors.left: parent.left
                anchors.leftMargin: AppStyle.spacing6
                anchors.bottom: parent.bottom
                anchors.bottomMargin: AppStyle.spacing2

                CIcon {
                    visible: root.icon !== ""
                    name: root.icon
                    size: 20
                    iconColor: AppStyle.textColor
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    text: root.title
                    font.pixelSize: AppStyle.fontSizeLg
                    font.weight: Font.Bold
                    color: AppStyle.textColor
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            // 关闭按钮
            CIcon {
                id: dialogCloseIcon
                visible: root.showCloseButton
                name: "x"
                size: 18
                iconColor: AppStyle.textMuted
                anchors.right: parent.right
                anchors.rightMargin: AppStyle.spacing4
                anchors.top: parent.top
                anchors.topMargin: AppStyle.spacing4

                MouseArea {
                    anchors.fill: parent
                    anchors.margins: -8
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true
                    onClicked: root.close()
                    onContainsMouseChanged: dialogCloseIcon.iconColor = containsMouse ? AppStyle.textColor : AppStyle.textMuted
                }
            }
        }

        // 描述文本
        Text {
            visible: root.description !== ""
            text: root.description
            font.pixelSize: AppStyle.fontSizeMd
            color: AppStyle.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
            leftPadding: AppStyle.spacing6
            rightPadding: AppStyle.spacing6
            bottomPadding: AppStyle.spacing4
        }

        // 内容区
        Item {
            id: contentContainer
            width: parent.width
            implicitHeight: childrenRect.height + (children.length > 0 ? AppStyle.spacing4 : 0)
            clip: true

            readonly property int contentPadding: AppStyle.spacing6

            readonly property int targetWidth: contentContainer.width - contentContainer.contentPadding * 2

            // 防抖定时器，避免频繁调用updateChildrenWidth
            Timer {
                id: updateTimer
                interval: 16
                repeat: false
                onTriggered: {
                    AppStyle.updateChildrenWidth(contentContainer, contentContainer.targetWidth);
                    for (let i = 0; i < contentContainer.children.length; i++) {
                        let child = contentContainer.children[i];
                        if (child && child.implicitWidth !== undefined) {
                            child.x = contentContainer.contentPadding;
                        }
                    }
                }
            }

            Component.onCompleted: updateTimer.start()
            onChildrenChanged: updateTimer.restart()
            onWidthChanged: updateTimer.restart()
        }

        // 底部按钮区
        Item {
            width: parent.width
            height: footerLoader.visible ? footerLoader.height + AppStyle.spacing6 * 2 : 0
            visible: footerLoader.sourceComponent !== null

            Loader {
                id: footerLoader
                anchors.right: parent.right
                anchors.rightMargin: AppStyle.spacing6
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
