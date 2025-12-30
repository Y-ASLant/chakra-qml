# CContainer 组件

容器组件，提供响应式最大宽度和居中布局。

## 示例

```qml
import Chakra

CContainer {
    size: "lg"

    Column {
        spacing: 20
        Text { text: "页面内容" }
    }
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| size | string | "lg" | 最大宽度尺寸，可选 "sm" / "md" / "lg" / "xl" / "full" |
| maxWidth | int | - | 最大宽度（根据 size 自动计算） |
| centerContent | bool | true | 是否居中内容 |
| paddingX | int | AppStyle.spacing4 | 水平内边距 |

## 示例代码

### 不同尺寸

```qml
Column {
    spacing: 20
    width: parent.width

    CContainer {
        size: "sm"
        Rectangle { height: 50; color: AppStyle.primaryColor }
    }

    CContainer {
        size: "md"
        Rectangle { height: 50; color: AppStyle.successColor }
    }

    CContainer {
        size: "lg"
        Rectangle { height: 50; color: AppStyle.warningColor }
    }
}
```

### 全宽

```qml
CContainer {
    size: "full"

    Text { text: "全宽容器" }
}
```

### 左对齐

```qml
CContainer {
    centerContent: false

    Text { text: "左对齐内容" }
}
```

## 注意事项

1. 常用于页面布局，限制内容最大宽度。
2. 宽度会自动适应父容器，但不超过 maxWidth。
3. 默认有水平内边距，避免内容贴边。
