# CButton 组件

按钮组件，支持多种变体、颜色方案和尺寸，可添加图标和加载状态。

## 示例

```qml
import Chakra

CButton {
    text: "点击我"
    onClicked: console.log("按钮被点击")
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| variant | string | "solid" | 变体，可选 "solid" / "outline" / "ghost" / "link" |
| colorScheme | string | "primary" | 颜色方案，如 "primary" / "gray" / "red" / "green" / "blue" 等 |
| size | string | "md" | 尺寸，可选 "sm" / "md" / "lg" |
| fullWidth | bool | false | 是否全宽 |
| leftIcon | string | "" | 左侧图标名称 |
| rightIcon | string | "" | 右侧图标名称 |
| iconOnly | bool | false | 仅图标按钮（无文字，正方形） |
| isLoading | bool | false | 加载状态，显示 spinner |

## 示例代码

### 不同变体

```qml
Row {
    spacing: 10

    CButton { text: "Solid"; variant: "solid" }
    CButton { text: "Outline"; variant: "outline" }
    CButton { text: "Ghost"; variant: "ghost" }
    CButton { text: "Link"; variant: "link" }
}
```

### 不同颜色方案

```qml
Row {
    spacing: 10

    CButton { text: "Primary"; colorScheme: "primary" }
    CButton { text: "Success"; colorScheme: "success" }
    CButton { text: "Warning"; colorScheme: "warning" }
    CButton { text: "Error"; colorScheme: "error" }
}
```

### 带图标

```qml
Row {
    spacing: 10

    CButton { text: "下载"; leftIcon: "download" }
    CButton { text: "设置"; rightIcon: "gear" }
    CButton { leftIcon: "heart"; iconOnly: true }
}
```

### 加载状态

```qml
CButton {
    text: "提交"
    isLoading: true
}
```

## 注意事项

1. 加载状态下按钮会自动禁用，防止重复点击。
2. `iconOnly` 模式下按钮为正方形，适合工具栏场景。
3. 按钮点击时会获取焦点，使其他输入框失去焦点。
