# Chakra UI QML 使用指南

## 安装

```bash
pip install chakra-qtquick
```

## 快速开始

### 1. 创建 Python 主文件 (main.py)

```python
import sys
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtQuickControls2 import QQuickStyle
from chakra_ui import init

QQuickStyle.setStyle("Basic")

app = QGuiApplication(sys.argv)
engine = QQmlApplicationEngine()

# 初始化 Chakra UI
init(engine)

# 加载 QML 文件
engine.load("main.qml")

if not engine.rootObjects():
    sys.exit(-1)

sys.exit(app.exec())
```

### 2. 创建 QML 文件 (main.qml)

```qml
import QtQuick
import QtQuick.Controls
import Chakra 1.0

CWindow {
    width: 800
    height: 600
    visible: true
    title: "Chakra UI Demo"

    CBox {
        anchors.fill: parent
        padding: 20

        CFlex {
            anchors.fill: parent
            direction: "column"
            spacing: 20

            CButton {
                text: "Click Me"
                colorScheme: "blue"
                onClicked: console.log("Button clicked!")
            }

            CInput {
                placeholder: "Enter text..."
            }

            CCheckbox {
                text: "Enable feature"
            }
        }
    }
}
```

## 重要提示

1. **模块导入**：在 QML 中必须使用 `import Chakra 1.0`，不是 `chakra_ui` 或 `chakra_ui_qml`
2. **初始化**：必须在 Python 中调用 `init(engine)` 来注册 QML 类型和设置导入路径
3. **Qt 样式**：推荐使用 `QQuickStyle.setStyle("Basic")` 以获得最佳自定义效果

## 可用组件

- 布局组件：CBox, CFlex, CCenter, CContainer, CCard
- 表单组件：CButton, CInput, CCheckbox, CSwitch, CSelect, CSegmentedControl
- 反馈组件：CAlert, CBadge, CTag, CSpinner, CProgress
- 窗口组件：CWindow, CDialog, CDrawer, CTooltip
- 其他组件：CScrollArea, CScrollBar, CPagination, CMenu, CIcon

## 详细文档

访问项目仓库查看更多示例和文档：
https://github.com/Y-ASLant/chakra-qml
