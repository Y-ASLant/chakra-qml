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

# Qt 边缘枚举值（Qt.Edge 枚举的值）
TOP_EDGE = 0x00001
BOTTOM_EDGE = 0x00008
LEFT_EDGE = 0x00002
RIGHT_EDGE = 0x00004

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

    # Windows 常量
    GWL_STYLE = -16
    WS_CAPTION = 0x00C00000
    WS_THICKFRAME = 0x00040000
    WS_MAXIMIZEBOX = 0x00010000

    SWP_FRAMECHANGED = 0x0020
    SWP_NOMOVE = 0x0002
    SWP_NOSIZE = 0x0001
    SWP_NOZORDER = 0x0004
    SWP_NOACTIVATE = 0x0100

    WM_WINDOWPOSCHANGING = 0x0046
    WM_NCCALCSIZE = 0x0083
    WM_NCHITTEST = 0x0084
    WM_GETMINMAXINFO = 0x0024

    WVR_REDRAW = 0x0001

    HTCLIENT = 1
    HTCAPTION = 2

    HTLEFT = 10
    HTRIGHT = 11
    HTTOP = 12
    HTTOPLEFT = 13
    HTTOPRIGHT = 14
    HTBOTTOM = 15
    HTBOTTOMLEFT = 16
    HTBOTTOMRIGHT = 17

    SPI_GETWORKAREA = 0x0030

    SM_CXFRAME = 32
    SM_CYFRAME = 33
    SM_CXPADDEDBORDER = 92

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

    GetSystemMetrics = user32.GetSystemMetrics
    GetSystemMetrics.argtypes = [c_int]
    GetSystemMetrics.restype = c_int

    DwmExtendFrameIntoClientArea = dwmapi.DwmExtendFrameIntoClientArea
    DwmExtendFrameIntoClientArea.argtypes = [c_void_p, c_void_p]
    DwmExtendFrameIntoClientArea.restype = c_long

    def setShadow(hwnd):
        margins = MARGINS(1, 0, 0, 0)
        DwmExtendFrameIntoClientArea(hwnd, byref(margins))

    def applyFramelessStyle(hwnd):
        style = GetWindowLongPtrW(hwnd, GWL_STYLE)
        SetWindowLongPtrW(
            hwnd, GWL_STYLE, style | WS_CAPTION | WS_THICKFRAME | WS_MAXIMIZEBOX
        )
        SetWindowPos(
            hwnd,
            None,
            0,
            0,
            0,
            0,
            SWP_FRAMECHANGED | SWP_NOMOVE | SWP_NOSIZE | SWP_NOZORDER | SWP_NOACTIVATE,
        )
        setShadow(hwnd)

    def toSignedInt16(value):
        """将 16 位无符号整数转换为有符号整数，用于处理负坐标"""
        signed = c_int(c_uint16(value).value).value
        return signed - 65536 if signed > 32767 else signed


