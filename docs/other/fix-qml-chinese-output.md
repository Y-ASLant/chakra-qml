# PySide6 QML 中文输出乱码解决方案

## 问题

在 Windows 上运行 PySide6 QML 应用时，使用 `print()` 输出中文会显示乱码：

```
qml: ��¼
```

## 原因

QML 的 `print()` 通过 Qt 的日志系统（qDebug）输出，Windows 控制台默认编码与 UTF-8 不兼容。

## 解决方案

在 `main.py` 中使用 `qInstallMessageHandler` 自定义消息处理器：

```python
from PySide6.QtCore import qInstallMessageHandler

def message_handler(mode, context, message):
    print(message)

qInstallMessageHandler(message_handler)
```

## 完整示例

```python
import sys
from PySide6.QtCore import qInstallMessageHandler
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

def message_handler(mode, context, message):
    print(message)

qInstallMessageHandler(message_handler)

app = QGuiApplication(sys.argv)
engine = QQmlApplicationEngine()
engine.load("src/pages/index.qml")

if not engine.rootObjects():
    sys.exit(-1)

sys.exit(app.exec())
```

这样 QML 中的 `print("中文")` 就能正常显示了。
