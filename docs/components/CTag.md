# CTag 组件

标签组件，用于分类、标记等场景，支持关闭功能。

## 示例

```qml
import Chakra

CTag {
    text: "标签"
    colorScheme: "primary"
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| colorScheme | string | "primary" | 颜色方案 |
| variant | string | "subtle" | 变体，可选 "solid" / "subtle" / "outline" |
| size | string | "md" | 尺寸，可选 "sm" / "md" / "lg" |
| text | string | "" | 标签文本 |
| isClosable | bool | false | 是否可关闭 |

## 信号

| 信号名 | 描述 |
|--------|------|
| closed | 关闭时触发 |

## 示例代码

### 基础用法

```qml
Row {
    spacing: 8

    CTag { text: "Vue" }
    CTag { text: "React" }
    CTag { text: "Angular" }
}
```

### 可关闭标签

```qml
Row {
    spacing: 8

    CTag { text: "标签 1"; isClosable: true; onClosed: destroy() }
    CTag { text: "标签 2"; isClosable: true; onClosed: destroy() }
}
```

### 不同颜色

```qml
Row {
    spacing: 8

    CTag { text: "Primary"; colorScheme: "primary" }
    CTag { text: "Success"; colorScheme: "success" }
    CTag { text: "Warning"; colorScheme: "warning" }
    CTag { text: "Error"; colorScheme: "error" }
}
```

## 注意事项

1. 标签为圆角胶囊形状。
2. 关闭按钮有悬停和点击动画效果。
3. 与 CBadge 的区别：CTag 更适合可交互的标签场景。
