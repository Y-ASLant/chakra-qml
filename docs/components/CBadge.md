# CBadge 组件

徽章组件，用于显示状态标签或计数。

## 示例

```qml
import Chakra

CBadge {
    text: "NEW"
    colorScheme: "primary"
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| colorScheme | string | "primary" | 颜色方案，如 "primary" / "success" / "warning" / "error" / "gray" |
| variant | string | "subtle" | 变体，可选 "solid" / "subtle" / "outline" |
| size | string | "md" | 尺寸，可选 "sm" / "md" / "lg" |
| text | string | "" | 徽章文本 |

## 示例代码

### 不同颜色方案

```qml
Row {
    spacing: 10

    CBadge { text: "Primary"; colorScheme: "primary" }
    CBadge { text: "Success"; colorScheme: "success" }
    CBadge { text: "Warning"; colorScheme: "warning" }
    CBadge { text: "Error"; colorScheme: "error" }
}
```

### 不同变体

```qml
Row {
    spacing: 10

    CBadge { text: "Solid"; variant: "solid" }
    CBadge { text: "Subtle"; variant: "subtle" }
    CBadge { text: "Outline"; variant: "outline" }
}
```

### 不同尺寸

```qml
Row {
    spacing: 10
    
    CBadge { text: "SM"; size: "sm" }
    CBadge { text: "MD"; size: "md" }
    CBadge { text: "LG"; size: "lg" }
}
```

## 注意事项

1. 文本会自动转换为大写。
2. 适合用于状态标签、版本号、计数等场景。
