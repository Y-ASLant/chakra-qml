pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects

/*
    CProgress - 进度条组件

    == 组件库特有属性 ==
    value            : 进度值（0-100），默认 0
    colorScheme      : 颜色方案，默认 "primary"
    size             : 尺寸，可选 "xs" | "sm" | "md" | "lg"，默认 "md"
    hasStripe        : 是否显示条纹效果，默认 false
    isAnimated       : 是否动画条纹（需配合 hasStripe），默认 false
    animationEnabled : 是否启用动画（全局开关），默认 true
    isIndeterminate  : 是否不确定状态（加载中），默认 false
*/
Item {
    id: root

    // 值 (0-100)
    property real value: 0

    // 颜色方案
    property string colorScheme: "primary"

    // 尺寸: xs, sm, md, lg
    property string size: "md"

    // 是否显示条纹
    property bool hasStripe: false

    // 是否动画条纹
    property bool isAnimated: false

    // 动画总开关（性能优化）
    property bool animationEnabled: true

    // 是否不确定状态
    property bool isIndeterminate: false

    property color schemeColor: AppStyle.getSchemeColor(colorScheme)

    property int trackHeight: AppStyle.getProgressHeight(size)

    implicitWidth: 200
    implicitHeight: trackHeight

    // 背景轨道
    Rectangle {
        id: track
        anchors.fill: parent
        radius: height / 2
        color: AppStyle.borderColor
    }

    // 填充层 - 使用 layer mask 裁剪为圆角
    Item {
        id: fillContainer
        anchors.fill: parent

        layer.enabled: true
        layer.effect: MultiEffect {
            maskEnabled: true
            maskThresholdMin: 0.5
            maskSpreadAtMin: 1.0
            maskSource: ShaderEffectSource {
                sourceItem: Rectangle {
                    width: fillContainer.width
                    height: fillContainer.height
                    radius: track.radius
                }
            }
        }

        // 填充条
        Rectangle {
            id: fill
            height: parent.height
            radius: track.radius
            color: root.schemeColor

            width: root.isIndeterminate ? parent.width * 0.3 : parent.width * (root.value / 100)

            x: root.isIndeterminate ? indeterminateAnim.x : 0

            Behavior on width {
                enabled: !root.isIndeterminate
                NumberAnimation {
                    duration: AppStyle.durationNormal
                    easing.type: Easing.OutCubic
                }
            }

            // 条纹效果 - Canvas 实现（兼容性好，无需 GPU）
            Canvas {
                id: stripeCanvas
                visible: root.hasStripe
                anchors.fill: parent

                property real offset: 0

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();

                    var stripeWidth = 20;
                    ctx.fillStyle = Qt.rgba(1, 1, 1, 0.15);

                    for (var i = -stripeWidth; i < width + stripeWidth * 2; i += stripeWidth * 2) {
                        ctx.beginPath();
                        ctx.moveTo(i + offset, 0);
                        ctx.lineTo(i + stripeWidth + offset, 0);
                        ctx.lineTo(i + offset, height);
                        ctx.lineTo(i - stripeWidth + offset, height);
                        ctx.closePath();
                        ctx.fill();
                    }
                }

                Timer {
                    id: animTimer
                    interval: 33
                    running: root.visible && root.isAnimated && root.hasStripe && root.animationEnabled
                    repeat: true
                    onTriggered: {
                        stripeCanvas.offset = (stripeCanvas.offset + 2) % 40
                        stripeCanvas.requestPaint()
                    }
                }
            }
        }
    }

    // 不确定状态动画
    SequentialAnimation {
        id: indeterminateAnim
        running: root.visible && root.isIndeterminate && root.animationEnabled
        loops: Animation.Infinite

        property real x: 0

        NumberAnimation {
            target: indeterminateAnim
            property: "x"
            from: -track.width * 0.3
            to: track.width
            duration: 1500
            easing.type: Easing.InOutQuad
        }
    }
}
