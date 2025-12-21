import sys
from PySide6.QtCore import (
    Signal,
    Slot,
    Qt,
    QEvent,
    QAbstractNativeEventFilter,
    Property,
    QRectF,
    QDateTime,
    QPointF,
)
from PySide6.QtGui import QMouseEvent, QGuiApplication, QCursor
from PySide6.QtQuick import QQuickItem, QQuickWindow

if sys.platform == "win32":
    from ctypes import (
        POINTER,
        byref,
        c_bool,
        c_int,
        c_void_p,
        c_long,
        WinDLL,
        cast,
        Structure,
        c_uint,
        c_uint16,
    )
    from ctypes.wintypes import HWND, MSG, RECT, UINT, POINT

    def HIWORD(dword):
        return c_uint16((dword >> 16) & 0xFFFF).value

    def LOWORD(dword):
        return c_uint16(dword & 0xFFFF).value

    class MARGINS(Structure):
        _fields_ = [
            ("cxLeftWidth", c_int),
            ("cxRightWidth", c_int),
            ("cyTopHeight", c_int),
            ("cyBottomHeight", c_int),
        ]

    class PWINDOWPOS(Structure):
        _fields_ = [
            ("hWnd", HWND),
            ("hwndInsertAfter", HWND),
            ("x", c_int),
            ("y", c_int),
            ("cx", c_int),
            ("cy", c_int),
            ("flags", UINT),
        ]

    class NCCALCSIZE_PARAMS(Structure):
        _fields_ = [("rgrc", RECT * 3), ("lppos", POINTER(PWINDOWPOS))]

    class MINMAXINFO(Structure):
        _fields_ = [
            ("ptReserved", POINT),
            ("ptMaxSize", POINT),
            ("ptMaxPosition", POINT),
            ("ptMinTrackSize", POINT),
            ("ptMaxTrackSize", POINT),
        ]

    LPNCCALCSIZE_PARAMS = POINTER(NCCALCSIZE_PARAMS)
    qtNativeEventType = b"windows_generic_MSG"

    user32 = WinDLL("user32")
    dwmapi = WinDLL("dwmapi")

    GetWindowLongPtrW = user32.GetWindowLongPtrW
    GetWindowLongPtrW.argtypes = [c_void_p, c_int]
    GetWindowLongPtrW.restype = c_long

    SetWindowLongPtrW = user32.SetWindowLongPtrW
    SetWindowLongPtrW.argtypes = [c_void_p, c_int, c_long]
    SetWindowLongPtrW.restype = c_long

    SetWindowPos = user32.SetWindowPos
    SetWindowPos.argtypes = [c_void_p, c_void_p, c_int, c_int, c_int, c_int, c_uint]
    SetWindowPos.restype = c_bool

    IsZoomed = user32.IsZoomed
    IsZoomed.argtypes = [c_void_p]
    IsZoomed.restype = c_bool

    ScreenToClient = user32.ScreenToClient
    ScreenToClient.argtypes = [c_void_p, c_void_p]
    ScreenToClient.restype = c_bool

    GetClientRect = user32.GetClientRect
    GetClientRect.argtypes = [c_void_p, c_void_p]
    GetClientRect.restype = c_bool

    SystemParametersInfoW = user32.SystemParametersInfoW
    SystemParametersInfoW.argtypes = [c_uint, c_uint, c_void_p, c_uint]
    SystemParametersInfoW.restype = c_bool

    DwmExtendFrameIntoClientArea = dwmapi.DwmExtendFrameIntoClientArea
    DwmExtendFrameIntoClientArea.argtypes = [c_void_p, c_void_p]
    DwmExtendFrameIntoClientArea.restype = c_long

    def setShadow(hwnd):
        margins = MARGINS(1, 0, 0, 0)
        DwmExtendFrameIntoClientArea(hwnd, byref(margins))


