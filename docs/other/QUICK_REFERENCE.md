# Chakra-QtQuick 组件快速参考

快速查阅所有组件的核心属性和用法。

## 目录

- [表单组件](#表单组件)
- [布局组件](#布局组件)
- [数据展示](#数据展示)
- [反馈组件](#反馈组件)
- [导航组件](#导航组件)
- [其他组件](#其他组件)

---

## 表单组件

### CButton

```qml
import chakra_ui_qml

CButton {
    text: "按钮"
    variant: "solid" | "outline" | "ghost" | "link"
    colorScheme: "primary" | "blue" | "green" | "red" | "gray" | "teal" | "pink" | "purple" | "cyan" | "orange" | "yellow" | "success" | "warning" | "error"
    size: "sm" | "md" | "lg"
    leftIcon: "icon-name"
    rightIcon: "icon-name"
    iconOnly: false
    isLoading: false
    fullWidth: false
    onClicked: { }
}
```

**常用示例**：
```qml
CButton { text: "主要按钮"; colorScheme: "blue" }
CButton { text: "删除"; colorScheme: "error"; variant: "outline" }
CButton { text: "加载中"; isLoading: true }
```

---

### CInput

```qml
import chakra_ui_qml

CInput {
    placeholderText: "占位符"
    text: ""
    variant: "outline" | "filled" | "flushed"
    type: "text" | "password"
    size: "sm" | "md" | "lg"
    isInvalid: false
    enabled: true
    onTextChanged: { }
}
```

**常用示例**：
```qml
CInput { placeholderText: "用户名"; width: 300 }
CInput { placeholderText: "密码"; type: "password" }
CInput { placeholderText: "错误"; isInvalid: true }
```

---

### CCheckbox

```qml
import chakra_ui_qml

CCheckbox {
    text: "标签文本"
    checked: false
    colorScheme: "primary"
    size: "sm" | "md" | "lg"
    enabled: true
    onCheckedChanged: { }
}
```

**常用示例**：
```qml
CCheckbox { text: "记住密码" }
CCheckbox { text: "接受条款"; checked: true }
```

---

### CSwitch

```qml
import chakra_ui_qml

CSwitch {
    text: "标签文本"
    checked: false
    colorScheme: "primary"
    size: "sm" | "md" | "lg"
    enabled: true
    onCheckedChanged: { }
}
```

**常用示例**：
```qml
CSwitch { text: "启用通知" }
CSwitch { text: "深色模式"; checked: AppStyle.isDark }
```

---

### CSelect

```qml
import chakra_ui_qml

CSelect {
    model: ["选项1", "选项2", "选项3"]
    currentIndex: -1
    currentText: ""
    placeholderText: "请选择"
    variant: "outline" | "filled" | "flushed"
    size: "sm" | "md" | "lg"
    isSearchable: false
    enabled: true
    onCurrentIndexChanged: { }
}
```

**常用示例**：
```qml
CSelect { model: ["中文", "English"]; width: 200 }
CSelect { model: cities; isSearchable: true }
```

---

## 布局组件

### CBox

```qml
import chakra_ui_qml

CBox {
    padding: 16
    paddingX: 16  // 水平内边距
    paddingY: 16  // 垂直内边距
    paddingTop: 0
    paddingBottom: 0
    paddingLeft: 0
    paddingRight: 0
    margin: 0
    backgroundColor: "transparent"
    borderWidth: 0
    borderColor: AppStyle.borderColor
    cornerRadius: 0
}
```

---

### CFlex

```qml
import chakra_ui_qml

CFlex {
    direction: "row" | "column"
    justify: "start" | "center" | "end" | "space-between" | "space-around"
    align: "start" | "center" | "end" | "stretch"
    spacing: 12
    wrap: false
}
```

**常用示例**：
```qml
CFlex {
    direction: "row"
    justify: "space-between"
    align: "center"
    CButton { text: "左" }
    CButton { text: "右" }
}
```

---

### CContainer

```qml
import chakra_ui_qml

CContainer {
    size: "sm" | "md" | "lg" | "xl" | "full"
    centerContent: true
}
```

---

### CCenter

```qml
import chakra_ui_qml

CCenter {
    // 自动居中子元素
}
```

---

## 数据展示

### CCard

```qml
import chakra_ui_qml

CCard {
    title: "标题"
    description: "描述"
    variant: "elevated" | "outline" | "filled" | "subtle"
    size: "sm" | "md" | "lg"
    spacing: 12
    autoPadding: true
}
```

**常用示例**：
```qml
CCard {
    width: 400
    title: "用户信息"
    description: "个人资料设置"
    
    CInput { placeholderText: "姓名" }
    CButton { text: "保存" }
}
```

---

### CBadge

```qml
import chakra_ui_qml

CBadge {
    text: "标签"
    variant: "solid" | "subtle" | "outline"
    colorScheme: "primary"
    size: "sm" | "md" | "lg"
}
```

**常用示例**：
```qml
CBadge { text: "新"; colorScheme: "blue" }
CBadge { text: "99+"; colorScheme: "error" }
```

---

### CTag

```qml
import chakra_ui_qml

CTag {
    text: "标签"
    variant: "solid" | "subtle" | "outline"
    colorScheme: "primary"
    size: "sm" | "md" | "lg"
    isClosable: false
    onClosed: { }
}
```

**常用示例**：
```qml
CTag { text: "React"; colorScheme: "blue" }
CTag { text: "Vue"; colorScheme: "green"; isClosable: true }
```

---

### CProgress

```qml
import chakra_ui_qml

CProgress {
    value: 0  // 0-100
    colorScheme: "primary"
    size: "xs" | "sm" | "md" | "lg"
    hasStripe: false
    isAnimated: false
    animationEnabled: true  // 性能优化开关
    isIndeterminate: false
}
```

**常用示例**：
```qml
CProgress { value: 75; width: 400 }
CProgress { value: 60; hasStripe: true; isAnimated: true }
CProgress { isIndeterminate: true }  // 不确定进度
```

---

### CSpinner

```qml
import chakra_ui_qml

CSpinner {
    colorScheme: "primary"
    size: "xs" | "sm" | "md" | "lg" | "xl"
}
```

**常用示例**：
```qml
CSpinner { size: "md" }
CSpinner { size: "lg"; colorScheme: "blue" }
```

---

## 反馈组件

### CAlert

```qml
import chakra_ui_qml

CAlert {
    status: "info" | "success" | "warning" | "error"
    title: "标题"
    description: "描述"
    variant: "subtle" | "solid" | "left-accent" | "top-accent"
    isClosable: false
    onClosed: { }
}
```

**常用示例**：
```qml
CAlert {
    status: "success"
    title: "成功"
    description: "操作已完成"
}
```

---

### CDialog

```qml
import chakra_ui_qml

CDialog {
    title: "对话框标题"
    size: "xs" | "sm" | "md" | "lg" | "xl" | "full"
    closeOnClickOutside: true
    
    function open() { }
    function close() { }
}
```

**常用示例**：
```qml
CDialog {
    id: confirmDialog
    title: "确认操作"
    size: "sm"
    
    Column {
        spacing: 16
        Text { text: "确定删除吗？" }
        CButton {
            text: "确定"
            onClicked: confirmDialog.close()
        }
    }
}

// 打开对话框
CButton {
    text: "打开"
    onClicked: confirmDialog.open()
}
```

---

### CDrawer

```qml
import chakra_ui_qml

CDrawer {
    title: "抽屉标题"
    placement: "left" | "right" | "top" | "bottom"
    size: "xs" | "sm" | "md" | "lg" | "xl" | "full"
    closeOnClickOutside: true
    
    function open() { }
    function close() { }
}
```

---

### CTooltip

```qml
import chakra_ui_qml

CTooltip {
    text: "提示文本"
    placement: "top" | "bottom" | "left" | "right"
}
```

**常用示例**：
```qml
CButton {
    text: "悬停"
    CTooltip {
        text: "这是提示"
        visible: parent.hovered
    }
}
```

---

### CMenu

```qml
import chakra_ui_qml

CMenu {
    CMenuItem {
        text: "菜单项"
        menuIcon: "icon-name"
        command: "Ctrl+N"
        onClicked: { }
    }
    
    CMenuSeparator { }
    
    CMenuGroup {
        title: "分组"
    }
}
```

---

## 导航组件

### CPagination

```qml
import chakra_ui_qml

CPagination {
    currentPage: 1
    totalPages: 10
    size: "md"
    variant: "outline"
    colorScheme: "primary"
    isCompact: false
    showsFirstLast: true
    maxVisiblePages: 7
    onCurrentPageChanged: { }
}
```

**常用示例**：
```qml
CPagination {
    currentPage: page
    totalPages: 20
    onCurrentPageChanged: loadPage(currentPage)
}
```

---

### CSegmentedControl

```qml
import chakra_ui_qml

CSegmentedControl {
    model: ["选项1", "选项2", "选项3"]
    currentIndex: 0
    size: "xs" | "sm" | "md" | "lg"
    isDisabled: false
    onCurrentIndexChanged: { }
}
```

**常用示例**：
```qml
CSegmentedControl {
    model: ["日", "周", "月"]
    currentIndex: 0
    onCurrentIndexChanged: updateView(currentIndex)
}
```

---

## 其他组件

### CWindow

```qml
import chakra_ui_qml

CWindow {
    width: 1280
    height: 800
    title: "窗口标题"
    showTitleBar: true
    showThemeToggle: true
    showMinimize: true
    showMaximize: true
    showClose: true
    shadowEnabled: true  // Windows DWM 原生阴影
}
```

---

### CScrollArea

```qml
import chakra_ui_qml

CScrollArea {
    width: 400
    height: 300
    horizontal: false  // 水平滚动
    vertical: true     // 垂直滚动
    
    // 内容
}
```

---

### CIcon

```qml
import chakra_ui_qml

CIcon {
    name: "check" | "close" | "arrow-right" | ...
    size: 24
    color: AppStyle.textColor
}
```

**常用示例**：
```qml
CIcon { name: "check"; size: 24; color: "green" }
```

---

### CActionBar

```qml
import chakra_ui_qml

CActionBar {
    placement: "top" | "bottom" | "left" | "right"
    spacing: 8
    
    // 操作按钮
}
```

---

## 主题系统

### AppStyle (Singleton)

```qml
// 切换主题
AppStyle.toggleTheme()

// 检查当前主题
if (AppStyle.isDark) { }

// 颜色
AppStyle.primaryColor
AppStyle.backgroundColor
AppStyle.textColor
AppStyle.borderColor

// 间距
AppStyle.spacing1  // 4px
AppStyle.spacing2  // 8px
AppStyle.spacing3  // 12px
AppStyle.spacing4  // 16px
AppStyle.spacing6  // 24px

// 圆角
AppStyle.radiusSm  // 4px
AppStyle.radiusMd  // 6px
AppStyle.radiusLg  // 8px

// 字体大小
AppStyle.fontSizeXs  // 12px
AppStyle.fontSizeSm  // 14px
AppStyle.fontSizeMd  // 16px
AppStyle.fontSizeLg  // 18px
```

---

## 导入方式

### QML 中导入

```qml
import QtQuick
import chakra_ui_qml

// 使用组件
CButton { text: "按钮" }
```

### Python 中初始化

```python
from PySide6.QtQml import QQmlApplicationEngine
from chakra_ui import init

engine = QQmlApplicationEngine()
init(engine)  # 注册组件
engine.load("main.qml")
```

---

## 常用模式

### 表单布局

```qml
CCard {
    width: 400
    title: "登录"
    spacing: 16
    
    CInput {
        placeholderText: "用户名"
        width: parent.width
    }
    
    CInput {
        placeholderText: "密码"
        type: "password"
        width: parent.width
    }
    
    CCheckbox {
        text: "记住密码"
    }
    
    CButton {
        text: "登录"
        colorScheme: "blue"
        width: parent.width
    }
}
```

### 响应式布局

```qml
CFlex {
    width: parent.width
    direction: width < 600 ? "column" : "row"
    justify: "space-between"
    spacing: 16
    
    CCard { flex: 1; title: "卡片1" }
    CCard { flex: 1; title: "卡片2" }
    CCard { flex: 1; title: "卡片3" }
}
```

### 加载状态

```qml
Column {
    spacing: 16
    
    CButton {
        text: "加载数据"
        isLoading: isLoading
        onClicked: loadData()
    }
    
    CProgress {
        width: 400
        value: progress
        isIndeterminate: isLoading
    }
}
```

---

## 性能优化技巧

1. **禁用不必要的动画**
```qml
CProgress {
    value: 75
    hasStripe: true
    isAnimated: true
    animationEnabled: !lowPerformanceMode  // 低性能模式下禁用
}
```

2. **使用 Loader 延迟加载**
```qml
Loader {
    active: visible
    sourceComponent: CCard {
        // 复杂内容
    }
}
```

3. **复用组件**
```qml
Repeater {
    model: 100
    delegate: CButton {
        text: "按钮 " + (index + 1)
    }
}
```

---

## 完整示例

```qml
import QtQuick
import QtQuick.Window
import chakra_ui_qml

CWindow {
    visible: true
    width: 1280
    height: 800
    title: "Chakra-QtQuick Demo"
    
    CContainer {
        size: "lg"
        
        Column {
            width: parent.width
            spacing: AppStyle.spacing6
            
            Text {
                text: "欢迎使用 Chakra-QtQuick"
                font.pixelSize: AppStyle.fontSize2xl
                font.weight: Font.Bold
                color: AppStyle.textColor
            }
            
            CFlex {
                width: parent.width
                spacing: 16
                
                CCard {
                    width: 300
                    title: "表单示例"
                    spacing: 12
                    
                    CInput { placeholderText: "用户名" }
                    CInput { placeholderText: "密码"; type: "password" }
                    CButton { text: "登录"; colorScheme: "blue" }
                }
                
                CCard {
                    width: 300
                    title: "数据展示"
                    spacing: 12
                    
                    CProgress { value: 75; width: parent.width - 32 }
                    CBadge { text: "新"; colorScheme: "green" }
                    CTag { text: "标签"; isClosable: true }
                }
            }
        }
    }
}
```
