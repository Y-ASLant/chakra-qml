# CSpacer 组件

间距组件，用于在布局中添加固定或弹性间距。

## 示例

```qml
import Chakra

Row {
    CButton { text: "左侧" }
    CSpacer { fill: true }
    CButton { text: "右侧" }
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| size | int | AppStyle.spacing4 | 间距大小 |
| horizontal | bool | false | 是否水平方向 |
| fill | bool | false | 是否填充剩余空间 |
| minSize | int | 0 | 最小尺寸 |
| maxSize | int | -1 | 最大尺寸（-1 表示无限制） |

## 示例代码

### 固定间距

```qml
Column {
    Text { text: "上方" }
    CSpacer { size: 20 }
    Text { text: "下方" }
}
```

### 水平间距

```qml
Row {
    Text { text: "左" }
    CSpacer { horizontal: true; size: 20 }
    Text { text: "右" }
}
```

### 弹性填充

```qml
Row {
    width: 400

    CButton { text: "Logo" }
    CSpacer { horizontal: true; fill: true }
    CButton { text: "登录" }
    CSpacer { horizontal: true; size: 10 }
    CButton { text: "注册" }
}
```

### 带约束的弹性填充

```qml
Row {
    CSpacer { horizontal: true; fill: true; minSize: 10; maxSize: 100 }
    Text { text: "居中内容" }
    CSpacer { horizontal: true; fill: true; minSize: 10; maxSize: 100 }
}
```

## 注意事项

1. 默认为垂直方向，设置 `horizontal: true` 改为水平方向。
2. `fill: true` 时会填充剩余空间，常用于两端对齐布局。
3. 配合 Layout 属性使用效果更好。
