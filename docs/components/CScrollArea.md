# CScrollArea 组件

可滚动容器组件，支持垂直和水平滚动。

## 示例

```qml
import Chakra

CScrollArea {
    width: 300
    height: 200

    Column {
        spacing: 10
        Repeater {
            model: 20
            delegate: Text { text: "项目 " + (index + 1) }
        }
    }
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| size | string | "md" | 滚动条尺寸，可选 "sm" / "md" / "lg" |
| horizontal | bool | false | 是否启用水平滚动 |
| vertical | bool | true | 是否启用垂直滚动 |
| flickable | alias | - | Flickable 实例（只读） |
| verticalScrollBar | alias | - | 垂直滚动条（只读） |
| horizontalScrollBar | alias | - | 水平滚动条（只读） |

## 示例代码

### 垂直滚动

```qml
CScrollArea {
    width: 300
    height: 200

    Column {
        spacing: 8
        Repeater {
            model: 50
            delegate: CButton { text: "按钮 " + (index + 1) }
        }
    }
}
```

### 水平滚动

```qml
CScrollArea {
    width: 300
    height: 60
    horizontal: true
    vertical: false

    Row {
        spacing: 8
        Repeater {
            model: 20
            delegate: CTag { text: "标签 " + (index + 1) }
        }
    }
}
```

### 双向滚动

```qml
CScrollArea {
    width: 300
    height: 200
    horizontal: true
    vertical: true

    Grid {
        columns: 10
        spacing: 8
        Repeater {
            model: 100
            delegate: Rectangle {
                width: 50
                height: 50
                color: AppStyle.primaryColor
            }
        }
    }
}
```

## 注意事项

1. 使用自定义 CScrollBar 组件，样式统一。
2. 内容超出容器时自动显示滚动条。
3. 滚动条在不活动时会变淡。
