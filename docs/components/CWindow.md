# CWindow 组件

无边框圆角窗口组件，提供现代化的窗口外观，支持自定义标题栏、原生拖拽、调整大小和 DWM 阴影效果。

## 示例

```qml
import QtQuick
import Chakra

CWindow {
    width: 800
    height: 600
    title: "我的应用"
    visible: true

    Text {
        anchors.centerIn: parent
        text: "Hello, Chakra!"
    }
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| showTitleBar | bool | true | 是否显示标题栏 |
| showTitle | bool | true | 是否显示标题文字 |
| showThemeToggle | bool | true | 是否显示主题切换按钮 |
| showMinimize | bool | true | 是否显示最小化按钮 |
| showMaximize | bool | true | 是否显示最大化按钮 |
| showClose | bool | true | 是否显示关闭按钮 |
| titleBarHeight | int | 40 | 标题栏高度（像素） |
| titleBarContent | Component | null | 标题栏自定义内容 |
| shadowEnabled | bool | true | 是否启用窗口阴影 |
| content | alias | - | 内容区域（default 属性） |
| overlay | alias | - | 覆盖层容器，用于 Dialog、Drawer 等组件 |
| framelessInstance | alias | - | CFrameless 实例，供其他组件使用 |

## 示例代码

### 基础用法

```qml
CWindow {
    width: 800
    height: 600
    title: "基础窗口"
    visible: true

    Column {
        anchors.centerIn: parent
        spacing: 20

        Text { text: "欢迎使用 Chakra 组件库" }
        CButton { text: "点击我" }
    }
}
```

### 自定义标题栏

```qml
CWindow {
    title: "自定义标题栏"

    titleBarContent: Row {
        spacing: 10
        CButton { text: "文件"; variant: "ghost" }
        CButton { text: "编辑"; variant: "ghost" }
    }
}
```

### 隐藏部分按钮

```qml
CWindow {
    title: "简洁窗口"
    showThemeToggle: false
    showMaximize: false
}
```

### 使用覆盖层

```qml
CWindow {
    id: mainWindow

    CButton {
        text: "打开对话框"
        onClicked: dialog.open()
    }

    overlay: [
        CDialog { id: dialog; title: "提示" }
    ]
}
```

## 注意事项

1. CWindow 使用 CFrameless 实现原生窗口效果，Windows 平台支持 DWM 阴影。
2. 窗口最大化时自动禁用圆角效果。
3. 标题栏支持原生拖拽，自定义按钮自动设为可点击区域。
4. overlay 属性用于放置 Dialog、Drawer 等覆盖组件。
### 隐藏部分按钮

```qml
import QtQuick
import Chakra

CWindow {
    width: 600
    height: 400
    title: "简洁窗口"
    visible: true

    showThemeToggle: false
    showMaximize: false

    Text {
        anchors.centerIn: parent
        text: "只显示最小化和关闭按钮"
    }
}
```

### 无标题栏窗口

```qml
import QtQuick
import Chakra

CWindow {
    width: 400
    height: 300
    visible: true

    showTitleBar: false

    Rectangle {
        anchors.fill: parent
        color: "transparent"

        Text {
            anchors.centerIn: parent
            text: "无标题栏窗口"
        }

        // 自定义关闭按钮
        CButton {
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 10
            text: "关闭"
            onClicked: window.close()
        }
    }
}
```

### 使用覆盖层

```qml
import QtQuick
import Chakra

CWindow {
    id: mainWindow
    width: 800
    height: 600
    title: "带覆盖层的窗口"
    visible: true

    CButton {
        anchors.centerIn: parent
        text: "打开对话框"
        onClicked: dialog.open()
    }

    overlay: [
        CDialog {
            id: dialog
            title: "提示"
            content: "这是一个对话框"
        }
    ]
}
```

## 注意事项

1. **平台兼容性**：CWindow 使用 CFrameless 组件实现原生窗口效果，在 Windows 平台上支持 DWM 阴影。其他平台可能需要额外配置。

2. **圆角效果**：窗口最大化时会自动禁用圆角效果以优化性能和视觉效果。

3. **标题栏拖拽**：标题栏区域支持原生拖拽移动窗口，自定义按钮会自动设置为可点击区域（不触发拖拽）。

4. **主题切换**：主题切换按钮会调用 `AppStyle.toggleTheme()` 方法，确保应用已正确配置 AppStyle。

5. **覆盖层使用**：overlay 属性用于放置需要覆盖整个窗口的组件（如 Dialog、Drawer），它们会显示在内容区域之上。

6. **性能优化**：窗口最大化或全屏时会自动禁用 layer 效果以提升渲染性能。
