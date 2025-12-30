# CInput 组件

输入框组件，支持多种变体、密码输入、清除按钮和自定义元素。

## 示例

```qml
import Chakra

CInput {
    placeholderText: "请输入内容"
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| variant | string | "outline" | 变体，可选 "outline" / "filled" / "flushed" |
| type | string | "text" | 输入类型，可选 "text" / "password" |
| size | string | "md" | 尺寸，可选 "sm" / "md" / "lg" |
| isInvalid | bool | false | 是否无效状态（显示错误样式） |
| isDisabled | bool | false | 是否禁用 |
| isClearable | bool | false | 是否显示清除按钮 |
| maxLength | int | 0 | 最大长度（0 表示无限制） |
| leftElement | Component | null | 左侧自定义元素 |
| rightElement | Component | null | 右侧自定义元素 |

## 示例代码

### 不同变体

```qml
Column {
    spacing: 10

    CInput { placeholderText: "Outline"; variant: "outline" }
    CInput { placeholderText: "Filled"; variant: "filled" }
    CInput { placeholderText: "Flushed"; variant: "flushed" }
}
```

### 密码输入

```qml
CInput {
    type: "password"
    placeholderText: "请输入密码"
}
```

### 带清除按钮

```qml
CInput {
    placeholderText: "可清除"
    isClearable: true
}
```

### 错误状态

```qml
CInput {
    placeholderText: "邮箱"
    isInvalid: true
}
```

### 自定义元素

```qml
CInput {
    placeholderText: "搜索"
    leftElement: CIcon { name: "search"; size: 16; iconColor: AppStyle.textMuted }
}
```

## 注意事项

1. 密码输入框自带可见性切换按钮。
2. `flushed` 变体只显示底部边框，适合简洁风格。
3. 继承自 TextField，支持所有原生属性如 `text`、`placeholderText` 等。
