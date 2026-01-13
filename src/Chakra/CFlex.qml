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
    property string direction: "row"
    property bool wrap: false

    // 对齐
    property string justify: "start"
    property string align: "stretch"

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

    // 判断是否需要填满父容器（start/between/around 在主轴方向需要填满）
    readonly property bool _fillsMainAxis: {
        const needsFill = ["start", "between", "around"].includes(justify);
        return direction === "row" ? needsFill : false;
    }

    readonly property bool _fillsCrossAxis: {
        const needsFill = ["start", "between", "around"].includes(justify);
        return direction === "column" ? needsFill : false;
    }

    Item {
        anchors.fill: parent
        anchors.leftMargin: root.paddingX
        anchors.rightMargin: root.paddingX
        anchors.topMargin: root.paddingY
        anchors.bottomMargin: root.paddingY

        GridLayout {
            id: layout

            width: root._fillsMainAxis ? parent.width : implicitWidth
            height: root._fillsCrossAxis ? parent.height : implicitHeight

            columns: root.direction === "row" ? (root.wrap ? -1 : children.length) : 1
            rows: root.direction === "column" ? (root.wrap ? -1 : children.length) : 1

            columnSpacing: root.direction === "row" ? root._effectiveSpacing : 0
            rowSpacing: root.direction === "column" ? root._effectiveSpacing : 0

            // 主轴对齐：center 和 end 使用 anchors
            anchors.horizontalCenter: (root.direction === "row" && root.justify === "center") ? parent.horizontalCenter : undefined
            anchors.verticalCenter: (root.direction === "column" && root.justify === "center") ? parent.verticalCenter : undefined
            anchors.right: (root.direction === "row" && root.justify === "end") ? parent.right : undefined
            anchors.bottom: (root.direction === "column" && root.justify === "end") ? parent.bottom : undefined

            Component.onCompleted: root._updateChildrenAlignment()
            onChildrenChanged: root._updateChildrenAlignment()
        }
    }

    // 有效间距：between/around 使用计算值，其他使用 gap
    readonly property int _effectiveSpacing: {
        if (!["between", "around"].includes(justify)) {
            return gap;
        }
        const childCount = layout.children.length;
        if (childCount <= 1) {
            return 0;
        }

        const mainAxisSize = direction === "row" ? layout.width : layout.height;
        const totalChildSize = _getTotalChildSize();
        const remainingSpace = mainAxisSize - totalChildSize;

        if (justify === "between") {
            return Math.max(0, remainingSpace / (childCount - 1));
        }
        // around
        return Math.max(0, remainingSpace / childCount);
    }

    // 计算子元素在主轴方向的总尺寸
    function _getTotalChildSize() {
        let total = 0;
        const isRow = direction === "row";
        for (let i = 0; i < layout.children.length; i++) {
            const child = layout.children[i];
            if (child) {
                total += isRow ? child.width : child.height;
            }
        }
        return total;
    }

    // 交叉轴对齐映射表
    readonly property var _crossAxisAlignMap: {
        "row": {
            "start": Qt.AlignTop,
            "center": Qt.AlignVCenter,
            "end": Qt.AlignBottom
        },
        "column": {
            "start": Qt.AlignLeft,
            "center": Qt.AlignHCenter,
            "end": Qt.AlignRight
        }
    }

    function _updateChildrenAlignment() {
        for (let i = 0; i < layout.children.length; i++) {
            const child = layout.children[i];
            if (!child) {
                continue;
            }

            // 重置填充属性
            child.Layout.fillWidth = false;
            child.Layout.fillHeight = false;

            if (align === "stretch") {
                if (direction === "row") {
                    child.Layout.fillHeight = true;
                } else {
                    child.Layout.fillWidth = true;
                }
            } else {
                child.Layout.alignment = _crossAxisAlignMap[direction][align];
            }
        }
    }
}
