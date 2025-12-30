# CSegmentedControl 组件

分段控制器组件，用于在多个选项间切换。

## 示例

```qml
import Chakra

CSegmentedControl {
    items: ["日", "周", "月", "年"]
    currentIndex: 0
    onSelectionChanged: function(value) {
        console.log("选中:", value)
    }
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| items | array | [] | 选项列表 |
| currentIndex | int | 0 | 当前选中索引 |
| value | string | - | 当前选中值（只读） |
| size | string | "md" | 尺寸，可选 "xs" / "sm" / "md" / "lg" |
| orientation | string | "horizontal" | 方向，可选 "horizontal" / "vertical" |
| isDisabled | bool | false | 是否禁用 |
| disabledItems | array | [] | 禁用的选项列表 |

## 信号

| 信号名 | 参数 | 描述 |
|--------|------|------|
| selectionChanged | string newValue | 选择变化时触发 |

## 示例代码

### 基础用法

```qml
CSegmentedControl {
    items: ["全部", "进行中", "已完成"]
}
```

### 垂直方向

```qml
CSegmentedControl {
    items: ["选项 A", "选项 B", "选项 C"]
    orientation: "vertical"
}
```

### 禁用部分选项

```qml
CSegmentedControl {
    items: ["免费", "基础", "专业", "企业"]
    disabledItems: ["企业"]
}
```

### 不同尺寸

```qml
Column {
    spacing: 16

    CSegmentedControl { items: ["A", "B", "C"]; size: "xs" }
    CSegmentedControl { items: ["A", "B", "C"]; size: "sm" }
    CSegmentedControl { items: ["A", "B", "C"]; size: "md" }
    CSegmentedControl { items: ["A", "B", "C"]; size: "lg" }
}
```

### 配合内容切换

```qml
Column {
    spacing: 16

    CSegmentedControl {
        id: tabs
        items: ["概览", "详情", "评论"]
    }

    StackLayout {
        currentIndex: tabs.currentIndex

        Text { text: "概览内容" }
        Text { text: "详情内容" }
        Text { text: "评论内容" }
    }
}
```

## 注意事项

1. 选中项有滑动指示器动画。
2. 所有选项等宽，宽度由最长选项决定。
3. 暗色模式下有边框，亮色模式下有阴影。
