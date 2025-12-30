# CDrawer 组件

抽屉组件，支持四个方向滑出，可自定义标题和底部内容。

## 示例

```qml
import Chakra

CDrawer {
    id: drawer
    title: "设置"
    placement: "right"

    Column {
        spacing: 10
        CSwitch { text: "通知" }
        CSwitch { text: "深色模式" }
    }
}

CButton {
    text: "打开抽屉"
    onClicked: drawer.open()
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| placement | string | "right" | 方向，可选 "left" / "right" / "top" / "bottom" |
| size | int | 320 | 抽屉宽度/高度 |
| edgeMargin | int | 0 | 边距偏移（用于无边框窗口） |
| title | string | "" | 标题文本 |
| showCloseButton | bool | true | 是否显示关闭按钮 |
| closeOnOverlayClick | bool | true | 是否点击遮罩关闭 |
| closeOnEsc | bool | true | 是否按 ESC 关闭 |
| content | alias | - | 内容区域（default 属性） |
| footer | Component | null | 底部内容 |

## 信号

| 信号名 | 描述 |
|--------|------|
| drawerOpened | 抽屉打开时触发 |
| drawerClosed | 抽屉关闭时触发 |

## 示例代码

### 不同方向

```qml
Row {
    spacing: 10

    CButton { text: "左侧"; onClicked: leftDrawer.open() }
    CButton { text: "右侧"; onClicked: rightDrawer.open() }
    CButton { text: "顶部"; onClicked: topDrawer.open() }
    CButton { text: "底部"; onClicked: bottomDrawer.open() }
}

CDrawer { id: leftDrawer; placement: "left"; title: "左侧抽屉" }
CDrawer { id: rightDrawer; placement: "right"; title: "右侧抽屉" }
CDrawer { id: topDrawer; placement: "top"; title: "顶部抽屉"; size: 200 }
CDrawer { id: bottomDrawer; placement: "bottom"; title: "底部抽屉"; size: 200 }
```

### 带底部按钮

```qml
CDrawer {
    title: "筛选"

    Column {
        spacing: 10
        CCheckbox { text: "选项 A" }
        CCheckbox { text: "选项 B" }
    }

    footer: Row {
        padding: 16
        spacing: 10
        CButton { text: "重置"; variant: "outline" }
        CButton { text: "应用" }
    }
}
```

### 无边框窗口适配

```qml
CDrawer {
    placement: "right"
    edgeMargin: 8  // 留出窗口圆角空间
    title: "设置"
}
```

## 注意事项

1. 需要将 CDrawer 放在 CWindow 的 overlay 属性中以正确显示遮罩。
2. `edgeMargin` 用于无边框窗口，避免抽屉遮挡窗口圆角。
3. 内容区域可滚动，带有自定义滚动条。
