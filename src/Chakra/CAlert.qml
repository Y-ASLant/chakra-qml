pragma ComponentBehavior: Bound

import QtQuick

/*
    CAlert - 警告提示组件

    == 组件库特有属性 ==
    status      : 状态，可选 "info" | "success" | "warning" | "error"，默认 "info"
    variant     : 变体，可选 "subtle" | "solid" | "left-accent" | "top-accent"，默认 "subtle"
    title       : 标题文本，默认 ""
    description : 描述文本，默认 ""
    isClosable  : 是否可关闭，默认 false

    == 信号 ==
    closed : 关闭时触发
*/
Rectangle {
    id: root

    // 状态: info, success, warning, error
    property string status: "info"

    // 变体: subtle, solid, left-accent, top-accent
    property string variant: "subtle"

    // 标题和描述
    property string title: ""
    property string description: ""

    // 是否可关闭
    property bool isClosable: false

    // 关闭信号
    signal closed

    readonly property color statusColor: {
        switch (status) {
        case "success":
            return AppStyle.successColor;
        case "warning":
            return AppStyle.warningColor;
        case "error":
            return AppStyle.errorColor;
        default:
            return AppStyle.infoColor;
        }
    }

    readonly property color statusBgColor: {
        switch (status) {
        case "success":
            return AppStyle.successLight;
        case "warning":
            return AppStyle.warningLight;
        case "error":
            return AppStyle.errorLight;
        default:
            return AppStyle.infoLight;
        }
    }

    readonly property string statusIcon: {
        switch (status) {
        case "success":
            return "check-circle";
        case "warning":
            return "warning";
        case "error":
            return "warning-circle";
        default:
            return "info";
        }
    }

    implicitWidth: parent ? parent.width : 400
    implicitHeight: contentRow.height + AppStyle.spacing4 * 2

    radius: AppStyle.radiusLg

    color: {
        if (variant === "solid")
            return root.statusColor;
        return root.statusBgColor;
    }

    Behavior on color {
        ColorAnimation {
            duration: AppStyle.durationNormal
            easing.type: Easing.OutCubic
        }
    }

    // 左侧强调条
    Rectangle {
        visible: root.variant === "left-accent"
        width: 4
        height: parent.height
        color: root.statusColor
        anchors.left: parent.left
        radius: AppStyle.radiusLg
    }

    // 顶部强调条
    Rectangle {
        visible: root.variant === "top-accent"
        width: parent.width
        height: 4
        color: root.statusColor
        anchors.top: parent.top
        radius: AppStyle.radiusLg
    }

    Row {
        id: contentRow
        anchors.left: parent.left
        anchors.right: root.isClosable ? closeIcon.left : parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: root.variant === "left-accent" ? AppStyle.spacing4 + 4 : AppStyle.spacing4
        anchors.rightMargin: AppStyle.spacing3
        spacing: AppStyle.spacing3

        // 图标
        CIcon {
            name: root.statusIcon
            size: 20
            iconColor: root.variant === "solid" ? AppStyle.textLight : root.statusColor
            anchors.verticalCenter: parent.verticalCenter
        }

        // 内容
        Column {
            spacing: AppStyle.spacing1
            width: parent.width - 20 - AppStyle.spacing3
            anchors.verticalCenter: parent.verticalCenter

            Text {
                visible: root.title !== ""
                text: root.title
                font.pixelSize: AppStyle.fontSizeMd
                font.weight: Font.Medium
                color: root.variant === "solid" ? AppStyle.textLight : AppStyle.textColor
                wrapMode: Text.WordWrap
                width: parent.width
            }

            Text {
                visible: root.description !== ""
                text: root.description
                font.pixelSize: AppStyle.fontSizeSm
                color: root.variant === "solid" ? AppStyle.textLight : AppStyle.textSecondary
                wrapMode: Text.WordWrap
                width: parent.width
            }
        }
    }

    // 关闭按钮
    CIcon {
        id: closeIcon
        visible: root.isClosable
        name: "x"
        size: 18
        iconColor: root.variant === "solid" ? AppStyle.textLight : root.statusColor
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: AppStyle.spacing4

        MouseArea {
            anchors.fill: parent
            anchors.margins: -8
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onClicked: {
                root.visible = false;
                root.closed();
            }
            onContainsMouseChanged: {
                closeIcon.opacity = containsMouse ? 0.7 : 1;
            }
        }
    }
}
