pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

/*
    CButton - 按钮组件

    == 组件库特有属性 ==
    variant     : 变体，可选 "solid" | "outline" | "ghost" | "link"，默认 "solid"
    colorScheme : 颜色方案，默认 "primary"
    size        : 尺寸，可选 "sm" | "md" | "lg"，默认 "md"
    fullWidth   : 是否全宽，默认 false
    leftIcon    : 左侧图标名称，默认 ""
    rightIcon   : 右侧图标名称，默认 ""
    iconOnly    : 仅图标按钮（无文字，正方形），默认 false
    isLoading   : 加载状态，显示 spinner，默认 false
*/
Button {
    id: root

    // 点击时获取焦点，让其他输入框失去焦点
    focusPolicy: Qt.ClickFocus

    // 变体: solid, outline, ghost, link
    property string variant: "solid"

    // 颜色方案: gray, red, green, blue, teal, pink, purple, cyan, orange, yellow, primary, secondary, success, warning, error
    property string colorScheme: "primary"

    // 尺寸: sm, md, lg
    property string size: "md"

    // 是否全宽
    property bool fullWidth: false

    // 左右图标
    property string leftIcon: ""
    property string rightIcon: ""

    // 仅图标按钮 (无文字，正方形)
    property bool iconOnly: false

    // 加载状态
    property bool isLoading: false

    enabled: !isLoading

    // 根据 colorScheme 获取颜色 (使用 AppStyle 辅助函数)
    property color schemeColor: AppStyle.getSchemeColor(colorScheme)
    property color schemeHover: AppStyle.getSchemeHover(colorScheme)
    property color schemeLight: AppStyle.getSchemeLight(colorScheme)

    // 尺寸配置 (使用 AppStyle 辅助函数)
    property int buttonHeight: AppStyle.getButtonHeight(size)
    property int fontSize: AppStyle.getFontSize(size === "lg" ? "md" : "sm")

    property int hPad: AppStyle.getCardPadding(size)

    implicitWidth: fullWidth ? parent.width : (iconOnly ? buttonHeight : contentItem.implicitWidth + hPad * 2)
    implicitHeight: buttonHeight

    // 预计算颜色状态以优化性能
    readonly property color solidBgColor: root.enabled ? root.schemeColor : (AppStyle.isDark ? Qt.rgba(255, 255, 255, 0.12) : Qt.rgba(0, 0, 0, 0.12))
    readonly property color solidBgHoverColor: root.enabled ? root.schemeHover : solidBgColor
    readonly property color outlineBgHoverColor: AppStyle.isDark ? Qt.rgba(255, 255, 255, 0.08) : Qt.rgba(0, 0, 0, 0.04)
    readonly property color ghostBgHoverColor: Qt.rgba(root.schemeColor.r, root.schemeColor.g, root.schemeColor.b, 0.1)

    // 文字颜色
    readonly property color textColor: {
        if (!root.enabled)
            return AppStyle.textSecondary;
        if (root.variant === "solid")
            return AppStyle.textLight;
        if (root.variant === "outline")
            return AppStyle.textColor;
        if (root.variant === "link" || root.variant === "ghost")
            return root.schemeColor;
        return AppStyle.textColor;
    }

    contentItem: Item {
        implicitWidth: contentRow.implicitWidth
        implicitHeight: contentRow.implicitHeight

        Row {
            id: contentRow
            spacing: AppStyle.spacing2
            anchors.centerIn: parent

            // 加载指示器
            CSpinner {
                visible: root.isLoading
                size: "sm"
                color: root.variant === "solid" ? AppStyle.textLight : root.schemeColor
                anchors.verticalCenter: parent.verticalCenter
            }

            // 左侧图标
            CIcon {
                visible: root.leftIcon !== "" && !root.isLoading
                name: root.leftIcon
                size: root.fontSize
                iconColor: root.textColor
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                visible: root.text !== ""
                text: root.text
                font.pixelSize: root.fontSize
                font.weight: Font.Medium
                color: root.textColor
                opacity: root.isLoading ? 0.7 : 1
                anchors.verticalCenter: parent.verticalCenter
            }

            // 右侧图标
            CIcon {
                visible: root.rightIcon !== ""
                name: root.rightIcon
                size: root.fontSize
                iconColor: root.textColor
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    background: Rectangle {
        id: bgOuter
        radius: AppStyle.radiusSm
        antialiasing: true

        color: {
            if (!root.enabled) {
                return root.variant === "solid" ? root.solidBgColor : "transparent";
            }
            if (root.variant === "solid") {
                return root.hovered ? root.solidBgHoverColor : root.solidBgColor;
            }
            if (root.variant === "outline") {
                return root.hovered ? root.outlineBgHoverColor : "transparent";
            }
            if (root.variant === "ghost" || root.variant === "link") {
                return root.hovered ? root.ghostBgHoverColor : "transparent";
            }
            return "transparent";
        }

        Behavior on color {
            ColorAnimation {
                duration: AppStyle.durationNormal
                easing.type: Easing.OutCubic
            }
        }

        border.width: root.variant === "outline" ? 1 : 0
        border.color: root.enabled ? AppStyle.borderColor : (AppStyle.isDark ? Qt.rgba(255, 255, 255, 0.1) : Qt.rgba(0, 0, 0, 0.1))
    }

    // 统一的状态转换动画
    states: [
        State {
            name: "pressed"
            when: root.pressed
            PropertyChanges {
                root.scale: 0.96
            }
        },
        State {
            name: "normal"
            when: !root.pressed
            PropertyChanges {
                root.scale: 1
            }
        }
    ]

    transitions: Transition {
        PropertyAnimation {
            properties: "scale"
            duration: root.pressed ? 50 : 120
            easing.type: root.pressed ? Easing.OutCubic : Easing.OutBack
            easing.overshoot: root.pressed ? 1.0 : 1.2
        }
        ColorAnimation {
            properties: "color"
            duration: AppStyle.durationFast
        }
    }

    transformOrigin: Item.Center
}