class CFrameless(QQuickItem, QAbstractNativeEventFilter):
    disabledChanged = Signal()

    def __init__(self):
        QQuickItem.__init__(self)
        QAbstractNativeEventFilter.__init__(self)
        self._current = 0
        self._edges = 0
        self._margins = 8
        self._clickTimer = 0
        self._hitTestList = []
        self._disabled = False

    @Property(bool, notify=disabledChanged)
    def disabled(self):
        return self._disabled

    @disabled.setter
    def disabled(self, value):
        self._disabled = value
        self.disabledChanged.emit()

    @Slot()
    def onDestruction(self):
        QGuiApplication.instance().removeNativeEventFilter(self)

    def componentComplete(self):
        if self._disabled:
            return

        self._current = self.window().winId()
        self.window().setFlags(
            self.window().flags()
            | Qt.WindowType.CustomizeWindowHint
            | Qt.WindowType.WindowMinimizeButtonHint
            | Qt.WindowType.WindowMaximizeButtonHint
            | Qt.WindowType.WindowCloseButtonHint
        )
        self.window().installEventFilter(self)

        if sys.platform == "win32":
            # Windows 原生消息处理
            QGuiApplication.instance().installNativeEventFilter(self)
            hwnd = self.window().winId()
            style = GetWindowLongPtrW(hwnd, -16)
            SetWindowLongPtrW(hwnd, -16, style | 0x00010000 | 0x00040000 | 0x00C00000)
            SetWindowPos(
                hwnd, None, 0, 0, 0, 0, 0x0004 | 0x0200 | 0x0002 | 0x0001 | 0x0020
            )
            setShadow(hwnd)
        # Linux/macOS 使用 Qt 事件过滤器即可（已通过 installEventFilter 安装）

    def nativeEventFilter(self, eventType, message):
        if sys.platform != "win32":
            return False, 0

        if eventType != qtNativeEventType or message is None:
            return False, 0

        msg = MSG.from_address(message.__int__())
        hwnd = msg.hWnd

        if hwnd is None or hwnd != self._current:
            return False, 0

        uMsg = msg.message
        lParam = msg.lParam

        if uMsg == 0x0046:
            wp = cast(lParam, POINTER(PWINDOWPOS)).contents
            if wp is not None and ((wp.flags & 0x0001) == 0):
                wp.flags |= 0x0100
            return False, 0

        elif uMsg == 0x0083:
            if msg.wParam and lParam:
                isMaximum = bool(IsZoomed(hwnd))
                params = cast(lParam, LPNCCALCSIZE_PARAMS).contents
                
                if isMaximum:
                    borderX = 8
                    borderY = 8
                    
                    params.rgrc[0].left += borderX
                    params.rgrc[0].top += borderY
                    params.rgrc[0].right -= borderX
                    params.rgrc[0].bottom -= borderY
                
                return True, 0
            return False, 0

        elif uMsg == 0x0084:
            # 修复副屏坐标溢出：使用有符号整数处理负坐标
            x_signed = c_int(c_uint16(LOWORD(lParam)).value).value
            if x_signed > 32767:
                x_signed -= 65536
            y_signed = c_int(c_uint16(HIWORD(lParam)).value).value
            if y_signed > 32767:
                y_signed -= 65536
                
            nativeLocalPos = POINT(x_signed, y_signed)
            ScreenToClient(hwnd, byref(nativeLocalPos))

            # 使用 Qt 窗口的实际大小
            clientWidth = int(self.window().width())
            clientHeight = int(self.window().height())

            left = nativeLocalPos.x < self._margins
            right = nativeLocalPos.x > clientWidth - self._margins
            top = nativeLocalPos.y < self._margins
            bottom = nativeLocalPos.y > clientHeight - self._margins

            result = 0
            if not self._isFullScreen() and not self._isMaximized():
                if left and top:
                    result = 13
                elif left and bottom:
                    result = 16
                elif right and top:
                    result = 14
                elif right and bottom:
                    result = 17
                elif left:
                    result = 10
                elif right:
                    result = 11
                elif top:
                    result = 12
                elif bottom:
                    result = 15

            if result != 0:
                return True, result

            if self._hitTitleBar():
                return True, 2
            return True, 1

        elif uMsg == 0x0024:
            minmaxInfo = cast(lParam, POINTER(MINMAXINFO)).contents
            pixelRatio = self.window().devicePixelRatio()
            geometry = self.window().screen().availableGeometry()
            rect = RECT()
            SystemParametersInfoW(0x0030, 0, byref(rect), 0)
            minmaxInfo.ptMaxPosition.x = rect.left
            minmaxInfo.ptMaxPosition.y = rect.top
            minmaxInfo.ptMaxSize.x = int(geometry.width() * pixelRatio)
            minmaxInfo.ptMaxSize.y = int(geometry.height() * pixelRatio)
            return False, 0

        return False, 0

    def eventFilter(self, watched, event):
        if self.window() is None:
            return False

        if event.type() == QEvent.Type.MouseButtonPress:
            if self._edges != 0:
                mouse_event = QMouseEvent(event)
                if mouse_event.button() == Qt.MouseButton.LeftButton:
                    self._updateCursor(self._edges)
                    self.window().startSystemResize(Qt.Edge(self._edges))
            else:
                if self._hitTitleBar():
                    clickTimer = QDateTime.currentMSecsSinceEpoch()
                    offset = clickTimer - self._clickTimer
                    self._clickTimer = clickTimer
                    if offset < 300:
                        if self._isMaximized():
                            self.window().showNormal()
                        else:
                            self.window().showMaximized()
                    else:
                        self.window().startSystemMove()

        elif event.type() == QEvent.Type.MouseButtonRelease:
            self._edges = 0

        elif event.type() == QEvent.Type.MouseMove:
            if self._isMaximized() or self._isFullScreen():
                return False

            mouse_event = QMouseEvent(event)
            p = mouse_event.position().toPoint()

            if self._margins <= p.x() <= (
                self.window().width() - self._margins
            ) and self._margins <= p.y() <= (self.window().height() - self._margins):
                if self._edges != 0:
                    self._edges = 0
                    self._updateCursor(self._edges)
                return False

            self._edges = 0
            if p.x() < self._margins:
                self._edges |= 0x00002
            if p.x() > (self.window().width() - self._margins):
                self._edges |= 0x00004
            if p.y() < self._margins:
                self._edges |= 0x00001
            if p.y() > (self.window().height() - self._margins):
                self._edges |= 0x00008
            self._updateCursor(self._edges)

        return False

    @Slot(QQuickItem)
    def setHitTestVisible(self, item):
        if item not in self._hitTestList:
            self._hitTestList.append(item)

    def _containsCursorToItem(self, item):
        try:
            if not item or not item.isVisible():
                return False
            point = item.window().mapFromGlobal(QCursor.pos())
            rect = QRectF(
                item.mapToItem(item.window().contentItem(), QPointF(0, 0)), item.size()
            )
            return rect.contains(point)
        except RuntimeError:
            if item in self._hitTestList:
                self._hitTestList.remove(item)
            return False

    def _isFullScreen(self):
        return self.window().visibility() == QQuickWindow.Visibility.FullScreen

    def _isMaximized(self):
        return self.window().visibility() == QQuickWindow.Visibility.Maximized

    def _updateCursor(self, edges):
        if edges == 0:
            self.window().setCursor(Qt.CursorShape.ArrowCursor)
        elif edges == 0x00002 or edges == 0x00004:
            self.window().setCursor(Qt.CursorShape.SizeHorCursor)
        elif edges == 0x00001 or edges == 0x00008:
            self.window().setCursor(Qt.CursorShape.SizeVerCursor)
        elif edges == 0x00002 | 0x00001 or edges == 0x00004 | 0x00008:
            self.window().setCursor(Qt.CursorShape.SizeFDiagCursor)
        elif edges == 0x00004 | 0x00001 or edges == 0x00002 | 0x00008:
            self.window().setCursor(Qt.CursorShape.SizeBDiagCursor)

    def _hitTitleBar(self):
        for item in self._hitTestList:
            if self._containsCursorToItem(item):
                return False

        titleBar = self.window().property("titleBarItem")
        if titleBar and self._containsCursorToItem(titleBar):
            return True
        return False
