pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

/*
    CCheckbox - 复选框组件

    == 组件库特有属性 ==
    colorScheme     : 颜色方案，默认 "primary"
    size            : 尺寸，可选 "sm" | "md" | "lg"，默认 "md"
    isIndeterminate : 是否半选状态（部分选中），默认 false
    isInvalid       : 是否无效状态，默认 false
*/
CheckBox {
    id: root

    property string colorScheme: "primary"

    // 尺寸: sm, md, lg
    property string size: "md"

    // 是否无效
    property bool isInvalid: false

    // 不确定状态 (部分选中)
    property bool isIndeterminate: false

    property color schemeColor: AppStyle.getSchemeColor(colorScheme)

    property int boxSize: AppStyle.getBoxSize(size)
    property int fontSize: AppStyle.getFontSize(size)

    indicator: Rectangle {
        implicitWidth: root.boxSize
        implicitHeight: root.boxSize
        x: root.leftPadding
        y: parent.height / 2 - height / 2
        radius: AppStyle.radiusSm

        // 点击缩放
        scale: root.pressed ? 0.85 : 1
        Behavior on scale {
            NumberAnimation {
                duration: root.pressed ? 50 : 120
                easing.type: root.pressed ? Easing.OutCubic : Easing.OutBack
                easing.overshoot: 1.3
            }
        }

        color: (root.checked || root.isIndeterminate) ? root.schemeColor : "transparent"
        border.width: (root.checked || root.isIndeterminate) ? 0 : 2
        border.color: {
            if (root.isInvalid)
                return AppStyle.borderError;
            return root.hovered ? root.schemeColor : AppStyle.borderColor;
        }

        Behavior on color {
            ColorAnimation {
                duration: AppStyle.durationFast
                easing.type: Easing.OutCubic
            }
        }

        Behavior on border.color {
            ColorAnimation {
                duration: AppStyle.durationFast
                easing.type: Easing.OutCubic
            }
        }

        // 勾选图标
        CIcon {
            anchors.centerIn: parent
            name: "check"
            size: root.boxSize * 0.7
            iconColor: AppStyle.textLight
            visible: root.checked && !root.isIndeterminate

            scale: root.checked && !root.isIndeterminate ? 1 : 0
            Behavior on scale {
                NumberAnimation {
                    duration: AppStyle.durationFast
                    easing.type: Easing.OutBack
                }
            }
        }

        // 不确定状态图标 (减号)
        CIcon {
            anchors.centerIn: parent
            name: "minus"
            size: root.boxSize * 0.7
            iconColor: AppStyle.textLight
            visible: root.isIndeterminate

            scale: root.isIndeterminate ? 1 : 0
            Behavior on scale {
                NumberAnimation {
                    duration: AppStyle.durationFast
                    easing.type: Easing.OutBack
                }
            }
        }
    }

    contentItem: Text {
        text: root.text
        font.pixelSize: root.fontSize
        color: AppStyle.textColor
        verticalAlignment: Text.AlignVCenter
        leftPadding: root.indicator.width + root.spacing
    }
}
