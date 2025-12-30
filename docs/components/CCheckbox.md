# CCheckbox 组件

复选框组件，支持多种颜色方案、尺寸和不确定状态。

## 示例

```qml
import Chakra

CCheckbox {
    text: "同意条款"
    checked: true
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| colorScheme | string | "primary" | 颜色方案 |
| size | string | "md" | 尺寸，可选 "sm" / "md" / "lg" |
| isIndeterminate | bool | false | 是否半选状态（部分选中） |
| isInvalid | bool | false | 是否无效状态 |

## 示例代码

### 基础用法

```qml
Column {
    spacing: 10

    CCheckbox { text: "选项 A" }
    CCheckbox { text: "选项 B"; checked: true }
    CCheckbox { text: "选项 C" }
}
```

### 不同颜色方案

```qml
Row {
    spacing: 20

    CCheckbox { text: "Primary"; colorScheme: "primary"; checked: true }
    CCheckbox { text: "Success"; colorScheme: "success"; checked: true }
    CCheckbox { text: "Warning"; colorScheme: "warning"; checked: true }
}
```

### 不确定状态

```qml
CCheckbox {
    text: "全选"
    isIndeterminate: true
}
```

### 错误状态

```qml
CCheckbox {
    text: "必须同意"
    isInvalid: true
}
```

## 注意事项

1. `isIndeterminate` 用于表示部分选中状态，常用于全选场景。
2. 继承自 CheckBox，支持所有原生属性如 `checked`、`text` 等。
3. 点击时有缩放动画反馈。
