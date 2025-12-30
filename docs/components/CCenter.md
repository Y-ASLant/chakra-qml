# CCenter 组件

居中容器组件，子元素自动居中显示。

## 示例

```qml
import Chakra

CCenter {
    width: 200
    height: 200

    Text { text: "居中内容" }
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| content | alias | - | 内容区域（default 属性） |

## 示例代码

### 基础用法

```qml
CCenter {
    width: 300
    height: 200

    CSpinner { size: "lg" }
}
```

### 配合其他组件

```qml
Rectangle {
    width: 400
    height: 300
    color: AppStyle.backgroundColor

    CCenter {
        anchors.fill: parent

        Column {
            spacing: 16

            CIcon { name: "check-circle"; size: 48; iconColor: AppStyle.successColor }
            Text { text: "操作成功"; font.pixelSize: 18 }
        }
    }
}
```

## 注意事项

1. 需要设置 CCenter 的宽高，子元素才能正确居中。
2. 适合用于加载状态、空状态等需要居中显示的场景。
