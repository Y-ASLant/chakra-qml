# Chakra QML API 使用指南

## 快速开始

### 最简使用方式（推荐）

```python
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtGui import QGuiApplication
from PySide6.QtQuickControls2 import QQuickStyle
from chakra import setup
import sys

QQuickStyle.setStyle("Basic")  # 必须！允许自定义组件外观

app = QGuiApplication(sys.argv)
engine = QQmlApplicationEngine()

# 一行初始化
setup(engine)

engine.load("main.qml")
sys.exit(app.exec())
```

```qml
// main.qml
import QtQuick
import Chakra

CWindow {
    visible: true
    width: 800
    height: 600
    
    CButton {
        text: "Hello Chakra"
        anchors.centerIn: parent
    }
}
```

---

## API 参考

### setup()

**推荐使用的主初始化函数**

```python
def setup(engine=None, module_name="Chakra", major_version=1, minor_version=0)
```

- **engine**: QQmlApplicationEngine 实例（可选）
- **module_name**: QML 模块名（默认 "Chakra"）
- **major_version**: 主版本号（默认 1）
- **minor_version**: 次版本号（默认 0）

**使用场景**：
- 标准应用初始化
- 支持延迟传入 engine
- 自动注册所有类型和导入路径

```python
# 方式1：直接传入 engine
engine = QQmlApplicationEngine()
setup(engine)

# 方式2：先注册类型，后添加路径
setup()  # 仅注册类型
# ... 其他初始化代码 ...
add_import_path(engine)
```

---

### init()

**setup() 的别名，保持向后兼容**

```python
def init(engine, module_name="Chakra", major_version=1, minor_version=0)
```

---

### register_types()

**仅注册 Python QML 类型**

```python
def register_types(module_name="Chakra", major_version=1, minor_version=0)
```

**使用场景**：
- 需要在创建 engine 前注册类型
- 自定义初始化流程
- 多 engine 共享类型注册

```python
from chakra import register_types, add_import_path

register_types()  # 注册 CFrameless 等类型

engine1 = QQmlApplicationEngine()
add_import_path(engine1)

engine2 = QQmlApplicationEngine()
add_import_path(engine2)
```

---

### add_import_path()

**添加 Chakra 组件导入路径**

```python
def add_import_path(engine)
```

**使用场景**：
- 手动控制导入路径添加时机
- 配合 `register_types()` 使用

```python
from chakra import add_import_path

engine = QQmlApplicationEngine()
add_import_path(engine)
```

---

### CFrameless

**原生无边框窗口类**

```python
from chakra import CFrameless
from PySide6.QtQml import qmlRegisterType

# 手动注册（通常不需要，setup() 已自动注册）
qmlRegisterType(CFrameless, "Chakra", 1, 0, "CFrameless")
```

**QML 使用**：
```qml
import Chakra

CWindow {
    // 自动使用 CFrameless 实现无边框窗口
}
```

---

### get_component_path()

**获取组件目录路径**

```python
def get_component_path() -> str
```

**使用场景**：
- 调试路径问题
- 自定义导入路径配置

```python
from chakra import get_component_path

print(f"Chakra 组件路径: {get_component_path()}")
```

---

## 使用模式对比

### ✅ 推荐方式

```python
from chakra import setup

engine = QQmlApplicationEngine()
setup(engine)
```

**优点**：
- 代码最简洁
- 一行完成所有初始化
- 不需要理解底层细节

---

### ✅ 灵活控制

```python
from chakra import register_types, add_import_path

register_types()  # 先注册类型

# ... 其他初始化 ...

engine = QQmlApplicationEngine()
add_import_path(engine)  # 后添加路径
```

**优点**：
- 控制初始化顺序
- 适合复杂场景
- 多 engine 支持

---

### ⚠️ 不推荐（过于底层）

```python
from chakra import CFrameless
from PySide6.QtQml import qmlRegisterType

qmlRegisterType(CFrameless, "Chakra", 1, 0, "CFrameless")
engine.addImportPath(...)
```

**缺点**：
- 代码冗长
- 需要理解 Qt 底层机制
- 容易出错

---

## QML 导入

### ✅ 正确方式

```qml
import QtQuick
import Chakra  // 模块名导入

CWindow {
    CButton { }
}
```

### ❌ 错误方式

```qml
import "../src/Chakra"  // 不要使用相对路径
import "qrc:/Chakra"     // 不要使用 qrc 路径
```

---

## 完整示例

### 基础应用

```python
import sys
from pathlib import Path
from PySide6.QtCore import QDir
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtQuickControls2 import QQuickStyle
from chakra import setup

QQuickStyle.setStyle("Basic")  # 必须在 QGuiApplication 前设置

app = QGuiApplication(sys.argv)
QDir.setCurrent(str(Path(__file__).parent))

engine = QQmlApplicationEngine()
setup(engine)
engine.load("main.qml")

if not engine.rootObjects():
    sys.exit(-1)

sys.exit(app.exec())
```

```qml
import QtQuick
import Chakra

CWindow {
    visible: true
    width: 640
    height: 480
    title: "Chakra QML App"
    
    Column {
        anchors.centerIn: parent
        spacing: AppStyle.spacing4
        
        CButton {
            text: "Primary Button"
            colorScheme: "primary"
        }
        
        CInput {
            placeholderText: "Enter text..."
        }
        
        CCheckbox {
            text: "Accept terms"
        }
    }
}
```

---

## 常见问题

### Q: setup() 和 init() 有什么区别？

A: 功能完全相同，`init()` 是为了向后兼容保留的别名。推荐使用 `setup()`，语义更清晰。

### Q: 什么时候需要手动使用 register_types()？

A: 通常不需要。只在特殊场景使用：
- 多个 QML engine 共享类型注册
- 需要在创建 engine 前注册类型
- 自定义初始化流程

### Q: 为什么 QML 中要用 `import Chakra` 而不是相对路径？

A: 
- 模块导入是 Qt 的标准方式
- 相对路径在安装包环境下无法工作
- `setup()` 已自动配置好模块路径

### Q: CFrameless 是什么？

A: 提供原生无边框窗口功能的 Python 类，在 QML 中通过 `CWindow` 组件自动使用。

---

## 版本兼容性

- **0.0.1**: 仅支持 `init(engine)`
- **0.0.2**: 添加 `setup()`，支持更灵活的初始化
- **向后兼容**: 旧的 `init()` 继续可用

---

## 相关文档

- [组件列表](./components.md)
- [主题定制](./theming.md)
- [示例代码](../demo/)
