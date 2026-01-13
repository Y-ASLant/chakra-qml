# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概述

Chakra UI QML 是一个受 Chakra UI 启发的现代化 QML 组件库，基于 PySide6/Qt Quick。项目包含约 35 个 QML 组件，支持深色模式、无边框窗口等功能。

## 平台兼容性

| 功能 | Windows | macOS | Linux |
|------|---------|-------|-------|
| 35+ QML 组件（CButton、CInput 等） | ✅ | ✅ | ✅ |
| 主题系统（AppStyle） | ✅ | ✅ | ✅ |
| 图标系统（Icons） | ✅ | ✅ | ✅ |
| 无边框窗口（CWindow/CFrameless） | ✅ 原生 DWM 阴影 | ⚠️ 降级 | ⚠️ 降级 |

**说明**：CFrameless.py 使用 Windows DWM API 实现无边框窗口和原生阴影，非 Windows 平台会跳过这些特性。使用普通 Qt Window 可实现跨平台兼容。

## 常用命令

### 环境设置
```bash
uv sync --group dev
```

### 构建项目（重要！）
修改 QML 组件后必须运行此命令以更新 `qmldir`：
```bash
uv run build-chakra
```

### 代码质量检查（提交前必跑）
```bash
# 代码风格和 lint 检查（ruff）
ruff check src/

# 类型检查（ty）
ty check src/

# 自动修复 ruff 问题
ruff check --fix src/
```

### 测试
```bash
# 运行 QML 组件测试
python tests/run_qml_tests.py

# 运行 Python 单元测试
python tests/run_python_tests.py
```

### 打包发布
```bash
# 构建 QML 模块
uv run build-chakra

# 打包
uv build

# 发布
uv publish dist/*
```

### 运行示例
```bash
cd examples
python main.py
```

## 代码架构

### 目录结构
```
chakra-qml/
├── src/
│   ├── __init__.py        # Python 入口，导出 init(), CFrameless 等
│   └── Chakra/            # QML 组件目录
│       ├── *.qml          # QML 组件文件
│       ├── qmldir         # 模块定义（由 build-chakra 生成）
│       ├── CFrameless.py  # Python 无边框窗口类
│       └── __init__.py    # 组件注册函数
├── utils/                 # 构建工具包（workspace 成员）
├── examples/              # 示例应用（workspace 成员）
└── tests/                 # 测试文件
```

### 模块初始化流程
1. Python 端：`from chakra import init`
2. 调用 `init(engine)` 时：
   - 注册 Python QML 类型（如 CFrameless）
   - 将 `src/` 目录添加到 QML 导入路径
3. QML 端：`import Chakra` 即可使用所有组件

### QML 组件架构

#### AppStyle 单例
核心主题系统单例（`src/Chakra/AppStyle.qml`），提供：
- **颜色系统**：主色调、语义色（success/warning/error）、扩展色系
- **间距系统**：spacing1-spacing12
- **圆角系统**：radiusSm 到 radiusFull
- **尺寸映射**：通过 `getSchemeColor()`, `getButtonHeight()` 等函数访问
- **深色模式**：`isDark` 属性 + `toggleTheme()` 函数

所有组件应通过 AppStyle 获取颜色和尺寸，避免硬编码。

#### Icons 单例
图标系统（`src/Chakra/Icons.qml`），基于 Phosphor Icons，提供 1000+ 图标。

#### CFrameless（Python）
无边框窗口实现（`src/Chakra/CFrameless.py`），使用 Windows DWM API 实现原生阴影。

### 版本号同步
版本号需同时修改：
1. `pyproject.toml` 中的 `version` 字段
2. `src/__init__.py` 中的 `__version__` 变量

## 开发注意事项

1. **提交代码前**：必须通过 `ruff check src/` 和 `ty check src/` 检查
2. **修改 QML 组件后**：必须运行 `uv run build-chakra` 更新 qmldir
3. **添加新组件**：
   - 在 `src/Chakra/` 创建 `.qml` 文件
   - 运��� `build-chakra` 自动注册到 qmldir
   - 在 `src/Chakra/__init__.py` 的 `COMPONENTS` 列表中添加
4. **单例组件**：QML 文件需包含 `pragma Singleton`
5. **颜色获取**：使用 `AppStyle.getSchemeColor("blue")` 而非直接访问属性
6. **Qt 样式**：示例中使用 `QQuickStyle.setStyle("Basic")` 获得最佳效果

## 测试指南
- QML 测试使用 Qt Test 框架，文件放在 `tests/qml/`
- Python 测试使用标准 unittest，文件放在 `tests/python/`
- 参见 `tests/README.md` 了解测试编写规范
