pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

/*
    CDrawer - 抽屉组件

    == 组件库特有属性 ==
    placement           : 方向，可选 "left" | "right" | "top" | "bottom"，默认 "right"
    size                : 抽屉宽度/高度，默认 320
    edgeMargin          : 边距偏移（用于无边框窗口），默认 0
    title               : 标题文本，默认 ""
    showCloseButton     : 是否显示关闭按钮，默认 true
    closeOnOverlayClick : 是否点击遮罩关闭，默认 true
    closeOnEsc          : 是否按 ESC 关闭，默认 true
    footer              : 底部内容（Component 类型）

    == 信号 ==
    drawerOpened : 抽屉打开时触发
    drawerClosed : 抽屉关闭时触发
*/
CPopupBase {
    id: root

    // 方向: left, right, top, bottom
    property string placement: "right"

    // 尺寸
    property int size: 320

    // 边距偏移（用于无边框窗口）
    property int edgeMargin: 0

    // 内容
    default property alias content: contentContainer.data

    // 底部
    property alias footer: footerLoader.sourceComponent

    // 信号
    signal drawerOpened
    signal drawerClosed

    onOpened: drawerOpened()
    onClosed: drawerClosed()

    // 位置和尺寸
    readonly property bool isHorizontal: placement === "left" || placement === "right"
    readonly property bool isVertical: placement === "top" || placement === "bottom"

    readonly property int targetX: {
        if (placement === "left") return edgeMargin;
        if (placement === "right") return parent ? parent.width - width - edgeMargin : 0;
        return edgeMargin;
    }

    readonly property int targetY: {
        if (placement === "top") return edgeMargin;
        if (placement === "bottom") return parent ? parent.height - height - edgeMargin : 0;
        return edgeMargin;
    }

    readonly property int hidePosition: {
        if (placement === "left") return -width;
        if (placement === "right") return parent ? parent.width : width;
        if (placement === "top") return -height;
        return parent ? parent.height : height;
    }

    x: targetX
    y: targetY
    width: isHorizontal ? size : (parent ? parent.width - edgeMargin * 2 : 400)
    height: isVertical ? size : (parent ? parent.height - edgeMargin * 2 : 600)

    __popupRadius: edgeMargin > 0 ? AppStyle.radiusLg : 0

    // 进入动画
    enter: Transition {
        NumberAnimation {
            property: root.isHorizontal ? "x" : "y"
            from: root.hidePosition
            to: root.isHorizontal ? root.targetX : root.targetY
            duration: AppStyle.durationSlow
            easing.type: Easing.OutCubic
        }
    }

    // 退出动画
    exit: Transition {
        NumberAnimation {
            property: root.isHorizontal ? "x" : "y"
            to: root.hidePosition
            duration: AppStyle.durationNormal
            easing.type: Easing.InCubic
        }
    }

    contentItem: Item {
        // Header
        Item {
            id: header
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: visible ? AppStyle.spacing12 : 0
            visible: root.title !== "" || root.showCloseButton
            z: 2

            Text {
                text: root.title
                font.pixelSize: AppStyle.fontSizeLg
                font.weight: Font.Bold
                color: AppStyle.textColor
                anchors.left: parent.left
                anchors.leftMargin: AppStyle.spacing6
                anchors.verticalCenter: parent.verticalCenter
            }

            CPopupCloseButton {
                visible: root.showCloseButton
                anchors.right: parent.right
                anchors.rightMargin: AppStyle.spacing4
                anchors.verticalCenter: parent.verticalCenter
                popup: root
            }
        }

        CPopupDivider {
            id: headerBorder
            anchors.top: header.bottom
            width: parent.width
            visible: root.title !== ""
            z: 2
        }

        // Body
        Flickable {
            id: bodyScroll
            anchors.top: headerBorder.bottom
            anchors.topMargin: AppStyle.spacing4
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: footerBorder.top
            contentWidth: width
            contentHeight: contentContainer.height
            boundsBehavior: Flickable.StopAtBounds
            clip: true
            z: 1

            ScrollBar.vertical: CScrollBar {}

            Item {
                id: contentContainer
                width: bodyScroll.width
                height: childrenRect.height

                CContentWidthUpdater {
                    target: contentContainer
                    contentPadding: AppStyle.spacing4
                }

                function scheduleWidthUpdate() {
                    children[0].scheduleUpdate();
                }

                onChildrenChanged: scheduleWidthUpdate()
                onWidthChanged: scheduleWidthUpdate()
            }
        }

        CPopupDivider {
            id: footerBorder
            anchors.bottom: footerLoader.top
            width: parent.width
            visible: footerLoader.visible
            z: 2
        }

        // Footer
        Loader {
            id: footerLoader
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            visible: sourceComponent !== null
            z: 2
        }
    }
}
