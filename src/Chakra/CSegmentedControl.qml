pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects

/*
    CSegmentedControl - 分段控制器组件

    == 组件库特有属性 ==
    items         : 选项列表（数组），默认 []
    currentIndex  : 当前选中索引，默认 0
    value         : 当前选中值（只读）
    size          : 尺寸，可选 "xs" | "sm" | "md" | "lg"，默认 "md"
    orientation   : 方向，可选 "horizontal" | "vertical"，默认 "horizontal"
    isDisabled    : 是否禁用，默认 false
    disabledItems : 禁用的选项列表（数组），默认 []

    == 信号 ==
    selectionChanged(string newValue) : 选择变化时触发
*/
Item {
    id: root

    // 选项列表
    property var items: []

    // 当前选中的索引
    property int currentIndex: 0

    // 当前选中的值（只读）
    readonly property string value: items.length > currentIndex ? items[currentIndex] : ""

    // 尺寸: xs, sm, md, lg
    property string size: "md"

    // 方向: horizontal, vertical
    property string orientation: "horizontal"

    // 是否禁用
    property bool isDisabled: false

    // 禁用的选项
    property var disabledItems: []

    // 选择变化信号
    signal selectionChanged(string newValue)

    // 尺寸配置
    property int itemHeight: AppStyle.getSegmentHeight(size)
    property int fontSize: AppStyle.getFontSize(size === "xs" ? "xs" : (size === "lg" ? "md" : "sm"))
    property int itemPadding: AppStyle.getPaddingH(size === "xs" ? "sm" : size)

    // 缓存的最大宽度
    property int _cachedMaxWidth: 0

    // 计算最大项宽度，使所有项等宽
    function calcMaxWidth() {
        var maxW = 0;
        for (var i = 0; i < items.length; i++) {
            itemMetrics.text = items[i];
            var w = itemMetrics.width + itemPadding * 2;
            if (w > maxW)
                maxW = w;
        }
        return Math.max(maxW, 60);
    }

    function updateMaxWidth() {
        _cachedMaxWidth = calcMaxWidth();
    }

    readonly property int maxItemWidth: _cachedMaxWidth

    TextMetrics {
        id: itemMetrics
        font.pixelSize: root.fontSize
    }

    // 合并 onItemsChanged 处理
    onItemsChanged: {
        if (currentIndex >= items.length)
            currentIndex = 0;
        updateMaxWidth();
    }
    onSizeChanged: updateMaxWidth()
    onFontSizeChanged: updateMaxWidth()
    Component.onCompleted: updateMaxWidth()

    implicitWidth: orientation === "horizontal" ? maxItemWidth * items.length + 8 : maxItemWidth + 8
    implicitHeight: orientation === "horizontal" ? itemHeight + 8 : itemHeight * items.length + 8

    // 背景
    Rectangle {
        anchors.fill: parent
        radius: AppStyle.radiusMd
        color: AppStyle.isDark ? Qt.rgba(255, 255, 255, 0.08) : AppStyle.grayLight
        border.width: AppStyle.isDark ? 1 : 0
        border.color: AppStyle.borderColor
    }

    // 滑动指示器
    Rectangle {
        id: indicator
        radius: AppStyle.radiusSm
        color: AppStyle.surfaceColor

        // 阴影效果
        layer.enabled: !AppStyle.isDark
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: "#20000000"
            shadowBlur: 0.3
            shadowVerticalOffset: 1
            shadowHorizontalOffset: 0
        }

        // 暗色模式下使用边框
        border.width: AppStyle.isDark ? 1 : 0
        border.color: AppStyle.borderColor

        x: root.orientation === "horizontal" ? 4 + root.currentIndex * (itemsRow.width / root.items.length) : 4
        y: root.orientation === "horizontal" ? 4 : 4 + root.currentIndex * (itemsColumn.height / root.items.length)

        width: root.orientation === "horizontal" ? itemsRow.width / root.items.length : parent.width - 8
        height: root.orientation === "horizontal" ? parent.height - 8 : itemsColumn.height / root.items.length

        Behavior on x {
            NumberAnimation {
                duration: AppStyle.durationFast
                easing.type: Easing.OutCubic
            }
        }

        Behavior on y {
            NumberAnimation {
                duration: AppStyle.durationFast
                easing.type: Easing.OutCubic
            }
        }
    }

    // 选项项组件
    component SegmentItem: Item {
        id: segmentItem
        required property string modelData
        required property int index

        width: root.maxItemWidth
        height: root.itemHeight

        property bool isDisabled: root.isDisabled || root.disabledItems.indexOf(modelData) !== -1
        property bool isSelected: root.currentIndex === index

        Text {
            anchors.centerIn: parent
            text: segmentItem.modelData
            font.pixelSize: root.fontSize
            font.weight: segmentItem.isSelected ? Font.Medium : Font.Normal
            color: segmentItem.isDisabled ? AppStyle.textMuted : (segmentItem.isSelected ? AppStyle.textColor : AppStyle.textSecondary)

            Behavior on color {
                ColorAnimation {
                    duration: AppStyle.durationFast
                    easing.type: Easing.OutCubic
                }
            }
        }

        MouseArea {
            anchors.fill: parent
            enabled: !segmentItem.isDisabled
            cursorShape: segmentItem.isDisabled ? Qt.ForbiddenCursor : Qt.PointingHandCursor
            onClicked: {
                root.currentIndex = segmentItem.index;
                root.selectionChanged(segmentItem.modelData);
            }
        }
    }

    // 水平布局
    Row {
        id: itemsRow
        visible: root.orientation === "horizontal"
        anchors.centerIn: parent

        Repeater {
            model: root.items
            delegate: SegmentItem {}
        }
    }

    // 垂直布局
    Column {
        id: itemsColumn
        visible: root.orientation === "vertical"
        anchors.centerIn: parent

        Repeater {
            model: root.items
            delegate: SegmentItem {}
        }
    }
}
