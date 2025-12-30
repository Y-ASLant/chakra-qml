# CGridView 组件

虚拟化网格视图组件，适合显示大量网格数据。

## 示例

```qml
import Chakra

CGridView {
    width: 400
    height: 300
    cellWidth: 100
    cellHeight: 100
    model: 100
    delegate: Rectangle {
        width: 90
        height: 90
        color: AppStyle.primaryColor
        radius: 8
    }
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| scrollBarSize | string | "md" | 滚动条尺寸，可选 "sm" / "md" / "lg" |

继承 GridView 的所有属性：model, delegate, cellWidth, cellHeight, flow 等。

## 示例代码

### 图片网格

```qml
CGridView {
    width: 400
    height: 300
    cellWidth: 110
    cellHeight: 110
    model: imageModel
    delegate: Image {
        width: 100
        height: 100
        source: modelData.url
        fillMode: Image.PreserveAspectCrop
    }
}
```

### 卡片网格

```qml
CGridView {
    width: 600
    height: 400
    cellWidth: 200
    cellHeight: 150
    model: 20
    delegate: CCard {
        width: 190
        height: 140
        title: "卡片 " + (index + 1)
        description: "这是卡片描述"
    }
}
```

### 垂直流动

```qml
CGridView {
    width: 300
    height: 400
    cellWidth: 100
    cellHeight: 100
    flow: GridView.FlowTopToBottom
    model: 50
    delegate: Rectangle {
        width: 90
        height: 90
        color: Qt.hsla(index / 50, 0.7, 0.5, 1)
        radius: 8
    }
}
```

## 注意事项

1. 使用虚拟化技术，只渲染可见项，性能优秀。
2. cellWidth 和 cellHeight 定义网格单元大小，delegate 实际尺寸可以小于单元格。
3. 自带 CScrollBar 滚动条。
