import sys
import unittest
from pathlib import Path
from unittest.mock import Mock
from PySide6.QtCore import Qt
from PySide6.QtGui import QGuiApplication
from PySide6.QtQuick import QQuickWindow

project_root = Path(__file__).parent.parent.parent
sys.path.insert(0, str(project_root / "src" / "components"))
from CFrameless import CFrameless


class TestCFrameless(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.app = QGuiApplication.instance()
        if cls.app is None:
            cls.app = QGuiApplication(sys.argv)

    def setUp(self):
        self.frameless = CFrameless()

    def test_initialization(self):
        self.assertIsNotNone(self.frameless)
        self.assertEqual(self.frameless._current, 0)
        self.assertEqual(self.frameless._edges, 0)
        self.assertEqual(self.frameless._margins, 8)
        self.assertFalse(self.frameless._disabled)

    def test_disabled_property(self):
        self.assertFalse(self.frameless.disabled)

        self.frameless.disabled = True
        self.assertTrue(self.frameless.disabled)

        self.frameless.disabled = False
        self.assertFalse(self.frameless.disabled)

    def test_is_fullscreen(self):
        mock_window = Mock(spec=QQuickWindow)
        mock_window.visibility.return_value = QQuickWindow.Visibility.FullScreen
        self.frameless.window = Mock(return_value=mock_window)

        result = self.frameless._isFullScreen()
        self.assertTrue(result)

    def test_is_maximized(self):
        mock_window = Mock(spec=QQuickWindow)
        mock_window.visibility.return_value = QQuickWindow.Visibility.Maximized
        self.frameless.window = Mock(return_value=mock_window)

        result = self.frameless._isMaximized()
        self.assertTrue(result)

    def test_update_cursor_arrow(self):
        mock_window = Mock(spec=QQuickWindow)
        self.frameless.window = Mock(return_value=mock_window)

        self.frameless._updateCursor(0)
        mock_window.setCursor.assert_called_with(Qt.CursorShape.ArrowCursor)

    def test_update_cursor_horizontal(self):
        mock_window = Mock(spec=QQuickWindow)
        self.frameless.window = Mock(return_value=mock_window)

        self.frameless._updateCursor(0x00002)
        mock_window.setCursor.assert_called_with(Qt.CursorShape.SizeHorCursor)

    def test_update_cursor_vertical(self):
        mock_window = Mock(spec=QQuickWindow)
        self.frameless.window = Mock(return_value=mock_window)

        self.frameless._updateCursor(0x00001)
        mock_window.setCursor.assert_called_with(Qt.CursorShape.SizeVerCursor)


if __name__ == "__main__":
    unittest.main()
