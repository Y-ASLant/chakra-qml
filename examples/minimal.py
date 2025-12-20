"""
最简 Chakra QML 无边框应用示例
"""

import sys
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtQuickControls2 import QQuickStyle
from chakra import setup

QQuickStyle.setStyle("Basic")

app = QGuiApplication(sys.argv)

engine = QQmlApplicationEngine()
setup(engine)
engine.load("minimal.qml")

if not engine.rootObjects():
    sys.exit(-1)

sys.exit(app.exec())
