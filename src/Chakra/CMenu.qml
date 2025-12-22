pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Effects

/*
    CMenu - 菜单组件

    == 组件库特有属性 ==
    size      : 尺寸，可选 "sm" | "md" | "lg"，默认 "md"
    trigger   : 触发器组件（Component 类型），默认为按钮
    menuWidth : 菜单宽度，默认 200
    maxHeight : 菜单最大高度，默认 300
    placement : 定位，可选 "bottom" | "top" | "left" | "right"，默认 "bottom"
    isOpen    : 菜单是否打开（只读）

    == 信号 ==
    menuOpened : 菜单打开时触发
    menuClosed : 菜单关闭时触发

    == 方法 ==
    open()   : 打开菜单
    close()  : 关闭菜单
    toggle() : 切换菜单
*/
Item {
    id: root

    // 尺寸: sm, md, lg
    property string size: "md"

    // 菜单内容 (使用 default property 放置 CMenuItem)
    default property alias menuItems: menuColumn.children

    // 触发器组件
    property Component trigger: CButton {
        text: "Open Menu"
        rightIcon: "chevron-down"
        variant: "outline"
    }

    // 控制菜单显示
    property bool isOpen: popup.visible

    // 菜单宽度
    property int menuWidth: 200

    // 菜单最大高度
    property int maxHeight: 300

    // 定位: bottom, top, left, right
    property string placement: "bottom"

    // 信号
    signal menuOpened
    signal menuClosed

    function open() {
        popup.open();
    }

    function close() {
        popup.close();
    }

    function toggle() {
        if (popup.visible) {
            popup.close();
        } else {
            popup.open();
        }
    }

    implicitWidth: triggerLoader.implicitWidth
    implicitHeight: triggerLoader.implicitHeight

    // 触发器
    Loader {
        id: triggerLoader
        sourceComponent: root.trigger
        anchors.fill: parent

        Connections {
            target: triggerLoader.item
            function onClicked() {
                root.toggle();
            }
        }
    }

    // 菜单弹出层
    Popup {
        id: popup

        x: {
            switch (root.placement) {
            case "left":
                return -width - 4;
            case "right":
                return root.width + 4;
            default:
                return 0;
            }
        }

        y: {
            switch (root.placement) {
            case "top":
                return -height - 4;
            case "bottom":
                return root.height + 4;
            case "left":
            case "right":
                return 0;
            default:
                return root.height + 4;
            }
        }

        width: root.menuWidth
        implicitHeight: Math.min(contentItem.implicitHeight + padding * 2, root.maxHeight)
        padding: AppStyle.spacing1

        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

        onOpened: root.menuOpened()
        onClosed: root.menuClosed()

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
                from: 0.95
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
                to: 0.95
                duration: AppStyle.durationXFast
                easing.type: Easing.OutCubic
            }
        }

        transformOrigin: {
            switch (root.placement) {
            case "top":
                return Popup.Bottom;
            case "left":
                return Popup.Right;
            case "right":
                return Popup.Left;
            default:
                return Popup.Top;
            }
        }

        contentItem: Flickable {
            id: menuFlickable
            clip: true
            implicitHeight: menuColumn.implicitHeight
            contentHeight: menuColumn.implicitHeight
            boundsBehavior: Flickable.StopAtBounds

            Column {
                id: menuColumn
                width: menuFlickable.width
                spacing: 2

                property var _connectedItems: ({})

                function connectCloseSignal(item, id) {
                    if (!item || !item.closeMenu || _connectedItems[id])
                        return;
                    item.closeMenu.connect(popup.close);
                    _connectedItems[id] = true;
                }

                onChildrenChanged: {
                    for (let i = 0; i < children.length; i++) {
                        let child = children[i];
                        let childId = "item_" + i;
                        connectCloseSignal(child, childId);
                        if (child.items) {
                            for (let j = 0; j < child.items.length; j++) {
                                connectCloseSignal(child.items[j], childId + "_" + j);
                            }
                        }
                    }
                }
            }

            ScrollBar.vertical: ScrollBar {
                policy: menuFlickable.contentHeight > root.maxHeight - popup.padding * 2 ? ScrollBar.AsNeeded : ScrollBar.AlwaysOff
            }
        }

        background: Rectangle {
            color: AppStyle.surfaceColor
            radius: AppStyle.radiusLg
            border.width: 1
            border.color: AppStyle.borderColor

            layer.enabled: true
            layer.effect: MultiEffect {
                shadowEnabled: true
                shadowColor: "#20000000"
                shadowBlur: 0.5
                shadowHorizontalOffset: 0
                shadowVerticalOffset: 4
            }
        }
    }
}
