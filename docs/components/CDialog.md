# CDialog 组件

对话框组件，支持多种尺寸、图标和自定义底部按钮。

## 示例

```qml
import Chakra

CDialog {
    id: dialog
    title: "确认"
    description: "确定要执行此操作吗？"

    footer: Row {
        spacing: 10
        CButton { text: "取消"; variant: "outline"; onClicked: dialog.close() }
        CButton { text: "确定"; onClicked: dialog.close() }
    }
}

CButton {
    text: "打开对话框"
    onClicked: dialog.open()
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| size | string | "md" | 尺寸，可选 "xs" / "sm" / "md" / "lg" / "xl" / "full" |
| icon | string | "" | 图标名称 |
| title | string | "" | 标题文本 |
| description | string | "" | 描述文本 |
| showCloseButton | bool | true | 是否显示关闭按钮 |
| closeOnOverlayClick | bool | true | 是否点击遮罩关闭 |
| closeOnEsc | bool | true | 是否按 ESC 关闭 |
| content | alias | - | 内容区域（default 属性） |
| footer | Component | null | 底部按钮区 |

## 信号

| 信号名 | 描述 |
|--------|------|
| dialogOpened | 对话框打开时触发 |
| dialogClosed | 对话框关闭时触发 |

## 示例代码

### 带图标

```qml
CDialog {
    icon: "warning"
    title: "警告"
    description: "此操作不可撤销"
}
```

### 不同尺寸

```qml
CDialog {
    size: "lg"
    title: "大型对话框"

    Column {
        spacing: 10
        Text { text: "这是一个大型对话框，可以容纳更多内容。" }
        CInput { placeholderText: "输入内容" }
    }
}
```

### 禁止点击遮罩关闭

```qml
CDialog {
    title: "重要操作"
    closeOnOverlayClick: false
    closeOnEsc: false
    showCloseButton: false

    footer: CButton { text: "我知道了"; onClicked: close() }
}
```

## 注意事项

1. 对话框会自动居中显示在父容器中。
2. 需要将 CDialog 放在 CWindow 的 overlay 属性中以正确显示遮罩。
3. 有进入和退出动画效果。
