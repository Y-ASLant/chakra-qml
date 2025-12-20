import sys
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtQuickControls2 import QQuickStyle
from PySide6.QtCore import QObject, Slot
from chakra import setup

QQuickStyle.setStyle("Basic")

app = QGuiApplication(sys.argv)


class ClipboardHelper(QObject):
    @Slot(str)
    def copyToClipboard(self, text):
        clipboard = QGuiApplication.clipboard()
        clipboard.setText(text)


clipboard_helper = ClipboardHelper()

engine = QQmlApplicationEngine()
engine.rootContext().setContextProperty("clipboardHelper", clipboard_helper)
setup(engine)
engine.load("icons.qml")

if not engine.rootObjects():
    sys.exit(-1)

sys.exit(app.exec())
