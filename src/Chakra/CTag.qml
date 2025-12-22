pragma ComponentBehavior: Bound

import QtQuick

/*
    CTag - 标签组件

    == 组件库特有属性 ==
    colorScheme : 颜色方案，默认 "gray"
    variant     : 变体，可选 "solid" | "subtle" | "outline"，默认 "subtle"
    size        : 尺寸，可选 "sm" | "md" | "lg"，默认 "md"
    text        : 标签文本，默认 ""
    isClosable  : 是否可关闭，默认 false

    == 信号 ==
    closed      : 关闭时触发
*/
Rectangle {
    id: root

    // 颜色方案
    property string colorScheme: "primary"

    // 变体: solid, subtle, outline
    property string variant: "subtle"

    // 尺寸: sm, md, lg
    property string size: "md"

    // 文本
    property string text: ""

    // 是否可关闭
    property bool isClosable: false

    // 关闭信号
    signal closed

    property color schemeColor: colorScheme === "gray" ? AppStyle.textSecondary : AppStyle.getSchemeColor(colorScheme)

    property int tagHeight: AppStyle.getTagHeight(size)
    property int fontSize: AppStyle.getBadgeFontSize(size)

    implicitWidth: contentRow.width + AppStyle.spacing2 * 2
    implicitHeight: tagHeight

    radius: AppStyle.radiusFull

    color: {
        if (variant === "solid")
            return root.schemeColor;
        if (variant === "subtle")
            return Qt.rgba(schemeColor.r, schemeColor.g, schemeColor.b, 0.15);
        return "transparent";
    }

    border.width: variant === "outline" ? 1 : 0
    border.color: root.schemeColor

    Row {
        id: contentRow
        anchors.centerIn: parent
        spacing: AppStyle.spacing1

        Text {
            text: root.text
            font.pixelSize: root.fontSize
            font.weight: Font.Medium
            color: root.variant === "solid" ? AppStyle.textLight : root.schemeColor
            anchors.verticalCenter: parent.verticalCenter
        }

        // 关闭按钮
        CIcon {
            id: closeBtn
            visible: root.isClosable
            name: "x"
            size: root.fontSize - 2
            iconColor: root.variant === "solid" ? AppStyle.textLight : root.schemeColor
            opacity: closeArea.containsMouse ? 1 : 0.6
            scale: closeArea.pressed ? 0.8 : (closeArea.containsMouse ? 1.1 : 1)
            anchors.verticalCenter: parent.verticalCenter

            Behavior on scale {
                NumberAnimation {
                    duration: AppStyle.durationXFast
                    easing.type: Easing.OutCubic
                }
            }

            Behavior on opacity {
                NumberAnimation {
                    duration: AppStyle.durationXFast
                    easing.type: Easing.OutCubic
                }
            }

            MouseArea {
                id: closeArea
                anchors.fill: parent
                anchors.margins: -4
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: root.closed()
            }
        }
    }
}
