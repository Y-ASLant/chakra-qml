# Chakra UI QML 组件 API 文档

本文档提供所有组件的属性说明和使用示例。

## 目录

### 表单组件
- [CButton - 按钮](#cbutton)
- [CInput - 输入框](#cinput)
- [CCheckbox - 复选框](#ccheckbox)
- [CSwitch - 开关](#cswitch)
- [CSelect - 选择器](#cselect)

### 数据展示
- [CCard - 卡片](#ccard)
- [CBadge - 徽章](#cbadge)
- [CTag - 标签](#ctag)
- [CProgress - 进度条](#cprogress)
- [CSpinner - 加载指示器](#cspinner)

### 布局组件
- [CBox - 盒子](#cbox)
- [CFlex - 弹性布局](#cflex)
- [CContainer - 容器](#ccontainer)
- [CCenter - 居中容器](#ccenter)

### 反馈组件
- [CDialog - 对话框](#cdialog)
- [CDrawer - 抽屉](#cdrawer)
- [CMenu - 菜单](#cmenu)
- [CAlert - 警告提示](#calert)
- [CTooltip - 工具提示](#ctooltip)

### 导航组件
- [CSegmentedControl - 分段控制器](#csegmentedcontrol)
- [CPagination - 分页器](#cpagination)

### 其他组件
- [CScrollArea - 滚动区域](#cscrollarea)
- [CIcon - 图标](#cicon)

---

## 表单组件

### CButton

按钮组件，支持多种变体和颜色方案。

#### 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `variant` | string | "solid" | 按钮变体：solid, outline, ghost, link |
| `colorScheme` | string | "gray" | 颜色方案：gray, red, green, blue, teal, pink, purple, cyan, orange, yellow, primary, secondary, success, warning, error |
| `size` | string | "md" | 尺寸：xs, sm, md, lg, xl |
| `text` | string | "" | 按钮文本 |
| `enabled` | bool | true | 是否启用 |
| `isLoading` | bool | false | 加载状态 |

#### 示例

```qml
import QtQuick
import "../src/components"

Column {
    spacing: 12
    
    // 基础按钮
    CButton {
        text: "默认按钮"
    }
    
    // 主要按钮
    CButton {
        text: "主要按钮"
        variant: "solid"
        colorScheme: "blue"
    }
    
    // 危险按钮
    CButton {
        text: "删除"
        variant: "solid"
        colorScheme: "error"
    }
    
    // 边框按钮
    CButton {
        text: "边框按钮"
        variant: "outline"
    }
    
    // 加载状态
    CButton {
        text: "加载中"
        isLoading: true
    }
    
    // 禁用状态
    CButton {
        text: "禁用按钮"
        enabled: false
    }
}
```

---

### CInput

文本输入框组件。

#### 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `variant` | string | "outline" | 变体：outline, filled, flushed |
| `inputType` | string | "text" | 输入类型：text, password |
| `size` | string | "md" | 尺寸：sm, md, lg |
| `placeholderText` | string | "" | 占位符文本 |
| `text` | string | "" | 输入文本 |
| `enabled` | bool | true | 是否启用 |
| `isInvalid` | bool | false | 是否显示错误状态 |

#### 示例

```qml
import QtQuick
import "../src/components"

Column {
    spacing: 12
    
    // 基础输入框
    CInput {
        width: 300
        placeholderText: "请输入文本..."
    }
    
    // 密码输入框
    CInput {
        width: 300
        placeholderText: "请输入密码"
        inputType: "password"
    }
    
    // 错误状态
    CInput {
        width: 300
        placeholderText: "错误状态"
        isInvalid: true
    }
    
    // 禁用状态
    CInput {
        width: 300
        placeholderText: "禁用状态"
        enabled: false
    }
    
    // Filled 变体
    CInput {
        width: 300
        placeholderText: "Filled 样式"
        variant: "filled"
    }
}
```

---

### CCheckbox

复选框组件。

#### 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `text` | string | "" | 标签文本 |
| `checked` | bool | false | 是否选中 |
| `colorScheme` | string | "primary" | 颜色方案 |
| `size` | string | "md" | 尺寸：sm, md, lg |
| `enabled` | bool | true | 是否启用 |

#### 示例

```qml
import QtQuick
import "../src/components"

Column {
    spacing: 12
    
    // 基础复选框
    CCheckbox {
        text: "接受条款"
    }
    
    // 默认选中
    CCheckbox {
        text: "记住密码"
        checked: true
    }
    
    // 禁用状态
    CCheckbox {
        text: "禁用选项"
        enabled: false
    }
    
    // 不同颜色
    CCheckbox {
        text: "蓝色主题"
        colorScheme: "blue"
        checked: true
    }
}
```

---

### CSwitch

开关组件。

#### 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `text` | string | "" | 标签文本 |
| `checked` | bool | false | 是否开启 |
| `colorScheme` | string | "primary" | 颜色方案 |
| `size` | string | "md" | 尺寸：sm, md, lg |
| `enabled` | bool | true | 是否启用 |

#### 示例

```qml
import QtQuick
import "../src/components"

Column {
    spacing: 12
    
    // 基础开关
    CSwitch {
        text: "启用通知"
    }
    
    // 默认开启
    CSwitch {
        text: "自动保存"
        checked: true
    }
    
    // 禁用状态
    CSwitch {
        text: "禁用选项"
        enabled: false
    }
}
```

---

### CSelect

下拉选择器组件。

#### 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `model` | var | [] | 选项列表 |
| `currentIndex` | int | -1 | 当前选中索引 |
| `currentText` | string | "" | 当前选中文本 |
| `placeholderText` | string | "请选择" | 占位符 |
| `size` | string | "md" | 尺寸：sm, md, lg |
| `enabled` | bool | true | 是否启用 |
| `searchable` | bool | false | 是否支持搜索 |

#### 示例

```qml
import QtQuick
import "../src/components"

Column {
    spacing: 12
    
    // 基础选择器
    CSelect {
        width: 300
        model: ["选项1", "选项2", "选项3"]
        placeholderText: "请选择一项"
    }
    
    // 可搜索选择器
    CSelect {
        width: 300
        model: ["北京", "上海", "广州", "深圳"]
        searchable: true
    }
    
    // 默认选中
    CSelect {
        width: 300
        model: ["中文", "English", "日本語"]
        currentIndex: 0
    }
}
```

---

## 数据展示

### CCard

卡片容器组件，用于展示内容。

#### 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `variant` | string | "elevated" | 变体：elevated, outline, filled, subtle |
| `size` | string | "md" | 尺寸：sm, md, lg |
| `title` | string | "" | 标题 |
| `description` | string | "" | 描述文本 |
| `autoPadding` | bool | true | 自动应用内边距 |
| `padding` | int | - | 自定义内边距（自动根据 size 计算） |
| `spacing` | int | 0 | 内容间距 |
| `header` | Component | null | 头部组件 |
| `footer` | Component | null | 底部组件 |

#### 示例

```qml
import QtQuick
import "../src/components"

Column {
    spacing: 16
    
    // 基础卡片
    CCard {
        width: 400
        title: "卡片标题"
        description: "这是卡片的描述文本"
    }
    
    // 包含内容的卡片
    CCard {
        width: 400
        title: "用户设置"
        spacing: 12
        
        CCheckbox {
            text: "接收邮件通知"
        }
        
        CSwitch {
            text: "启用双因素认证"
        }
    }
    
    // 自定义内边距
    CCard {
        width: 400
        title: "紧凑卡片"
        size: "sm"
        
        Text {
            text: "这是一个紧凑的卡片"
            color: AppStyle.textColor
        }
    }
    
    // Outline 变体
    CCard {
        width: 400
        variant: "outline"
        title: "边框卡片"
        
        Text {
            text: "使用边框样式"
            color: AppStyle.textColor
        }
    }
}
```

---

### CBadge

徽章组件，用于显示状态或计数。

#### 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `text` | string | "" | 徽章文本 |
| `variant` | string | "solid" | 变体：solid, subtle, outline |
| `colorScheme` | string | "gray" | 颜色方案 |
| `size` | string | "md" | 尺寸：sm, md, lg |

#### 示例

```qml
import QtQuick
import "../src/components"

Row {
    spacing: 12
    
    CBadge {
        text: "新"
        colorScheme: "blue"
    }
    
    CBadge {
        text: "99+"
        colorScheme: "error"
    }
    
    CBadge {
        text: "Beta"
        variant: "outline"
        colorScheme: "purple"
    }
}
```

---

### CTag

标签组件。

#### 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `text` | string | "" | 标签文本 |
| `variant` | string | "subtle" | 变体：solid, subtle, outline |
| `colorScheme` | string | "gray" | 颜色方案 |
| `size` | string | "md" | 尺寸：sm, md, lg |
| `closable` | bool | false | 是否可关闭 |

#### 示例

```qml
import QtQuick
import "../src/components"

Row {
    spacing: 8
    
    CTag {
        text: "React"
        colorScheme: "blue"
    }
    
    CTag {
        text: "Vue"
        colorScheme: "green"
        closable: true
    }
    
    CTag {
        text: "Angular"
        variant: "outline"
        colorScheme: "red"
    }
}
```

---

### CProgress

进度条组件。

#### 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `value` | real | 0 | 进度值（0-1） |
| `colorScheme` | string | "blue" | 颜色方案 |
| `size` | string | "md" | 尺寸：xs, sm, md, lg |
| `isIndeterminate` | bool | false | 是否为不确定进度 |

#### 示例

```qml
import QtQuick
import "../src/components"

Column {
    spacing: 16
    
    // 基础进度条
    CProgress {
        width: 400
        value: 0.6
    }
    
    // 不同颜色
    CProgress {
        width: 400
        value: 0.8
        colorScheme: "green"
    }
    
    // 不确定进度
    CProgress {
        width: 400
        isIndeterminate: true
    }
}
```

---

### CSpinner

加载指示器组件。

#### 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `colorScheme` | string | "blue" | 颜色方案 |
| `size` | string | "md" | 尺寸：xs, sm, md, lg, xl |
| `thickness` | int | - | 线条粗细 |

#### 示例

```qml
import QtQuick
import "../src/components"

Row {
    spacing: 16
    
    CSpinner {
        size: "sm"
    }
    
    CSpinner {
        size: "md"
        colorScheme: "green"
    }
    
    CSpinner {
        size: "lg"
        colorScheme: "purple"
    }
}
```

---

## 布局组件

### CBox

基础盒子容器。

#### 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| 继承所有 Item 属性 | - | - | 支持所有标准 QML Item 属性 |

#### 示例

```qml
import QtQuick
import "../src/components"

CBox {
    width: 200
    height: 100
    
    Rectangle {
        anchors.fill: parent
        color: AppStyle.surfaceColor
        radius: AppStyle.radiusMd
    }
}
```

---

### CFlex

弹性布局容器。

#### 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `direction` | string | "row" | 方向：row, column |
| `justify` | string | "start" | 主轴对齐：start, center, end, space-between, space-around |
| `align` | string | "start" | 交叉轴对齐：start, center, end, stretch |
| `spacing` | int | 0 | 子元素间距 |

#### 示例

```qml
import QtQuick
import "../src/components"

CFlex {
    width: 400
    direction: "row"
    justify: "space-between"
    align: "center"
    spacing: 12
    
    CButton { text: "按钮1" }
    CButton { text: "按钮2" }
    CButton { text: "按钮3" }
}
```

---

### CContainer

内容容器，限制最大宽度并居中。

#### 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `size` | string | "lg" | 容器尺寸：sm, md, lg, xl, full |
| `centerContent` | bool | true | 是否居中内容 |
| `px` | int | - | 水平内边距 |

#### 示例

```qml
import QtQuick
import "../src/components"

CContainer {
    size: "md"
    
    Text {
        text: "容器内容会自动限制最大宽度并居中"
        color: AppStyle.textColor
    }
}
```

---

### CCenter

居中容器，使内容水平垂直居中。

#### 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| 继承所有 Item 属性 | - | - | 内容会自动居中 |

#### 示例

```qml
import QtQuick
import "../src/components"

CCenter {
    width: 400
    height: 300
    
    CButton {
        text: "我在中间"
    }
}
```

---

## 反馈组件

### CDialog

对话框组件。

#### 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `size` | string | "md" | 尺寸：xs, sm, md, lg, xl, full |
| `title` | string | "" | 对话框标题 |
| `closeOnClickOutside` | bool | true | 点击外部关闭 |

#### 方法

- `open()` - 打开对话框
- `close()` - 关闭对话框

#### 示例

```qml
import QtQuick
import "../src/components"

Item {
    CButton {
        text: "打开对话框"
        onClicked: dialog.open()
    }
    
    CDialog {
        id: dialog
        title: "确认操作"
        size: "sm"
        
        Column {
            spacing: 16
            width: parent.width
            
            Text {
                text: "您确定要执行此操作吗？"
                color: AppStyle.textColor
                wrapMode: Text.WordWrap
                width: parent.width
            }
            
            Row {
                spacing: 8
                anchors.right: parent.right
                
                CButton {
                    text: "取消"
                    variant: "outline"
                    onClicked: dialog.close()
                }
                
                CButton {
                    text: "确定"
                    colorScheme: "blue"
                    onClicked: {
                        // 执行操作
                        dialog.close()
                    }
                }
            }
        }
    }
}
```

---

### CDrawer

抽屉组件，从屏幕边缘滑出。

#### 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `placement` | string | "right" | 位置：left, right, top, bottom |
| `size` | string | "md" | 尺寸（宽度/高度） |
| `title` | string | "" | 抽屉标题 |
| `closeOnClickOutside` | bool | true | 点击外部关闭 |

#### 方法

- `open()` - 打开抽屉
- `close()` - 关闭抽屉

#### 示例

```qml
import QtQuick
import "../src/components"

Item {
    CButton {
        text: "打开抽屉"
        onClicked: drawer.open()
    }
    
    CDrawer {
        id: drawer
        title: "设置"
        placement: "right"
        
        Column {
            width: parent.width
            spacing: 16
            
            CSwitch {
                text: "启用通知"
            }
            
            CSwitch {
                text: "深色模式"
            }
            
            CButton {
                text: "保存"
                width: parent.width
                colorScheme: "blue"
                onClicked: drawer.close()
            }
        }
    }
}
```

---

### CMenu

菜单组件。

#### 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| 继承 Popup 属性 | - | - | 支持标准 Popup 属性 |

#### 子组件

- `CMenuItem` - 菜单项
- `CMenuGroup` - 菜单分组
- `CMenuSeparator` - 分隔线

#### 示例

```qml
import QtQuick
import "../src/components"

Item {
    CButton {
        id: menuButton
        text: "打开菜单"
        onClicked: menu.open()
    }
    
    CMenu {
        id: menu
        y: menuButton.height
        
        CMenuItem {
            text: "新建"
            onClicked: console.log("新建")
        }
        
        CMenuItem {
            text: "打开"
            onClicked: console.log("打开")
        }
        
        CMenuSeparator {}
        
        CMenuItem {
            text: "退出"
            onClicked: Qt.quit()
        }
    }
}
```

---

### CAlert

警告提示组件。

#### 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `status` | string | "info" | 状态：info, success, warning, error |
| `title` | string | "" | 标题 |
| `description` | string | "" | 描述 |
| `variant` | string | "subtle" | 变体：subtle, left-accent, top-accent, solid |
| `closable` | bool | false | 是否可关闭 |

#### 示例

```qml
import QtQuick
import "../src/components"

Column {
    spacing: 12
    
    CAlert {
        width: 400
        status: "info"
        title: "提示"
        description: "这是一条信息提示"
    }
    
    CAlert {
        width: 400
        status: "success"
        title: "成功"
        description: "操作已成功完成"
    }
    
    CAlert {
        width: 400
        status: "error"
        title: "错误"
        description: "发生了一个错误"
        closable: true
    }
}
```

---

### CTooltip

工具提示组件。

#### 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `text` | string | "" | 提示文本 |
| `placement` | string | "top" | 位置：top, bottom, left, right |

#### 示例

```qml
import QtQuick
import "../src/components"

Row {
    spacing: 16
    
    CButton {
        text: "悬停显示提示"
        
        CTooltip {
            text: "这是一个提示"
            visible: parent.hovered
        }
    }
}
```

---

## 导航组件

### CSegmentedControl

分段控制器，用于切换不同视图。

#### 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `model` | var | [] | 选项列表 |
| `currentIndex` | int | 0 | 当前选中索引 |
| `isDisabled` | bool | false | 是否禁用 |

#### 示例

```qml
import QtQuick
import "../src/components"

Column {
    spacing: 16
    
    CSegmentedControl {
        model: ["选项1", "选项2", "选项3"]
        currentIndex: 0
        onCurrentIndexChanged: {
            console.log("选中:", currentIndex)
        }
    }
}
```

---

### CPagination

分页器组件。

#### 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `currentPage` | int | 1 | 当前页码 |
| `totalPages` | int | 1 | 总页数 |
| `isCompact` | bool | false | 紧凑模式 |
| `showsFirstLast` | bool | true | 显示首页/末页按钮 |
| `maxVisiblePages` | int | 7 | 最多显示页码数 |

#### 示例

```qml
import QtQuick
import "../src/components"

Column {
    spacing: 16
    
    CPagination {
        currentPage: 1
        totalPages: 10
        onCurrentPageChanged: {
            console.log("跳转到第", currentPage, "页")
        }
    }
    
    // 紧凑模式
    CPagination {
        currentPage: 1
        totalPages: 20
        isCompact: true
    }
}
```

---

## 其他组件

### CScrollArea

带滚动条的滚动区域。

#### 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| 继承 ScrollView 属性 | - | - | 支持标准 ScrollView 属性 |

#### 示例

```qml
import QtQuick
import "../src/components"

CScrollArea {
    width: 400
    height: 300
    
    Column {
        width: parent.width
        spacing: 8
        
        Repeater {
            model: 50
            CButton {
                text: "按钮 " + (index + 1)
            }
        }
    }
}
```

---

### CIcon

图标组件（需要配合图标字体使用）。

#### 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `name` | string | "" | 图标名称 |
| `size` | int | 24 | 图标尺寸 |
| `color` | color | - | 图标颜色 |

#### 示例

```qml
import QtQuick
import "../src/components"

Row {
    spacing: 16
    
    CIcon {
        name: "check"
        size: 24
        color: AppStyle.textColor
    }
    
    CIcon {
        name: "close"
        size: 32
        color: "red"
    }
}
```

---

## 主题定制

所有组件都使用 `AppStyle` 进行样式管理，支持自定义主题。

### 常用样式属性

```qml
AppStyle.spacing1  // 4px
AppStyle.spacing2  // 8px
AppStyle.spacing3  // 12px
AppStyle.spacing4  // 16px
AppStyle.spacing5  // 20px
AppStyle.spacing6  // 24px

AppStyle.radiusSm  // 2px
AppStyle.radiusMd  // 4px
AppStyle.radiusLg  // 8px
AppStyle.radiusXl  // 12px

AppStyle.fontSizeXs  // 12px
AppStyle.fontSizeSm  // 14px
AppStyle.fontSizeMd  // 16px
AppStyle.fontSizeLg  // 18px
AppStyle.fontSizeXl  // 20px

AppStyle.textColor
AppStyle.textSecondary
AppStyle.textMuted
AppStyle.backgroundColor
AppStyle.surfaceColor
AppStyle.borderColor
```

---

## 完整示例

以下是一个完整的表单示例：

```qml
import QtQuick
import QtQuick.Window
import "../src/components"

Window {
    visible: true
    width: 640
    height: 800
    color: AppStyle.backgroundColor
    
    Flickable {
        anchors.fill: parent
        anchors.margins: 20
        contentWidth: width
        contentHeight: column.height
        clip: true
        
        Column {
            id: column
            width: parent.width
            spacing: AppStyle.spacing6
            
            Text {
                text: "用户注册"
                font.pixelSize: AppStyle.fontSizeXl
                font.weight: Font.Bold
                color: AppStyle.textColor
            }
            
            CCard {
                width: parent.width
                title: "基本信息"
                spacing: AppStyle.spacing4
                
                CInput {
                    width: parent.width
                    placeholderText: "用户名"
                }
                
                CInput {
                    width: parent.width
                    placeholderText: "邮箱"
                }
                
                CInput {
                    width: parent.width
                    placeholderText: "密码"
                    inputType: "password"
                }
                
                CCheckbox {
                    text: "我已阅读并同意服务条款"
                }
                
                CButton {
                    text: "注册"
                    width: parent.width
                    colorScheme: "blue"
                }
            }
        }
    }
}
```
