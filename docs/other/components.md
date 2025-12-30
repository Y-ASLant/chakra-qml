# QML 组件库文档

## 图标 CIcon
```qml
CIcon { name: "house"; size: 24; iconColor: "red" }
```
**属性:** `name` (图标名), `size`, `iconColor`
**图标列表:** https://phosphoricons.com/

---

## 按钮 CButton
```qml
CButton { text: "确定" }
CButton { text: "删除"; variant: "outline"; colorScheme: "red" }
CButton { text: "新建"; leftIcon: "plus" }
CButton { leftIcon: "gear"; iconOnly: true }
```
**属性:**
- `variant`: solid | outline | ghost | link
- `colorScheme`: blue | red | green | gray | primary | error...
- `size`: sm | md | lg
- `leftIcon` / `rightIcon`: 图标名
- `iconOnly`: 仅图标按钮
- `isLoading`: 加载状态

---

## 输入框 CInput
```qml
CInput { placeholderText: "请输入..." }
CInput { variant: "filled"; isInvalid: true }
```
**属性:** `variant` (outline | filled | flushed), `isInvalid`, `isDisabled`

---

## 复选框 CCheckbox
```qml
CCheckbox { text: "同意协议"; checked: true }
```
**属性:** `text`, `checked`, `colorScheme`

---

## 开关 CSwitch
```qml
CSwitch { checked: true; colorScheme: "green" }
```
**属性:** `checked`, `colorScheme`, `size`

---

## 下拉选择 CSelect
```qml
CSelect {
    model: ["选项1", "选项2", "选项3"]
    currentIndex: 0
}
```
**属性:** `model`, `currentIndex`, `placeholder`

---

## 分段控制 CSegmentedControl
```qml
CSegmentedControl {
    items: ["日", "周", "月"]
    currentIndex: 0
}
```
**属性:** `items`, `currentIndex`, `size`, `orientation` (horizontal | vertical), `disabled`, `disabledItems`

---

## 警告提示 CAlert
```qml
CAlert { status: "success"; title: "操作成功" }
CAlert { status: "error"; title: "错误"; description: "详细信息" }
```
**属性:** `status` (info | success | warning | error), `title`, `description`, `variant`, `closable`

---

## 徽章 CBadge
```qml
CBadge { text: "NEW"; colorScheme: "red" }
```
**属性:** `text`, `colorScheme`, `variant` (solid | subtle | outline)

---

## 标签 CTag
```qml
CTag { text: "标签"; closable: true; onClose: ... }
```
**属性:** `text`, `colorScheme`, `variant`, `closable`

---

## 进度条 CProgress
```qml
CProgress { value: 60; colorScheme: "green" }
CProgress { indeterminate: true }
```
**属性:** `value` (0-100), `colorScheme`, `indeterminate`, `size`

---

## 加载器 CSpinner
```qml
CSpinner { size: "md"; color: "blue" }
```
**属性:** `size` (xs | sm | md | lg | xl), `color`

---

## 弹窗 CDialog
```qml
CDialog {
    id: dialog
    title: "标题"
    // 内容...
    footer: Component { Row { CButton { text: "确定"; onClicked: dialog.close() } } }
}
// 打开: dialog.open()
```
**属性:** `title`, `size` (sm | md | lg | xl), `footer`

---

## 抽屉 CDrawer
```qml
CDrawer {
    id: drawer
    title: "标题"
    placement: "right"
    // 内容...
}
// 打开: drawer.open()
```
**属性:** `title`, `placement` (left | right | top | bottom), `size`, `edgeMargin`

---

## 提示框 CTooltip
```qml
CTooltip {
    text: "提示内容"
    CButton { text: "悬停显示" }
}
```
**属性:** `text`, `placement`

---

## 卡片 CCard
```qml
CCard {
    variant: "outline"
    // 内容...
}
```
**属性:** `variant` (elevated | outline | filled)

---

## 操作栏 CActionBar
```qml
CActionBar {
    open: selectedCount > 0
    selectionCount: selectedCount
    CButton { text: "删除" }
}
```
**属性:** `open`, `selectionCount`

---

## 布局组件

### CBox
```qml
CBox { padding: 16; /* 内容 */ }
```

### CFlex
```qml
CFlex { direction: "row"; gap: 8; /* 内容 */ }
```

### CCenter
```qml
CCenter { /* 居中内容 */ }
```

### CContainer
```qml
CContainer { maxWidth: 1200; /* 内容 */ }
```
