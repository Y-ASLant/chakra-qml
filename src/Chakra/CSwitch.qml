pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

/*
    CSwitch - 开关组件

    == 组件库特有属性 ==
    colorScheme   : 颜色方案，默认 "primary"
    size          : 尺寸，可选 "sm" | "md" | "lg"，默认 "md"
    isDisabled    : 是否禁用，默认 false
    trackLabelOn  : 开启时轨道上显示的文字，默认 ""
    trackLabelOff : 关闭时轨道上显示的文字，默认 ""
    thumbIconOn   : 开启时滑块上的图标，默认 ""
    thumbIconOff  : 关闭时滑块上的图标，默认 ""
*/
Switch {
    id: root

    // 颜色方案
    property string colorScheme: "primary"

    // 尺寸: sm, md, lg
    property string size: "md"

    // Track Indicator - 轨道上的指示器
    property string trackLabelOn: ""
    property string trackLabelOff: ""

    // Thumb Indicator - 滑块上的图标
    property string thumbIconOn: ""
    property string thumbIconOff: ""

    property color schemeColor: AppStyle.getSchemeColor(colorScheme)

    // 当有 Track Indicator 时需要更宽的轨道
    property bool hasTrackLabel: trackLabelOn !== "" || trackLabelOff !== ""

    property int trackWidth: hasTrackLabel ? AppStyle.getSwitchTrackWidth(size) + 10 : AppStyle.getSwitchTrackWidth(size)
    property int trackHeight: AppStyle.getSwitchTrackHeight(size)

    property int thumbSize: trackHeight - 4

    indicator: Rectangle {
        implicitWidth: root.trackWidth
        implicitHeight: root.trackHeight
        x: root.leftPadding
        y: parent.height / 2 - height / 2
        radius: root.trackHeight / 2

        color: root.checked ? root.schemeColor : AppStyle.borderColor

        Behavior on color {
            ColorAnimation {
                duration: AppStyle.durationNormal
                easing.type: Easing.OutCubic
            }
        }

        // Track Indicator (on) - 显示在滑块左侧
        Text {
            visible: root.trackLabelOn !== ""
            text: root.trackLabelOn
            font.pixelSize: root.size === "sm" ? 8 : (root.size === "lg" ? 11 : 9)
            font.weight: Font.Bold
            color: AppStyle.textLight
            anchors.left: parent.left
            anchors.leftMargin: 8
            anchors.verticalCenter: parent.verticalCenter

            opacity: root.checked ? 1 : 0
            Behavior on opacity {
                NumberAnimation {
                    duration: AppStyle.durationFast
                    easing.type: Easing.OutCubic
                }
            }
        }

        // Track Indicator (off) - 显示在滑块右侧
        Text {
            visible: root.trackLabelOff !== ""
            text: root.trackLabelOff
            font.pixelSize: root.size === "sm" ? 8 : (root.size === "lg" ? 11 : 9)
            font.weight: Font.Bold
            color: AppStyle.textMuted
            anchors.right: parent.right
            anchors.rightMargin: 8
            anchors.verticalCenter: parent.verticalCenter

            opacity: root.checked ? 0 : 1
            Behavior on opacity {
                NumberAnimation {
                    duration: AppStyle.durationFast
                    easing.type: Easing.OutCubic
                }
            }
        }

        Rectangle {
            id: thumb
            width: root.thumbSize
            height: root.thumbSize
            radius: root.thumbSize / 2
            color: AppStyle.surfaceColor

            x: root.checked ? parent.width - width - 2 : 2
            anchors.verticalCenter: parent.verticalCenter

            // 按下时缩放
            scale: root.pressed ? 0.9 : (root.hovered ? 1.1 : 1)

            Behavior on x {
                NumberAnimation {
                    duration: AppStyle.durationNormal
                    easing.type: Easing.OutBack
                    easing.overshoot: 1.5
                }
            }

            Behavior on scale {
                NumberAnimation {
                    duration: AppStyle.durationFast
                    easing.type: Easing.OutCubic
                }
            }

            // Thumb Indicator Icon
            CIcon {
                anchors.centerIn: parent
                visible: (root.thumbIconOn !== "" && root.checked) || (root.thumbIconOff !== "" && !root.checked)
                name: root.checked ? root.thumbIconOn : root.thumbIconOff
                size: root.thumbSize * 0.6
                iconColor: root.checked ? root.schemeColor : AppStyle.textMuted
            }
        }
    }

    contentItem: Text {
        text: root.text
        font.pixelSize: AppStyle.fontSizeMd
        color: AppStyle.textColor
        verticalAlignment: Text.AlignVCenter
        leftPadding: root.indicator.width + root.spacing
    }
}
