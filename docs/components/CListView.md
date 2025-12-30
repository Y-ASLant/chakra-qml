# CListView 组件

虚拟化列表视图组件，适合显示大量数据。

## 示例

```qml
import Chakra

CListView {
    width: 300
    height: 400
    model: 1000
    delegate: Text {
        text: "项目 " + index
        height: 40
    }
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| scrollBarSize | string | "md" | 滚动条尺寸，可选 "sm" / "md" / "lg" |

继承 ListView 的所有属性：model, delegate, spacing, orientation 等。

## 示例代码

### 基础用法

```qml
CListView {
    width: 300
    height: 400
    model: ListModel {
        ListElement { name: "苹果"; price: 5 }
        ListElement { name: "香蕉"; price: 3 }
        ListElement { name: "橙子"; price: 4 }
    }
    delegate: Row {
        width: parent.width
        height: 40
        spacing: 10
        Text { text: name }
        Text { text: "¥" + price }
    }
}
```

### 带间距

```qml
CListView {
    width: 300
    height: 400
    spacing: 8
    model: 100
    delegate: CCard {
        width: parent.width
        height: 60
        title: "卡片 " + (index + 1)
    }
}
```

### 水平列表

```qml
CListView {
    width: 400
    height: 100
    orientation: ListView.Horizontal
    spacing: 10
    model: 50
    delegate: Rectangle {
        width: 80
        height: 80
        color: AppStyle.primaryColor
        radius: 8
    }
}
```

## 注意事项

1. 使用虚拟化技术，只渲染可见项，性能优秀。
2. 自带 CScrollBar 滚动条。
3. 继承自 ListView，支持所有原生属性和方法。
