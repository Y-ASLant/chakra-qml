# CScrollBar 组件

滚动条组件，提供统一的滚动条样式。

## 示例

```qml
import Chakra

Flickable {
    ScrollBar.vertical: CScrollBar {}
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| scrollBarSize | string | "md" | 尺寸，可选 "xs" / "sm" / "md" / "lg" |

## 示例代码

### 配合 Flickable 使用

```qml
Flickable {
    width: 300
    height: 200
    contentHeight: content.height
    clip: true

    Column {
        id: content
        Repeater {
            model: 50
            delegate: Text { text: "行 " + (index + 1) }
        }
    }

    ScrollBar.vertical: CScrollBar { scrollBarSize: "sm" }
}
```

### 配合 ListView 使用

```qml
ListView {
    width: 300
    height: 200
    model: 100
    delegate: Text { text: "项目 " + index }

    ScrollBar.vertical: CScrollBar {}
}
```

### 不同尺寸

```qml
Row {
    spacing: 20

    Flickable {
        width: 100; height: 150
        contentHeight: 500
        ScrollBar.vertical: CScrollBar { scrollBarSize: "xs" }
        Rectangle { width: 100; height: 500; color: AppStyle.backgroundColor }
    }

    Flickable {
        width: 100; height: 150
        contentHeight: 500
        ScrollBar.vertical: CScrollBar { scrollBarSize: "md" }
        Rectangle { width: 100; height: 500; color: AppStyle.backgroundColor }
    }

    Flickable {
        width: 100; height: 150
        contentHeight: 500
        ScrollBar.vertical: CScrollBar { scrollBarSize: "lg" }
        Rectangle { width: 100; height: 500; color: AppStyle.backgroundColor }
    }
}
```

## 注意事项

1. 滚动条有悬停和按下状态的颜色变化。
2. 不活动时滚动条会变淡。
3. 在 CWindow 中会自动注册为可点击区域（不触发窗口拖拽）。