class CFrameless(QQuickItem, QAbstractNativeEventFilter):
    disabledChanged = Signal()

    def __init__(self):
        QQuickItem.__init__(self)
        QAbstractNativeEventFilter.__init__(self)
        self._current = 0
        self._edges = 0
        self._margins = 4  # 减小调整大小的敏感区域
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
        app = QGuiApplication.instance()
        if app is not None:
            app.removeNativeEventFilter(self)

    @Slot()
    def refreshShadow(self):
        """窗口重新显示时刷新 DWM 阴影"""
        if sys.platform == "win32" and self.window():
            hwnd = self.window().winId()
            if hwnd:
                applyFramelessStyle(hwnd)
                self._current = hwnd

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
            app = QGuiApplication.instance()
            if app is not None:
                app.installNativeEventFilter(self)
            applyFramelessStyle(self.window().winId())

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

        if uMsg == WM_WINDOWPOSCHANGING:
            return self._handleWindowPosChanging(msg.lParam)

        if uMsg == WM_NCCALCSIZE:
            return self._handleNcCalcSize(hwnd, msg.wParam, msg.lParam)

        if uMsg == WM_NCHITTEST:
            return self._handleNcHitTest(hwnd, msg.lParam)

        if uMsg == WM_GETMINMAXINFO:
            return self._handleGetMinMaxInfo(msg.lParam)

        return False, 0

    def _handleWindowPosChanging(self, lParam):
        wp = cast(lParam, POINTER(PWINDOWPOS)).contents
        if wp is not None and ((wp.flags & SWP_NOZORDER) == 0):
            wp.flags |= SWP_NOACTIVATE
        return False, 0

    def _handleNcCalcSize(self, hwnd, wParam, lParam):
        if wParam and lParam:
            isMaximum = bool(IsZoomed(hwnd))
            if isMaximum:
                params = cast(lParam, LPNCCALCSIZE_PARAMS).contents
                frameX = GetSystemMetrics(SM_CXFRAME) + GetSystemMetrics(
                    SM_CXPADDEDBORDER
                )
                frameY = GetSystemMetrics(SM_CYFRAME) + GetSystemMetrics(
                    SM_CXPADDEDBORDER
                )

                params.rgrc[0].left += frameX
                params.rgrc[0].top += frameY
                params.rgrc[0].right -= frameX
                params.rgrc[0].bottom -= frameY
            return True, 0
        return False, 0

    def _handleNcHitTest(self, hwnd, lParam):
        # 修复副屏坐标溢出：使用有符号整数处理负坐标
        x_signed = toSignedInt16(LOWORD(lParam))
        y_signed = toSignedInt16(HIWORD(lParam))

        nativeLocalPos = POINT(x_signed, y_signed)
        ScreenToClient(hwnd, byref(nativeLocalPos))

        pixelRatio = self.window().devicePixelRatio()
        logicalX = nativeLocalPos.x / pixelRatio
        logicalY = nativeLocalPos.y / pixelRatio

        clientWidth = self.window().width()
        clientHeight = self.window().height()
        margins = self._margins

        left = logicalX < margins
        right = logicalX > clientWidth - margins
        top = logicalY < margins
        bottom = logicalY > clientHeight - margins

        if not self._isFullScreen() and not self._isMaximized():
            result = self._getHitTestResult(left, right, top, bottom)
            if result != 0:
                return True, result

        if self._hitTitleBar():
            return True, HTCAPTION
        return True, HTCLIENT

    def _getHitTestResult(self, left, right, top, bottom):
        """根据边缘位置返回对应的 Hit Test 值"""
        if left and top:
            return HTTOPLEFT
        if left and bottom:
            return HTBOTTOMLEFT
        if right and top:
            return HTTOPRIGHT
        if right and bottom:
            return HTBOTTOMRIGHT
        if left:
            return HTLEFT
        if right:
            return HTRIGHT
        if top:
            return HTTOP
        if bottom:
            return HTBOTTOM
        return 0

    def _handleGetMinMaxInfo(self, lParam):
        minmaxInfo = cast(lParam, POINTER(MINMAXINFO)).contents
        pixelRatio = self.window().devicePixelRatio()
        geometry = self.window().screen().availableGeometry()
        rect = RECT()
        SystemParametersInfoW(SPI_GETWORKAREA, 0, byref(rect), 0)
        minmaxInfo.ptMaxPosition.x = rect.left
        minmaxInfo.ptMaxPosition.y = rect.top
        minmaxInfo.ptMaxSize.x = int(geometry.width() * pixelRatio)
        minmaxInfo.ptMaxSize.y = int(geometry.height() * pixelRatio)
        return False, 0

    def eventFilter(self, watched, event):
        if self.window() is None:
            return False

        eventType = event.type()

        if eventType == QEvent.Type.MouseButtonPress:
            return self._handleMouseButtonPress(event)

        if eventType == QEvent.Type.MouseButtonRelease:
            self._edges = 0
            return False

        if eventType == QEvent.Type.MouseMove:
            return self._handleMouseMove(event)

        return False

    def _handleMouseButtonPress(self, event):
        mouseEvent = QMouseEvent(event)
        if mouseEvent.button() != Qt.MouseButton.LeftButton:
            return False

        if self._edges != 0:
            self._updateCursor(self._edges)
            self.window().startSystemResize(Qt.Edge(self._edges))
            return False

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

        return False

    def _handleMouseMove(self, event):
        if self._isMaximized() or self._isFullScreen():
            return False

        p = QMouseEvent(event).position().toPoint()
        win = self.window()
        margins = self._margins

        # 检查是否在内部区域
        inInterior = (
            margins <= p.x() <= win.width() - margins
            and margins <= p.y() <= win.height() - margins
        )
        if inInterior:
            if self._edges != 0:
                self._edges = 0
                self._updateCursor(self._edges)
            return False

        # 计算边缘
        self._edges = self._calcResizeEdges(p, win.width(), win.height(), margins)
        self._updateCursor(self._edges)
        return False

    def _calcResizeEdges(self, pos, width, height, margins):
        """计算鼠标位置对应的调整大小边缘"""
        edges = 0
        if pos.x() < margins:
            edges |= LEFT_EDGE
        if pos.x() > width - margins:
            edges |= RIGHT_EDGE
        if pos.y() < margins:
            edges |= TOP_EDGE
        if pos.y() > height - margins:
            edges |= BOTTOM_EDGE
        return edges

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
        cursorMap = {
            0: Qt.CursorShape.ArrowCursor,
            LEFT_EDGE: Qt.CursorShape.SizeHorCursor,
            RIGHT_EDGE: Qt.CursorShape.SizeHorCursor,
            TOP_EDGE: Qt.CursorShape.SizeVerCursor,
            BOTTOM_EDGE: Qt.CursorShape.SizeVerCursor,
            LEFT_EDGE | TOP_EDGE: Qt.CursorShape.SizeFDiagCursor,
            RIGHT_EDGE | BOTTOM_EDGE: Qt.CursorShape.SizeFDiagCursor,
            RIGHT_EDGE | TOP_EDGE: Qt.CursorShape.SizeBDiagCursor,
            LEFT_EDGE | BOTTOM_EDGE: Qt.CursorShape.SizeBDiagCursor,
        }
        self.window().setCursor(cursorMap.get(edges, Qt.CursorShape.ArrowCursor))

    def _hitTitleBar(self):
        for item in self._hitTestList:
            if self._containsCursorToItem(item):
                return False

        titleBar = self.window().property("titleBarItem")
        if titleBar and self._containsCursorToItem(titleBar):
            return True
        return False
