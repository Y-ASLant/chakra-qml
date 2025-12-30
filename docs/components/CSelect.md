# CSelect 组件

选择器组件，支持多种变体和可搜索功能。

## 示例

```qml
import Chakra

CSelect {
    model: ["选项 A", "选项 B", "选项 C"]
    placeholder: "请选择"
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| variant | string | "outline" | 变体，可选 "outline" / "filled" / "flushed" |
| size | string | "md" | 尺寸，可选 "sm" / "md" / "lg" |
| placeholder | string | "Select option" | 占位符文本 |
| isInvalid | bool | false | 是否无效状态 |
| isDisabled | bool | false | 是否禁用 |
| isSearchable | bool | false | 是否可搜索 |

## 示例代码

### 基础用法

```qml
CSelect {
    model: ["苹果", "香蕉", "橙子", "葡萄"]
}
```

### 可搜索

```qml
CSelect {
    model: ["北京", "上海", "广州", "深圳", "杭州", "成都"]
    isSearchable: true
    placeholder: "搜索城市"
}
```

### 不同变体

```qml
Column {
    spacing: 10

    CSelect { model: ["A", "B", "C"]; variant: "outline" }
    CSelect { model: ["A", "B", "C"]; variant: "filled" }
    CSelect { model: ["A", "B", "C"]; variant: "flushed" }
}
```

### 错误状态

```qml
CSelect {
    model: ["选项 A", "选项 B"]
    isInvalid: true
}
```

## 注意事项

1. 可搜索模式下，打开下拉框会自动聚焦搜索框。
2. 下拉箭头有旋转动画。
3. 继承自 ComboBox，支持所有原生属性如 `model`、`currentIndex` 等。
