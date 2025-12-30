# CFlex 组件

弹性布局组件，类似 CSS Flexbox。

## 示例

```qml
import Chakra

CFlex {
    direction: "row"
    justify: "between"
    align: "center"
    gap: 10

    CButton { text: "按钮 1" }
    CButton { text: "按钮 2" }
    CButton { text: "按钮 3" }
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| direction | string | "row" | 排列方向，可选 "row" / "column" |
| wrap | bool | false | 是否换行 |
| justify | string | "start" | 主轴对齐，可选 "start" / "center" / "end" / "between" / "around" |
| align | string | "stretch" | 交叉轴对齐，可选 "start" / "center" / "end" / "stretch" |
| gap | int | 0 | 子元素间距 |
| padding | int | 0 | 内边距（四边） |
| paddingX | int | padding | 水平内边距 |
| paddingY | int | padding | 垂直内边距 |

## 示例代码

### 水平布局

```qml
CFlex {
    direction: "row"
    gap: 10

    CButton { text: "A" }
    CButton { text: "B" }
    CButton { text: "C" }
}
```

### 垂直布局

```qml
CFlex {
    direction: "column"
    gap: 10

    CButton { text: "A" }
    CButton { text: "B" }
    CButton { text: "C" }
}
```

### 两端对齐

```qml
CFlex {
    width: 400
    justify: "between"

    Text { text: "左侧" }
    Text { text: "右侧" }
}
```

### 居中对齐

```qml
CFlex {
    width: 400
    height: 100
    justify: "center"
    align: "center"

    CSpinner {}
}
```

## 注意事项

1. 基于 GridLayout 实现，支持大部分 Flexbox 特性。
2. `justify: "between"` 和 `"around"` 会动态计算间距。
3. `align: "stretch"` 会使子元素填充交叉轴方向。
