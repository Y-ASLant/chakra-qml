import QtQuick
import QtQuick.Controls

/*
    CTooltip - 工具提示组件

    == 组件库特有属性 ==
    placement : 位置，可选 "top" | "bottom" | "left" | "right"，默认 "top"
    hasArrow  : 是否有箭头，默认 true
    text      : 提示文本（继承自 ToolTip）
    delay     : 显示延迟（毫秒），默认 300
    timeout   : 自动隐藏时间（毫秒），默认 5000
*/
ToolTip {
    id: root

    // 位置: top, bottom, left, right
    property string placement: "top"

    // 是否有箭头
    property bool hasArrow: true

    delay: 300
    timeout: 5000

    contentItem: Text {
        text: root.text
        font.pixelSize: AppStyle.fontSizeSm
        color: AppStyle.textLight
        wrapMode: Text.WordWrap
    }

    background: Item {
        implicitWidth: Math.max(contentWidth + AppStyle.spacing3 * 2, 60)
        implicitHeight: contentHeight + AppStyle.spacing2 * 2

        property real contentWidth: root.contentItem.implicitWidth
        property real contentHeight: root.contentItem.implicitHeight

        Rectangle {
            anchors.fill: parent
            color: "#1A202C"
            radius: AppStyle.radiusLg
        }

        // 箭头
        Canvas {
            visible: root.hasArrow
            width: 12
            height: 6

            x: {
                if (root.placement === "left")
                    return parent.width;
                if (root.placement === "right")
                    return -width;
                return (parent.width - width) / 2;
            }

            y: {
                if (root.placement === "top")
                    return parent.height;
                if (root.placement === "bottom")
                    return -height;
                return (parent.height - height) / 2;
            }

            rotation: {
                if (root.placement === "top")
                    return 0;
                if (root.placement === "bottom")
                    return 180;
                if (root.placement === "left")
                    return -90;
                return 90;
            }

            onPaint: {
                var ctx = getContext("2d");
                ctx.reset();
                ctx.fillStyle = "#1A202C";
                ctx.beginPath();
                ctx.moveTo(0, 0);
                ctx.lineTo(width / 2, height);
                ctx.lineTo(width, 0);
                ctx.closePath();
                ctx.fill();
            }
        }
    }

    // 进入动画
    enter: Transition {
        NumberAnimation {
            property: "opacity"
            from: 0
            to: 1
            duration: AppStyle.durationFast
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
    }
}
