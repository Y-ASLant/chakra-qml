import QtQuick
import QtQuick.Controls

/*
    CMenuItem - 菜单项组件

    == 组件库特有属性 ==
    size         : 尺寸，可选 "sm" | "md" | "lg"，默认 "md"
    menuIcon     : 图标名称，默认 ""
    command      : 快捷键文本，默认 ""
    colorScheme  : 颜色方案（用于危险操作），可选 "red" | "danger"，默认 ""
    isDisabled   : 是否禁用，默认 false
    closeOnClick : 点击后是否关闭菜单，默认 true
    value        : 值（用于 Radio/Checkbox 菜单项）
*/
ItemDelegate {
    id: root

    // 尺寸: sm, md, lg
    property string size: "md"

    // 图标
    property string menuIcon: ""

    // 快捷键文本
    property string command: ""

    // 颜色方案 (用于危险操作等)
    property string colorScheme: ""

    // 是否禁用
    property bool isDisabled: false

    // 点击后是否关闭菜单
    property bool closeOnClick: true

    // 值 (用于 Radio/Checkbox 菜单项)
    property var value: null

    // 关闭菜单信号
    signal closeMenu

    enabled: !isDisabled

    onClicked: {
        if (closeOnClick && !isDisabled) {
            closeMenu();
        }
    }

    property int itemHeight: AppStyle.getMenuItemHeight(size)
    property int fontSize: AppStyle.getFontSize(size)

    property color itemColor: {
        if (root.colorScheme === "red" || root.colorScheme === "danger") {
            return AppStyle.redColor;
        }
        return AppStyle.textColor;
    }

    property color itemHoverBg: {
        if (root.colorScheme === "red" || root.colorScheme === "danger") {
            return Qt.rgba(AppStyle.redColor.r, AppStyle.redColor.g, AppStyle.redColor.b, 0.1);
        }
        return Qt.rgba(AppStyle.primaryColor.r, AppStyle.primaryColor.g, AppStyle.primaryColor.b, 0.08);
    }

    implicitWidth: parent ? parent.width : 180
    implicitHeight: itemHeight

    contentItem: Item {
        Row {
            anchors.left: parent.left
            anchors.leftMargin: AppStyle.spacing2
            anchors.verticalCenter: parent.verticalCenter
            spacing: AppStyle.spacing2

            // 图标
            CIcon {
                visible: root.menuIcon !== ""
                name: root.menuIcon
                size: root.fontSize
                iconColor: root.hovered ? root.itemColor : (root.isDisabled ? AppStyle.textMuted : root.itemColor)
                anchors.verticalCenter: parent.verticalCenter
                opacity: root.isDisabled ? 0.5 : 1
            }

            // 文本
            Text {
                text: root.text
                font.pixelSize: root.fontSize
                color: root.isDisabled ? AppStyle.textMuted : root.itemColor
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        // 快捷键
        Text {
            visible: root.command !== ""
            anchors.right: parent.right
            anchors.rightMargin: AppStyle.spacing2
            anchors.verticalCenter: parent.verticalCenter
            text: root.command
            font.pixelSize: AppStyle.fontSizeXs
            color: AppStyle.textMuted
        }
    }

    background: Rectangle {
        radius: AppStyle.radiusSm
        color: root.hovered && !root.isDisabled ? root.itemHoverBg : "transparent"

        Behavior on color {
            ColorAnimation {
                duration: AppStyle.durationFast
                easing.type: Easing.OutCubic
            }
        }
    }

    // 点击效果
    scale: pressed && !isDisabled ? 0.98 : 1
    Behavior on scale {
        NumberAnimation {
            duration: AppStyle.durationInstant
            easing.type: Easing.OutCubic
        }
    }
}
