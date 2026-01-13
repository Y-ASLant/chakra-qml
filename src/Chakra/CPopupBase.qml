pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

/*
    CPopupBase - 弹窗组件基类

    提供 Dialog 和 Drawer 的公共功能：
    - 关闭按钮及交互
    - 内容宽度自动更新
    - 遮罩层样式
    - 关闭策略配置
*/
Popup {
    id: root

    // 标题
    property string title: ""

    // 是否显示关闭按钮
    property bool showCloseButton: true

    // 是否点击遮罩关闭
    property bool closeOnOverlayClick: true

    // 是否按 ESC 关闭
    property bool closeOnEsc: true

    modal: true
    focus: true

    closePolicy: {
        var policy = Popup.NoAutoClose;
        if (closeOnOverlayClick)
            policy |= Popup.CloseOnPressOutside;
        if (closeOnEsc)
            policy |= Popup.CloseOnEscape;
        return policy;
    }

    // 遮罩层
    Overlay.modal: Rectangle {
        color: AppStyle.overlayColor
        radius: AppStyle.windowRadius

        Behavior on opacity {
            NumberAnimation {
                duration: AppStyle.durationNormal
                easing.type: Easing.OutCubic
            }
        }
    }

    // 背景
    background: Rectangle {
        color: AppStyle.surfaceColor
        radius: __popupRadius

        Behavior on color {
            ColorAnimation {
                duration: AppStyle.durationNormal
                easing.type: Easing.OutCubic
            }
        }
    }

    // 子组件可重写的圆角
    property int __popupRadius: AppStyle.radiusLg
}
