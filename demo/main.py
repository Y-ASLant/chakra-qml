import sys
from pathlib import Path
from PySide6.QtCore import qInstallMessageHandler, QDir
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtQuickControls2 import QQuickStyle
from chakra import setup

project_root = Path(__file__).parent.parent
sys.path.insert(0, str(project_root))

QQuickStyle.setStyle("Basic")


def message_handler(mode, context, message):
    print(message)


qInstallMessageHandler(message_handler)

app = QGuiApplication(sys.argv)
QDir.setCurrent(str(Path(__file__).parent))

engine = QQmlApplicationEngine()
setup(engine)
engine.load(str(Path(__file__).parent / "framless.qml"))

if not engine.rootObjects():
    sys.exit(-1)

sys.exit(app.exec())
