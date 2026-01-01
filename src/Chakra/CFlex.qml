pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

/*
    CFlex - 弹性布局组件

    == 组件库特有属性 ==
    direction : 排列方向，可选 "row" | "column"，默认 "row"
    wrap      : 是否换行，默认 false
    justify   : 主轴对齐，可选 "start" | "center" | "end" | "between" | "around"，默认 "start"
    align     : 交叉轴对齐，可选 "start" | "center" | "end" | "stretch"，默认 "stretch"
    gap       : 子元素间距，默认 0
    padding   : 内边距（四边），默认 0
    paddingX  : 水平内边距
    paddingY  : 垂直内边距
*/
Item {
    id: root

    // Flex 方向
    property string direction: "row"  // row, column
    property bool wrap: false

    // 对齐
    property string justify: "start"  // start, center, end, between, around
    property string align: "stretch"   // start, center, end, stretch

    // 间距
    property int gap: 0

    // 内边距
    property int padding: 0
    property int paddingX: padding
    property int paddingY: padding

    // 内容
    default property alias content: layout.data

    implicitWidth: layout.implicitWidth + paddingX * 2
    implicitHeight: layout.implicitHeight + paddingY * 2

    Item {
        anchors.fill: parent
        anchors.margins: root.padding
        anchors.leftMargin: root.paddingX
        anchors.rightMargin: root.paddingX
        anchors.topMargin: root.paddingY
        anchors.bottomMargin: root.paddingY

        GridLayout {
            id: layout
            width: {
                if (root.direction === "row" && (root.justify === "between" || root.justify === "around"))
                    return parent.width;
                if (root.direction === "row" && root.justify !== "center" && root.justify !== "end")
                    return parent.width;
                return implicitWidth;
            }
            height: {
                if (root.direction === "column" && (root.justify === "between" || root.justify === "around"))
                    return parent.height;
                if (root.direction === "column" && root.justify !== "center" && root.justify !== "end")
                    return parent.height;
                return implicitHeight;
            }

            columns: root.direction === "row" ? (root.wrap ? -1 : children.length) : 1
            rows: root.direction === "column" ? (root.wrap ? -1 : children.length) : 1

            // space-between 和 space-around 通过动态间距实现
            columnSpacing: {
                if (root.direction === "row") {
                    if (root.justify === "between" || root.justify === "around") {
                        return root._calculatedSpacing;
                    }
                    return root.gap;
                }
                return 0;
            }
            rowSpacing: {
                if (root.direction === "column") {
                    if (root.justify === "between" || root.justify === "around") {
                        return root._calculatedSpacing;
                    }
                    return root.gap;
                }
                return 0;
            }

            // 应用主轴对齐方式
            anchors.horizontalCenter: {
                if (root.direction === "row" && root.justify === "center")
                    return parent.horizontalCenter;
                if (root.direction === "column")
                    return undefined;
                return undefined;
            }
            anchors.verticalCenter: {
                if (root.direction === "column" && root.justify === "center")
                    return parent.verticalCenter;
                if (root.direction === "row")
                    return undefined;
                return undefined;
            }
            anchors.right: {
                if (root.direction === "row" && root.justify === "end")
                    return parent.right;
                return undefined;
            }
            anchors.bottom: {
                if (root.direction === "column" && root.justify === "end")
                    return parent.bottom;
                return undefined;
            }

            Component.onCompleted: updateChildrenAlignment()
            onChildrenChanged: updateChildrenAlignment()

            function updateChildrenAlignment() {
                for (let i = 0; i < children.length; i++) {
                    let child = children[i];
                    if (child) {
                        // 设置交叉轴对齐
                        if (root.direction === "row") {
                            switch (root.align) {
                            case "center":
                                child.Layout.alignment = Qt.AlignVCenter;
                                break;
                            case "end":
                                child.Layout.alignment = Qt.AlignBottom;
                                break;
                            case "stretch":
                                child.Layout.fillHeight = true;
                                break;
                            default:
                                child.Layout.alignment = Qt.AlignTop;
                            }
                        } else {
                            switch (root.align) {
                            case "center":
                                child.Layout.alignment = Qt.AlignHCenter;
                                break;
                            case "end":
                                child.Layout.alignment = Qt.AlignRight;
                                break;
                            case "stretch":
                                child.Layout.fillWidth = true;
                                break;
                            default:
                                child.Layout.alignment = Qt.AlignLeft;
                            }
                        }
                    }
                }
            }
        }
    }

    // 计算 space-between 和 space-around 的间距
    property int _calculatedSpacing: {
        if (root.justify !== "between" && root.justify !== "around") {
            return root.gap;
        }

        let childCount = layout.children.length;
        if (childCount <= 1) {
            return 0;
        }

        let availableSpace = root.direction === "row" ? layout.width : layout.height;
        let totalChildSize = 0;

        for (let i = 0; i < childCount; i++) {
            let child = layout.children[i];
            if (child) {
                totalChildSize += root.direction === "row" ? child.width : child.height;
            }
        }

        let remainingSpace = availableSpace - totalChildSize;

        if (root.justify === "between") {
            return Math.max(0, remainingSpace / (childCount - 1));
        } else if (root.justify === "around") {
            return Math.max(0, remainingSpace / childCount);
        }

        return root.gap;
    }
}
