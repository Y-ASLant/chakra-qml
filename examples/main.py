import sys
from pathlib import Path
import chakra
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtQuickControls2 import QQuickStyle

QQuickStyle.setStyle("Basic")
app = QGuiApplication(sys.argv)
engine = QQmlApplicationEngine()
chakra.init(engine)
qml_file = Path(__file__).parent / "app.qml"
engine.load(str(qml_file))
sys.exit(app.exec())
