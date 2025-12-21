import sys
from pathlib import Path
from PySide6.QtCore import qInstallMessageHandler, QDir
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine, qmlRegisterType
from PySide6.QtQuickControls2 import QQuickStyle

from src.Chakra.CFrameless import CFrameless

QQuickStyle.setStyle("Basic")


def message_handler(mode, context, message):
    print(message)


qInstallMessageHandler(message_handler)

app = QGuiApplication(sys.argv)
QDir.setCurrent(str(Path(__file__).parent))

import source.source_rc  # noqa

qmlRegisterType(CFrameless, "Chakra", 1, 0, "CFrameless")

engine = QQmlApplicationEngine()
engine.addImportPath("src")
engine.load("src/pages/index.qml")

if not engine.rootObjects():
    sys.exit(-1)

sys.exit(app.exec())
