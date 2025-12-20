import sys
from pathlib import Path
from PySide6.QtCore import qInstallMessageHandler, QDir
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine, qmlRegisterType
from PySide6.QtQuickControls2 import QQuickStyle

from src.Chakra.CFrameless import CFrameless

# 设置 Qt Quick Controls 样式为 Basic（支持自定义）
QQuickStyle.setStyle("Basic")


def message_handler(mode, context, message):
    print(message)


qInstallMessageHandler(message_handler)

app = QGuiApplication(sys.argv)

# 设置工作目录，让 qrc 相对路径正常工作
QDir.setCurrent(str(Path(__file__).parent))

# 导入编译后的 qrc 资源
import source.source_rc  # noqa

# 注册 CFrameless 到 QML
qmlRegisterType(CFrameless, "Chakra", 1, 0, "CFrameless")

engine = QQmlApplicationEngine()
engine.addImportPath("src")  # 添加组件导入路径
engine.load("src/pages/index.qml")

if not engine.rootObjects():
    sys.exit(-1)

sys.exit(app.exec())
