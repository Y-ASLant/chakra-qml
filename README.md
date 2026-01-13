# Chakra UI QML

A modern, accessible, and customizable QML component library inspired by [Chakra UI](https://chakra-ui.com/).

English | [简体中文](README.zh-CN.md)

## Features

- 🎨 **40+ Components** - Buttons, Inputs, Cards, Menus, Dialogs and more
- 🌓 **Dark Mode** - Built-in theme system with light/dark modes
- ⚡ **High Performance** - Optimized rendering with minimal overhead
- 🪟 **Frameless Window** - Native Windows DWM shadow and custom title bar
- 🎯 **Type Safe** - Full PySide6 integration with type hints
- 📱 **Responsive** - Adaptive layouts and sizing system
- ♿ **Accessible** - ARIA-compliant components (where applicable)

## Installation

```bash
pip install chakra-qml
```

## Quick Start

### Basic Usage

```python
import sys
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtQuickControls2 import QQuickStyle
from chakra import init

QQuickStyle.setStyle("Basic")
app = QGuiApplication(sys.argv)
engine = QQmlApplicationEngine()
init(engine)  # 注册 Chakra 组件
engine.load("main.qml")
sys.exit(app.exec())
```

### QML Example

```qml
import QtQuick
import Chakra

CWindow {
    width: 800
    height: 600
    title: "My App"
    
    Column {
        spacing: 16
        anchors.centerIn: parent
        
        CButton {
            text: "Click Me"
            colorScheme: "blue"
            onClicked: console.log("Clicked!")
        }
        
        CInput {
            placeholderText: "Enter text..."
            variant: "outline"
        }
        
        CCard {
            title: "Welcome"
            description: "This is a Chakra UI component"
            width: 300
        }
    }
}
```

## Available Components

### Layout
- `CBox` - Flexible container with styling props
- `CFlex` - Flexbox layout container
- `CFlow` - Flow layout for wrapping items
- `CCenter` - Center alignment container
- `CContainer` - Responsive container with max-width
- `CSpacer` - Flexible spacer component

### Forms
- `CButton` - Versatile button with variants and sizes
- `CInput` - Text input with validation states
- `CCheckbox` - Checkbox with indeterminate state
- `CSwitch` - Toggle switch with labels
- `CSelect` - Dropdown select with search

### Data Display
- `CCard` - Content card with header/footer
- `CBadge` - Small status indicator
- `CTag` - Removable tag component
- `CProgress` - Progress bar with variants
- `CSpinner` - Loading spinner
- `CIcon` - Icon component with 1000+ Phosphor icons

### Feedback
- `CAlert` - Alert messages with status
- `CTooltip` - Hover tooltip
- `CHoverCard` - Hover card with rich content

### Overlay
- `CDialog` - Modal dialog
- `CDrawer` - Side drawer/panel
- `CMenu` - Dropdown menu
- `CMenuGroup` - Menu group container
- `CMenuItem` - Menu item component
- `CMenuSeparator` - Menu separator

### Navigation
- `CPagination` - Pagination controls
- `CSegmentedControl` - Segmented picker

### Scrolling
- `CScrollBar` - Custom scrollbar
- `CScrollArea` - Scrollable area
- `CListView` - Optimized list view
- `CGridView` - Optimized grid view

### Other
- `CWindow` - Frameless window with native shadow
- `CActionBar` - Floating action bar

## Theme Customization

The library uses a centralized `AppStyle` singleton for theming:

```qml
// Toggle theme
AppStyle.toggleTheme()

// Check current theme
if (AppStyle.isDark) {
    // Dark mode
}

// Access theme colors
color: AppStyle.primaryColor
color: AppStyle.textColor
color: AppStyle.backgroundColor
```

## Component Props

### CButton

```qml
CButton {
    text: "Button"
    variant: "solid"        // solid, outline, ghost, link
    colorScheme: "blue"     // blue, green, red, purple, etc.
    size: "md"              // sm, md, lg
    leftIcon: "check"
    rightIcon: "arrow-right"
    isLoading: false
    fullWidth: false
}
```

### CInput

```qml
CInput {
    placeholderText: "Enter text"
    variant: "outline"      // outline, filled, flushed
    size: "md"              // sm, md, lg
    isInvalid: false
    isDisabled: false
    isClearable: true
    type: "text"            // text, password
}
```

### CCard

```qml
CCard {
    title: "Card Title"
    description: "Card description"
    variant: "elevated"     // elevated, outline, filled, subtle
    size: "md"              // sm, md, lg
    
    // Custom content
    CButton { text: "Action" }
}
```

## Frameless Window

Create modern frameless windows with native Windows shadow:

```qml
import Chakra

CWindow {
    width: 1280
    height: 800
    title: "My App"
    
    showTitleBar: true
    showThemeToggle: true
    showMinimize: true
    showMaximize: true
    showClose: true
    shadowEnabled: true     // Native DWM shadow on Windows
    
    // Your content here
}
```

## Performance

This library is optimized for performance:

- ✅ No unnecessary `layer.effect` usage
- ✅ Efficient property bindings
- ✅ Cached color mappings in `AppStyle`
- ✅ Native Windows API for frameless window
- ✅ Minimal animation overhead

## Examples

Check the `gallery` folder for a complete component showcase, or the `examples` folder for usage examples:

- Basic components showcase
- Form validation
- Icon browser
- Dashboard layouts

## Requirements

- Python >= 3.8
- PySide6 >= 6.5.0

## Testing

This library includes a comprehensive test suite for both QML components and Python modules.

### Running Tests

```bash
# Run QML component tests
python tests/run_qml_tests.py

# Run Python unit tests
python tests/run_python_tests.py
```

See [tests/README.md](tests/README.md) for detailed testing documentation.

## License

MIT License - see [LICENSE](LICENSE) file for details

## Development

### Building from Source

```bash
# Install dependencies
uv sync --group dev

# Build QML module (auto-generate qmldir)
uv run build-chakra

# Package for distribution
uv build

# Install locally for testing
uv add dist/chakra_qml-*.whl
```

The `build-chakra` command automatically:
- Scans all `.qml` files in `src/Chakra/`
- Detects singleton components (files with `pragma Singleton`)
- Generates `qmldir` module definition

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Credits

Inspired by [Chakra UI](https://chakra-ui.com/) by Segun Adebayo.
