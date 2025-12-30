# CTooltip 组件

工具提示组件，用于显示额外信息。

## 示例

```qml
import Chakra

CButton {
    text: "悬停我"
    CTooltip {
        text: "这是提示信息"
    }
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| placement | string | "top" | 位置，可选 "top" / "bottom" / "left" / "right" |
| hasArrow | bool | true | 是否有箭头 |
| text | string | "" | 提示文本（继承自 ToolTip） |
| delay | int | 300 | 显示延迟（毫秒） |
| timeout | int | 5000 | 自动隐藏时间（毫秒） |

## 示例代码

### 不同位置

```qml
Row {
    spacing: 20

    CButton {
        text: "上方"
        CTooltip { text: "Top"; placement: "top" }
    }

    CButton {
        text: "下方"
        CTooltip { text: "Bottom"; placement: "bottom" }
    }

    CButton {
        text: "左侧"
        CTooltip { text: "Left"; placement: "left" }
    }

    CButton {
        text: "右侧"
        CTooltip { text: "Right"; placement: "right" }
    }
}
```

### 无箭头

```qml
CButton {
    text: "无箭头"
    CTooltip {
        text: "没有箭头的提示"
        hasArrow: false
    }
}
```

### 自定义延迟

```qml
CButton {
    text: "快速显示"
    CTooltip {
        text: "立即显示"
        delay: 0
    }
}
```

## 注意事项

1. 将 CTooltip 作为目标元素的子元素使用。
2. 提示框背景为深色，文字为白色。
3. 有淡入淡出动画效果。
