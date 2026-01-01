import sys
from pathlib import Path
from PySide6.QtCore import qInstallMessageHandler, QDir, QObject, Slot
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine, qmlRegisterType
from PySide6.QtQuickControls2 import QQuickStyle

from src.Chakra.CFrameless import CFrameless

QQuickStyle.setStyle("Basic")


class ClipboardHelper(QObject):
    @Slot(str)
    def copyToClipboard(self, text):
        clipboard = QGuiApplication.clipboard()
        clipboard.setText(text)


def message_handler(mode, context, message):
    print(message)


qInstallMessageHandler(message_handler)

app = QGuiApplication(sys.argv)
QDir.setCurrent(str(Path(__file__).parent))

# import source.source_rc  # noqa

qmlRegisterType(CFrameless, "Chakra", 1, 0, "CFrameless")

clipboard_helper = ClipboardHelper()

engine = QQmlApplicationEngine()
engine.rootContext().setContextProperty("clipboardHelper", clipboard_helper)
engine.addImportPath("src")
engine.load("gallery/index.qml")

if not engine.rootObjects():
    sys.exit(-1)

sys.exit(app.exec())
