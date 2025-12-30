# CBox 组件

盒子布局组件，提供灵活的内边距、外边距和样式控制。

## 示例

```qml
import Chakra

CBox {
    padding: 16
    backgroundColor: AppStyle.surfaceColor
    cornerRadius: 8

    Text { text: "内容" }
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| padding | int | 0 | 内边距（四边） |
| paddingX | int | padding | 水平内边距 |
| paddingY | int | padding | 垂直内边距 |
| paddingTop | int | paddingY | 上内边距 |
| paddingBottom | int | paddingY | 下内边距 |
| paddingLeft | int | paddingX | 左内边距 |
| paddingRight | int | paddingX | 右内边距 |
| margin | int | 0 | 外边距 |
| backgroundColor | color | transparent | 背景色 |
| borderWidth | int | 0 | 边框宽度 |
| borderColor | color | transparent | 边框颜色 |
| cornerRadius | int | 0 | 圆角半径 |

## 示例代码

### 基础用法

```qml
CBox {
    padding: 20
    backgroundColor: AppStyle.backgroundColor

    Column {
        spacing: 10
        Text { text: "标题"; font.bold: true }
        Text { text: "内容" }
    }
}
```

### 不同方向内边距

```qml
CBox {
    paddingX: 24
    paddingY: 16
    backgroundColor: AppStyle.surfaceColor

    Text { text: "水平内边距更大" }
}
```

### 带边框

```qml
CBox {
    padding: 16
    borderWidth: 1
    borderColor: AppStyle.borderColor
    cornerRadius: 8

    Text { text: "带边框的盒子" }
}
```

## 注意事项

1. 默认背景透明，需要手动设置 backgroundColor。
2. 子元素宽度会自动适应内容区域宽度。
3. 是最基础的布局组件，其他布局组件基于此构建。
