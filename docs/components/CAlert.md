# CAlert 组件

警告提示组件，支持多种状态和变体样式。

## 示例

```qml
import Chakra

CAlert {
    status: "success"
    title: "操作成功"
    description: "您的更改已保存"
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| status | string | "info" | 状态，可选 "info" / "success" / "warning" / "error" |
| variant | string | "subtle" | 变体，可选 "subtle" / "solid" / "left-accent" / "top-accent" |
| title | string | "" | 标题文本 |
| description | string | "" | 描述文本 |
| isClosable | bool | false | 是否可关闭 |

## 信号

| 信号名 | 描述 |
|--------|------|
| closed | 关闭时触发 |

## 示例代码

### 不同状态

```qml
Column {
    spacing: 10

    CAlert { status: "info"; title: "提示"; description: "这是一条提示信息" }
    CAlert { status: "success"; title: "成功"; description: "操作已完成" }
    CAlert { status: "warning"; title: "警告"; description: "请注意此操作" }
    CAlert { status: "error"; title: "错误"; description: "操作失败" }
}
```

### 不同变体

```qml
Column {
    spacing: 10

    CAlert { status: "info"; variant: "subtle"; title: "Subtle" }
    CAlert { status: "info"; variant: "solid"; title: "Solid" }
    CAlert { status: "info"; variant: "left-accent"; title: "Left Accent" }
    CAlert { status: "info"; variant: "top-accent"; title: "Top Accent" }
}
```

### 可关闭

```qml
CAlert {
    status: "success"
    title: "提示"
    description: "点击右侧按钮关闭"
    isClosable: true
    onClosed: console.log("Alert closed")
}
```

## 注意事项

1. 每种状态有对应的图标自动显示。
2. `solid` 变体使用纯色背景，文字为白色。
3. `left-accent` 和 `top-accent` 变体在对应边显示强调条。
