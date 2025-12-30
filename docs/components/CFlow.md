# CFlow 组件

流式布局组件，子元素自动换行排列。

## 示例

```qml
import Chakra

CFlow {
    spacing: 8
    width: 300

    CTag { text: "标签 1" }
    CTag { text: "标签 2" }
    CTag { text: "标签 3" }
    CTag { text: "标签 4" }
    CTag { text: "标签 5" }
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| direction | string | "row" | 排列方向，可选 "row" / "column" |
| justify | string | "start" | 主轴对齐，可选 "start" / "center" / "end" |
| spacing | int | 0 | 子元素间距 |
| padding | int | 0 | 内边距（四边） |
| paddingX | int | padding | 水平内边距 |
| paddingY | int | padding | 垂直内边距 |

## 示例代码

### 标签列表

```qml
CFlow {
    width: 300
    spacing: 8

    Repeater {
        model: ["Vue", "React", "Angular", "Svelte", "Solid", "Qwik"]
        delegate: CTag { text: modelData }
    }
}
```

### 居中对齐

```qml
CFlow {
    width: 300
    spacing: 8
    justify: "center"

    CButton { text: "A" }
    CButton { text: "B" }
    CButton { text: "C" }
}
```

### 垂直流式

```qml
CFlow {
    height: 200
    direction: "column"
    spacing: 8

    CTag { text: "1" }
    CTag { text: "2" }
    CTag { text: "3" }
    CTag { text: "4" }
}
```

## 注意事项

1. 基于 QML Flow 组件增强。
2. 水平方向时需要设置宽度，垂直方向时需要设置高度。
3. 适合用于标签列表、按钮组等需要自动换行的场景。
