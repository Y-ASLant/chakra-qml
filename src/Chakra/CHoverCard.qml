pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Effects

/*
    CHoverCard - 悬停卡片组件

    == 组件库特有属性 ==
    delay       : 打开延迟（毫秒），默认 600（与 CTooltip 一致）
    closeDelay  : 关闭延迟（毫秒），默认 300
    placement   : 位置，可选 "top" | "bottom" | "left" | "right"，默认 "bottom"
    hasArrow    : 是否有箭头，默认 true
    disabled    : 是否禁用，默认 false
    isOpen      : 是否打开（只读）
    trigger     : 触发器内容（Component 类型）
    content     : 卡片内容（default 属性）

    == 信号 ==
    opened : 打开时触发
    closed : 关闭时触发
*/
Item {
    id: root

    // 打开延迟（毫秒）- 与 CTooltip 的 delay 属性保持一致
    property int delay: 600

    // 关闭延迟（毫秒）
    property int closeDelay: 300

    // 位置: top, bottom, left, right
    property string placement: "bottom"

    // 是否有箭头
    property bool hasArrow: true

    // 是否禁用 - 与其他组件的 disabled 命名一致
    property bool disabled: false

    // 是否打开（只读）
    readonly property bool isOpen: popup.visible

    // 触发器
    property alias trigger: triggerLoader.sourceComponent

    // 卡片内容
    default property alias content: contentContainer.data

    // 信号
    signal opened
    signal closed

    implicitWidth: triggerLoader.item ? triggerLoader.item.implicitWidth : 0
    implicitHeight: triggerLoader.item ? triggerLoader.item.implicitHeight : 0

    // 内部：缓存窗口根元素和位置
    property Item _windowRoot: null
    property real _popupX: 0
    property real _popupY: 0

    // 常量
    readonly property int _gap: 8
    readonly property int _padding: 4

    // 位置配置映射
    readonly property var _placementConfig: ({
        top: { transformOrigin: Popup.Bottom, arrowRotation: 0 },
        bottom: { transformOrigin: Popup.Top, arrowRotation: 180 },
        left: { transformOrigin: Popup.Right, arrowRotation: -90 },
        right: { transformOrigin: Popup.Left, arrowRotation: 90 }
    })

    // 检查是否应该打开（非禁用且鼠标在触发区）
    function _shouldOpen(): bool {
        return !root.disabled && triggerArea.containsMouse;
    }

    // 检查是否应该关闭（鼠标都不在触发区和弹出区）
    function _shouldClose(): bool {
        return !triggerArea.containsMouse && !popupArea.containsMouse;
    }

    // 获取窗口根元素
    function _getWindowRoot(): Item {
        if (!_windowRoot) {
            var item = root;
            while (item.parent) item = item.parent;
            _windowRoot = item;
        }
        return _windowRoot;
    }

    // 边界限制，确保坐标在有效范围内
    function _clamp(value: real, min: real, max: real): real {
        return Math.max(min, Math.min(value, max));
    }

    // 计算弹出层位置
    function _calculatePosition(pos: point, windowWidth: real, windowHeight: real): point {
        var tx, ty;
        var pw = popup.width;
        var ph = popup.height;
        var rw = root.width;
        var rh = root.height;

        switch (root.placement) {
        case "left":
            tx = pos.x - pw - _gap;
            ty = pos.y + (rh - ph) / 2;
            break;
        case "right":
            tx = pos.x + rw + _gap;
            ty = pos.y + (rh - ph) / 2;
            break;
        case "top":
            tx = pos.x + (rw - pw) / 2;
            ty = pos.y - ph - _gap;
            break;
        default: // bottom
            tx = pos.x + (rw - pw) / 2;
            ty = pos.y + rh + _gap;
        }

        return {
            x: _clamp(tx, _padding, windowWidth - pw - _padding),
            y: _clamp(ty, _padding, windowHeight - ph - _padding)
        };
    }

    // 更新弹出层位置
    function updatePopupPosition() {
        var winRoot = _getWindowRoot();
        var pos = root.mapToItem(winRoot, 0, 0);
        var result = _calculatePosition(pos, winRoot.width, winRoot.height);
        _popupX = result.x;
        _popupY = result.y;
    }

    // 触发器
    Loader {
        id: triggerLoader
    }

    MouseArea {
        id: triggerArea
        anchors.fill: triggerLoader
        hoverEnabled: true
        enabled: !root.disabled
        acceptedButtons: Qt.NoButton

        onContainsMouseChanged: {
            if (containsMouse) {
                closeTimer.stop();
                openTimer.restart();
            } else {
                openTimer.stop();
                closeTimer.restart();
            }
        }
    }

    // 打开延迟定时器
    Timer {
        id: openTimer
        interval: root.delay
        onTriggered: {
            if (_shouldOpen()) {
                root.updatePopupPosition();
                popup.open();
            }
        }
    }

    // 关闭延迟定时器
    Timer {
        id: closeTimer
        interval: root.closeDelay
        onTriggered: {
            if (_shouldClose()) {
                popup.close();
            }
        }
    }

    // 悬停卡片弹出层
    Popup {
        id: popup
        parent: root._windowRoot

        x: root._popupX
        y: root._popupY

        padding: 0
        closePolicy: Popup.NoAutoClose

        onOpened: root.opened()
        onClosed: root.closed()

        enter: Transition {
            NumberAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: AppStyle.durationFast
                easing.type: Easing.OutCubic
            }
            NumberAnimation {
                property: "scale"
                from: 0.96
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
                duration: AppStyle.durationXFast
                easing.type: Easing.OutCubic
            }
            NumberAnimation {
                property: "scale"
                from: 1
                to: 0.96
                duration: AppStyle.durationXFast
                easing.type: Easing.OutCubic
            }
        }

        transformOrigin: {
            var config = _placementConfig[root.placement];
            return config ? config.transformOrigin : Popup.Top;
        }

        background: Item {
            // 箭头
            Canvas {
                id: arrow
                visible: root.hasArrow
                width: 12
                height: 8

                // 位置计算：左右方向靠边缘定位，上下方向居中
                x: {
                    if (root.placement === "left")
                        return parent.width - 1;
                    if (root.placement === "right")
                        return -width + 1;
                    return (parent.width - width) / 2;
                }

                y: {
                    if (root.placement === "top")
                        return parent.height - 1;
                    if (root.placement === "bottom")
                        return -height + 1;
                    return (parent.height - height) / 2;
                }

                rotation: {
                    var config = _placementConfig[root.placement];
                    return config ? config.arrowRotation : 0;
                }

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();
                    ctx.fillStyle = AppStyle.surfaceColor;
                    ctx.strokeStyle = AppStyle.borderColor;
                    ctx.lineWidth = 1;
                    ctx.beginPath();
                    ctx.moveTo(0, 0);
                    ctx.lineTo(width / 2, height);
                    ctx.lineTo(width, 0);
                    ctx.closePath();
                    ctx.fill();
                    ctx.stroke();
                }

                Connections {
                    target: AppStyle
                    function onIsDarkChanged() {
                        arrow.requestPaint();
                    }
                }
            }

            Rectangle {
                anchors.fill: parent
                color: AppStyle.surfaceColor
                radius: AppStyle.radiusLg
                border.width: 1
                border.color: AppStyle.borderColor

                layer.enabled: true
                layer.effect: MultiEffect {
                    shadowEnabled: true
                    shadowColor: "#20000000"
                    shadowBlur: 0.5
                    shadowVerticalOffset: 4
                }
            }
        }

        contentItem: Item {
            implicitWidth: contentContainer.implicitWidth + AppStyle.spacing4 * 2
            implicitHeight: contentContainer.implicitHeight + AppStyle.spacing3 * 2

            MouseArea {
                id: popupArea
                anchors.fill: parent
                hoverEnabled: true
                acceptedButtons: Qt.NoButton

                onContainsMouseChanged: {
                    if (containsMouse) {
                        closeTimer.stop();
                    } else {
                        closeTimer.restart();
                    }
                }
            }

            Item {
                id: contentContainer
                anchors.fill: parent
                anchors.margins: AppStyle.spacing3
                anchors.leftMargin: AppStyle.spacing4
                anchors.rightMargin: AppStyle.spacing4

                implicitWidth: childrenRect.width
                implicitHeight: childrenRect.height
            }
        }
    }
}
