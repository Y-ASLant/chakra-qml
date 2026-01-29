pragma Singleton
import QtQuick

QtObject {
    id: root

    // ========== 主题系统 (Theme System) ==========
    // 公开的主题状态（只读，通过 setTheme/toggleTheme 修改）
    readonly property bool isDark: _confirmedDark

    // 内部状态：待确认的主题值
    property bool _pendingDark: false
    // 内部状态：已确认生效的主题值（所有颜色绑定到此属性）
    property bool _confirmedDark: false
    // 内部状态：是否正在批量更新中
    property bool _isBatchUpdating: false

    // 主题切换信号
    signal themeChanging(bool toDark)  // 主题即将切换（切换前触发）
    signal themeChanged(bool isDark)   // 主题切换完成（切换后触发）

    // 批量更新 Timer - 将多次属性变更合并到一帧
    property Timer _batchTimer: Timer {
        interval: 0  // 下一帧执行
        repeat: false
        onTriggered: root._commitThemeChange()
    }

    // 切换主题（推荐使用）
    function toggleTheme() {
        setTheme(!_confirmedDark);
    }

    // 设置主题
    function setTheme(dark) {
        if (_pendingDark === dark && !_batchTimer.running) {
            return;  // 无变化
        }
        _pendingDark = dark;
        themeChanging(dark);
        _batchTimer.restart();
    }

    // 批量更新：在回调中进行多个主题相关操作，然后一次性应用
    // 用法: AppStyle.batchUpdate(() => { AppStyle.setTheme(true); /* 其他操作 */ })
    function batchUpdate(callback) {
        _isBatchUpdating = true;
        _batchTimer.stop();
        try {
            callback();
        } finally {
            _isBatchUpdating = false;
            if (_pendingDark !== _confirmedDark) {
                _batchTimer.restart();
            }
        }
    }

    // 内部：提交主题变更
    function _commitThemeChange() {
        if (_confirmedDark !== _pendingDark) {
            _confirmedDark = _pendingDark;
            // 更新依赖主题的颜色映射表
            _updateThemeColors();
            themeChanged(_confirmedDark);
        }
    }

    // ========== 预计算颜色映射表 (Precomputed Color Maps) ==========
    // 深色模式颜色
    readonly property var _darkColors: ({
        successLight: "#1C4532",
        warningLight: "#652B19",
        errorLight: "#63171B",
        infoLight: "#1A365D",
        grayLight: "#2D3748",
        redLight: "#63171B",
        greenLight: "#1C4532",
        blueLight: "#1A365D",
        tealLight: "#1D4044",
        pinkLight: "#521B41",
        purpleLight: "#322659",
        cyanLight: "#065666",
        orangeLight: "#652B19",
        yellowLight: "#5F370E",
        backgroundColor: "#1A202C",
        surfaceColor: "#2D3748",
        textColor: "#F7FAFC",
        textSecondary: "#A0AEC0",
        textMuted: "#718096",
        borderColor: "#4A5568"
    })

    // 浅色模式颜色
    readonly property var _lightColors: ({
        successLight: "#C6F6D5",
        warningLight: "#FEEBC8",
        errorLight: "#FED7D7",
        infoLight: "#BEE3F8",
        grayLight: "#EDF2F7",
        redLight: "#FED7D7",
        greenLight: "#C6F6D5",
        blueLight: "#BEE3F8",
        tealLight: "#B2F5EA",
        pinkLight: "#FED7E2",
        purpleLight: "#E9D8FD",
        cyanLight: "#C4F1F9",
        orangeLight: "#FEEBC8",
        yellowLight: "#FEFCBF",
        backgroundColor: "#EDF2F7",
        surfaceColor: "#FFFFFF",
        textColor: "#1A202C",
        textSecondary: "#718096",
        textMuted: "#A0AEC0",
        borderColor: "#E2E8F0"
    })

    // 当前主题颜色（通过映射表快速查找，避免重复三元运算）
    property var _currentThemeColors: _lightColors

    function _updateThemeColors() {
        _currentThemeColors = _confirmedDark ? _darkColors : _lightColors;
    }

    // ========== 颜色系统 (Color System) ==========
    // 主色调（不受主题影响）
    readonly property color primaryColor: "#3182CE"
    readonly property color primaryHover: "#2B6CB0"
    readonly property color primaryActive: "#2C5282"

    // 次要色（不受主题影响）
    readonly property color secondaryColor: "#718096"
    readonly property color secondaryHover: "#4A5568"
    readonly property color secondaryActive: "#2D3748"

    // 成功/警告/错误/信息（使用映射表查找）
    readonly property color successColor: "#38A169"
    readonly property color successLight: _currentThemeColors.successLight
    readonly property color warningColor: "#DD6B20"
    readonly property color warningLight: _currentThemeColors.warningLight
    readonly property color errorColor: "#E53E3E"
    readonly property color errorLight: _currentThemeColors.errorLight
    readonly property color infoColor: "#3182CE"
    readonly property color infoLight: _currentThemeColors.infoLight

    // ========== 扩展颜色系统 (Extended Colors) ==========
    // Gray
    readonly property color grayColor: "#718096"
    readonly property color grayHover: "#4A5568"
    readonly property color grayLight: _currentThemeColors.grayLight

    // Red
    readonly property color redColor: "#E53E3E"
    readonly property color redHover: "#C53030"
    readonly property color redLight: _currentThemeColors.redLight

    // Green
    readonly property color greenColor: "#38A169"
    readonly property color greenHover: "#2F855A"
    readonly property color greenLight: _currentThemeColors.greenLight

    // Blue
    readonly property color blueColor: "#3182CE"
    readonly property color blueHover: "#2B6CB0"
    readonly property color blueLight: _currentThemeColors.blueLight

    // Teal
    readonly property color tealColor: "#319795"
    readonly property color tealHover: "#2C7A7B"
    readonly property color tealLight: _currentThemeColors.tealLight

    // Pink
    readonly property color pinkColor: "#D53F8C"
    readonly property color pinkHover: "#B83280"
    readonly property color pinkLight: _currentThemeColors.pinkLight

    // Purple
    readonly property color purpleColor: "#805AD5"
    readonly property color purpleHover: "#6B46C1"
    readonly property color purpleLight: _currentThemeColors.purpleLight

    // Cyan
    readonly property color cyanColor: "#00B5D8"
    readonly property color cyanHover: "#00A3C4"
    readonly property color cyanLight: _currentThemeColors.cyanLight

    // Orange
    readonly property color orangeColor: "#DD6B20"
    readonly property color orangeHover: "#C05621"
    readonly property color orangeLight: _currentThemeColors.orangeLight

    // Yellow
    readonly property color yellowColor: "#D69E2E"
    readonly property color yellowHover: "#B7791F"
    readonly property color yellowLight: _currentThemeColors.yellowLight

    // 背景色（使用映射表查找）
    readonly property color backgroundColor: _currentThemeColors.backgroundColor
    readonly property color surfaceColor: _currentThemeColors.surfaceColor
    readonly property color overlayColor: Qt.rgba(0, 0, 0, 0.48)

    // 文字颜色（使用映射表查找）
    readonly property color textColor: _currentThemeColors.textColor
    readonly property color textSecondary: _currentThemeColors.textSecondary
    readonly property color textMuted: _currentThemeColors.textMuted
    readonly property color textLight: "#FFFFFF"

    // 边框颜色（使用映射表查找）
    readonly property color borderColor: _currentThemeColors.borderColor
    readonly property color borderFocus: "#3182CE"
    readonly property color borderError: "#E53E3E"

    // ========== 字体系统 (Typography) ==========
    readonly property int fontSizeXs: 12
    readonly property int fontSizeSm: 14
    readonly property int fontSizeMd: 16
    readonly property int fontSizeLg: 18
    readonly property int fontSizeXl: 20
    readonly property int fontSize2xl: 24
    readonly property int fontSize3xl: 30
    readonly property int fontSize4xl: 36

    readonly property int fontWeightNormal: Font.Normal
    readonly property int fontWeightMedium: Font.Medium
    readonly property int fontWeightBold: Font.Bold

    // ========== 间距系统 (Spacing) ==========
    readonly property int spacing1: 4
    readonly property int spacing2: 8
    readonly property int spacing3: 12
    readonly property int spacing4: 16
    readonly property int spacing5: 20
    readonly property int spacing6: 24
    readonly property int spacing8: 32
    readonly property int spacing10: 40
    readonly property int spacing12: 48

    // ========== 圆角系统 (Border Radius) ==========
    readonly property int radiusNone: 0
    readonly property int radiusSm: 4
    readonly property int radiusMd: 6
    readonly property int radiusLg: 8
    readonly property int radiusXl: 12
    readonly property int radius2xl: 16
    readonly property int radiusFull: 9999
    readonly property int windowRadius: 8  // 窗口圆角（用于遮罩层等）

    // ========== 阴影系统 (Shadows) ==========
    readonly property string shadowSm: "0px 1px 2px rgba(0, 0, 0, 0.05)"
    readonly property string shadowMd: "0px 4px 6px rgba(0, 0, 0, 0.1)"
    readonly property string shadowLg: "0px 10px 15px rgba(0, 0, 0, 0.1)"
    readonly property string shadowXl: "0px 20px 25px rgba(0, 0, 0, 0.15)"

    // ========== 尺寸系统 (Sizes) ==========
    readonly property int buttonHeightSm: 32
    readonly property int buttonHeightMd: 40
    readonly property int buttonHeightLg: 48

    readonly property int inputHeightSm: 32
    readonly property int inputHeightMd: 40
    readonly property int inputHeightLg: 48
    readonly property int inputWidth: 300

    // ========== 动画系统 (Animations) ==========
    readonly property int durationInstant: 50    // 即时反馈（按压缩放）
    readonly property int durationXFast: 80      // 超快（弹出关闭）
    readonly property int durationFast: 150      // 快速
    readonly property int durationNormal: 200    // 正常
    readonly property int durationSlow: 300      // 慢速

    // ========== Z-Index 系统 ==========
    readonly property int zIndexDropdown: 1000
    readonly property int zIndexModal: 1400
    readonly property int zIndexTooltip: 1800

    // ========== 缓存映射表 (避免每次函数调用创建新对象) ==========
    readonly property var _schemeColors: ({
            "gray": grayColor,
            "red": redColor,
            "green": greenColor,
            "blue": blueColor,
            "teal": tealColor,
            "pink": pinkColor,
            "purple": purpleColor,
            "cyan": cyanColor,
            "orange": orangeColor,
            "yellow": yellowColor,
            "primary": primaryColor,
            "secondary": secondaryColor,
            "success": successColor,
            "warning": warningColor,
            "error": errorColor
        })

    readonly property var _schemeHovers: ({
            "gray": grayHover,
            "red": redHover,
            "green": greenHover,
            "blue": blueHover,
            "teal": tealHover,
            "pink": pinkHover,
            "purple": purpleHover,
            "cyan": cyanHover,
            "orange": orangeHover,
            "yellow": yellowHover,
            "primary": primaryHover,
            "secondary": secondaryHover,
            "success": successColor,
            "warning": warningColor,
            "error": errorColor
        })

    // _schemeLights 需要响应主题变化，通过函数获取
    // 映射 colorScheme 名称到 _currentThemeColors 中的键名
    readonly property var _schemeLightKeys: ({
            "gray": "grayLight",
            "red": "redLight",
            "green": "greenLight",
            "blue": "blueLight",
            "teal": "tealLight",
            "pink": "pinkLight",
            "purple": "purpleLight",
            "cyan": "cyanLight",
            "orange": "orangeLight",
            "yellow": "yellowLight",
            "primary": "infoLight",
            "secondary": "grayLight",
            "success": "successLight",
            "warning": "warningLight",
            "error": "errorLight"
        })

    readonly property var _buttonHeights: ({
            "sm": buttonHeightSm,
            "md": buttonHeightMd,
            "lg": buttonHeightLg
        })
    readonly property var _inputHeights: ({
            "sm": inputHeightSm,
            "md": inputHeightMd,
            "lg": inputHeightLg
        })
    readonly property var _fontSizes: ({
            "xs": fontSizeXs,
            "sm": fontSizeSm,
            "md": fontSizeMd,
            "lg": fontSizeLg,
            "xl": fontSizeXl
        })
    readonly property var _boxSizes: ({
            "sm": 16,
            "md": 20,
            "lg": 24
        })
    readonly property var _switchTrackWidths: ({
            "sm": 32,
            "md": 44,
            "lg": 52
        })
    readonly property var _switchTrackHeights: ({
            "sm": 18,
            "md": 24,
            "lg": 28
        })
    readonly property var _progressHeights: ({
            "xs": 4,
            "sm": 8,
            "md": 12,
            "lg": 16
        })
    readonly property var _tagHeights: ({
            "sm": 20,
            "md": 26,
            "lg": 32
        })
    readonly property var _badgeFontSizes: ({
            "sm": fontSizeXs,
            "md": fontSizeSm,
            "lg": fontSizeMd
        })
    readonly property var _paddingHs: ({
            "sm": spacing1,
            "md": spacing2,
            "lg": spacing3
        })
    readonly property var _spinnerSizes: ({
            "xs": 12,
            "sm": 16,
            "md": 24,
            "lg": 32,
            "xl": 48
        })
    readonly property var _spinnerThicknesses: ({
            "xs": 2,
            "sm": 2,
            "md": 3,
            "lg": 4,
            "xl": 4
        })
    readonly property var _segmentHeights: ({
            "xs": 24,
            "sm": 28,
            "md": 32,
            "lg": 40
        })
    readonly property var _cardPaddings: ({
            "sm": spacing3,
            "md": spacing4,
            "lg": spacing6
        })
    readonly property var _menuItemHeights: ({
            "sm": 32,
            "md": 38,
            "lg": 44
        })
    readonly property var _containerMaxWidths: ({
            "sm": 640,
            "md": 768,
            "lg": 1024,
            "xl": 1280
        })
    readonly property var _dialogWidths: ({
            "xs": 320,
            "sm": 400,
            "md": 512,
            "lg": 640,
            "xl": 768
        })

    // ========== 辅助函数 (使用缓存映射表) ==========
    function getSchemeColor(scheme) {
        return _schemeColors[scheme] || blueColor;
    }
    function getSchemeHover(scheme) {
        return _schemeHovers[scheme] || blueHover;
    }
    function getSchemeLight(scheme) {
        var key = _schemeLightKeys[scheme] || "blueLight";
        return _currentThemeColors[key] || _currentThemeColors.blueLight;
    }
    function getButtonHeight(size) {
        return _buttonHeights[size] || buttonHeightMd;
    }
    function getInputHeight(size) {
        return _inputHeights[size] || inputHeightMd;
    }
    function getFontSize(size) {
        return _fontSizes[size] || fontSizeMd;
    }
    function getBoxSize(size) {
        return _boxSizes[size] || 20;
    }
    function getSwitchTrackWidth(size) {
        return _switchTrackWidths[size] || 44;
    }
    function getSwitchTrackHeight(size) {
        return _switchTrackHeights[size] || 24;
    }
    function getProgressHeight(size) {
        return _progressHeights[size] || 12;
    }
    function getTagHeight(size) {
        return _tagHeights[size] || 26;
    }
    function getBadgeFontSize(size) {
        return _badgeFontSizes[size] || fontSizeSm;
    }
    function getPaddingH(size) {
        return _paddingHs[size] || spacing2;
    }
    function getSpinnerSize(size) {
        return _spinnerSizes[size] || 24;
    }
    function getSpinnerThickness(size) {
        return _spinnerThicknesses[size] || 3;
    }
    function getSegmentHeight(size) {
        return _segmentHeights[size] || 32;
    }
    function getCardPadding(size) {
        return _cardPaddings[size] || spacing4;
    }
    function getMenuItemHeight(size) {
        return _menuItemHeights[size] || 38;
    }
    function getContainerMaxWidth(size) {
        return _containerMaxWidths[size] || 1024;
    }
    function getDialogWidth(size) {
        return _dialogWidths[size] || 512;
    }

    // 公共辅助函数：自动设置容器子元素宽度
    function updateChildrenWidth(container, targetWidth) {
        for (let i = 0; i < container.children.length; i++) {
            let child = container.children[i];
            if (child && child.implicitWidth !== undefined) {
                child.width = Qt.binding(() => targetWidth);
            }
        }
    }
}
