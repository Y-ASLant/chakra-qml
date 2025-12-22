pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects

/*
    CCard - 卡片组件

    == 组件库特有属性 ==
    title       : 卡片标题，默认 ""
    description : 卡片描述，默认 ""
    variant     : 变体，可选 "elevated" | "outline" | "filled" | "subtle"，默认 "elevated"
    size        : 尺寸，可选 "sm" | "md" | "lg"，默认 "md"
    header      : 头部自定义内容（Component 类型）
    footer      : 底部自定义内容（Component 类型）
    autoPadding : 是否自动内边距，默认 true
    padding     : 内边距大小，默认 16
    spacing     : 内容间距，默认 16
*/
Rectangle {
    id: root

    // 变体: elevated, outline, filled, subtle
    property string variant: "elevated"

    // 尺寸: sm, md, lg
    property string size: "md"

    // 标题和描述
    property string title: ""
    property string description: ""

    // Header, Body, Footer 内容
    property alias header: headerLoader.sourceComponent
    property alias footer: footerLoader.sourceComponent
    default property alias body: bodyContainer.data

    // 内边距控制
    property bool autoPadding: true
    property int padding: cardPadding

    // 内容间距控制
    property alias spacing: bodyContainer.spacing

    // hover 状态 (使用延迟取消避免闪烁)
    property bool hovered: internal.isHovered

    QtObject {
        id: internal
        property bool isHovered: false
    }

    Timer {
        id: hoverEnterTimer
        interval: AppStyle.durationInstant
        onTriggered: internal.isHovered = true
    }

    Timer {
        id: hoverExitTimer
        interval: AppStyle.durationFast
        onTriggered: internal.isHovered = false
    }

    Connections {
        target: hoverArea
        function onContainsMouseChanged() {
            if (hoverArea.containsMouse) {
                hoverExitTimer.stop();
                hoverEnterTimer.restart();
            } else {
                hoverEnterTimer.stop();
                hoverExitTimer.restart();
            }
        }
    }

    // 尺寸配置
    property int cardPadding: AppStyle.getCardPadding(size)
    property int titleSize: AppStyle.getFontSize(size === "sm" ? "md" : (size === "lg" ? "xl" : "lg"))
    property int descriptionSize: AppStyle.getFontSize(size === "sm" ? "xs" : (size === "lg" ? "md" : "sm"))
    property int contentSpacing: size === "lg" ? AppStyle.spacing2 : AppStyle.spacing1

    color: {
        switch (variant) {
        case "filled":
            return AppStyle.backgroundColor;
        case "subtle":
            return AppStyle.isDark ? Qt.rgba(255, 255, 255, 0.02) : Qt.rgba(0, 0, 0, 0.02);
        default:
            return AppStyle.surfaceColor;
        }
    }
    radius: AppStyle.radiusLg
    border.width: 1
    border.color: root.hovered ? AppStyle.borderFocus : AppStyle.borderColor

    Behavior on color {
        ColorAnimation {
            duration: AppStyle.durationNormal
            easing.type: Easing.OutCubic
        }
    }

    Behavior on border.color {
        ColorAnimation {
            duration: AppStyle.durationFast
            easing.type: Easing.OutCubic
        }
    }

    implicitWidth: 320
    implicitHeight: mainColumn.implicitHeight

    // 阴影效果
    layer.enabled: root.variant === "elevated"
    layer.effect: MultiEffect {
        shadowEnabled: true
        shadowColor: root.hovered ? "#30000000" : "#20000000"
        shadowBlur: root.hovered ? 0.6 : 0.5
        shadowVerticalOffset: root.hovered ? 6 : 4
    }

    // Hover 检测
    MouseArea {
        id: hoverArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton
    }

    Column {
        id: mainColumn
        width: parent.width

        // Header
        Loader {
            id: headerLoader
            width: parent.width
            active: sourceComponent !== null
            visible: active
        }

        // 内置标题区域 (当使用 title/description 属性时)
        Column {
            visible: root.title !== "" || root.description !== ""
            width: parent.width
            padding: root.cardPadding
            spacing: root.contentSpacing

            Text {
                visible: root.title !== ""
                text: root.title
                font.pixelSize: root.titleSize
                font.weight: Font.DemiBold
                color: AppStyle.textColor
                width: parent.width - root.cardPadding * 2
                wrapMode: Text.WordWrap
            }

            Text {
                visible: root.description !== ""
                text: root.description
                font.pixelSize: root.descriptionSize
                color: AppStyle.textSecondary
                width: parent.width - root.cardPadding * 2
                wrapMode: Text.WordWrap
            }
        }

        // Body
        Column {
            id: bodyContainer
            width: parent.width
            leftPadding: root.autoPadding ? root.padding : 0
            rightPadding: root.autoPadding ? root.padding : 0
            bottomPadding: root.autoPadding ? root.padding : 0
            topPadding: (root.title === "" && root.description === "" && !headerLoader.active && root.autoPadding) ? root.padding : 0

            // 内容可用宽度
            readonly property int contentWidth: width - leftPadding - rightPadding

            // 自动设置子元素宽度
            Component.onCompleted: AppStyle.updateChildrenWidth(bodyContainer, bodyContainer.contentWidth)
            onChildrenChanged: AppStyle.updateChildrenWidth(bodyContainer, bodyContainer.contentWidth)
            onContentWidthChanged: AppStyle.updateChildrenWidth(bodyContainer, bodyContainer.contentWidth)
        }

        // Footer
        Loader {
            id: footerLoader
            width: parent.width
            active: sourceComponent !== null
            visible: active
        }
    }
}
