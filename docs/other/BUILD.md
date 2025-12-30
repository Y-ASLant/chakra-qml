# Chakra QML 构建指南

本文档说明如何构建和打包 Chakra QML 项目。

## 项目结构

```
chakra-qml/
├── src/                    # 源代码
│   ├── Chakra/            # QML 组件
│   │   ├── *.qml          # 组件文件
│   │   ├── qmldir         # 自动生成
│   │   └── Chakra.qrc     # 自动生成
│   └── __init__.py
├── utils/                  # 构建工具包
│   └── src/utils/
│       ├── __init__.py
│       └── update_resource.py
├── examples/              # 示例应用
├── pyproject.toml         # 项目配置
└── BUILD.md               # 本文档
```

## 环境设置

### 安装依赖

```bash
# 使用 uv 安装所有依赖（包括开发工具）
uv sync --group dev
```

## 构建流程

### 1. 开发时构建

每次添加或修改 QML 组件后运行：

```bash
uv run build-chakra
```

这会自动：
- 扫描 `src/Chakra/` 下的所有 `.qml` 文件
- 生成 `src/Chakra/qmldir` 文件（组件注册）

### 2. 打包发布

```bash
# Step 1: 构建资源
uv run build-chakra

# Step 2: 构建分发包
uv build

# Step 3: 检查构建产物
ls dist/

# Step 4: 发布到 PyPI
uv publish dist/*
```

## 构建工具详解

### build-chakra 命令

定义在 `utils/pyproject.toml`:

```toml
[project.scripts]
build-chakra = "utils:build"
```

执行流程：
1. **生成 qmldir**：自动发现所有 QML 组件并注册
   ```
   module Chakra
   prefer :/Chakra/
   
   CButton 1.0 CButton.qml
   CInput 1.0 CInput.qml
   ...
   ```

2. **打包方式**
   
QML 文件作为源文件直接打包到 wheel 中，无需编译成二进制资源。这样：
- 打包体积更小（~260 KB）
- 用户可以查看和修改 QML 源码
- 更符合 QML 库的使用习惯

### 手动使用构建工具

```python
from utils import gen_qmldir

# 生成 qmldir
gen_qmldir("src/Chakra", "Chakra", "1.0")

# 生成 .qrc
gen_qrc("src/Chakra", "/Chakra")

# 编译所有 .qrc
update_qrcs("src")
```

## 打包配置

### pyproject.toml 关键配置

```toml
[tool.setuptools.package-data]
"chakra.Chakra" = [
    "*.qml",              # QML 组件源文件
    "qmldir",             # 模块定义
    "fonts/*.ttf"         # 字体文件
]
```

## 版本管理

版本号在两处保持一致：
1. `pyproject.toml` 的 `version` 字段
2. `src/__init__.py` 的 `__version__` 变量

发布前更新版本：
```bash
# 编辑版本号
vim pyproject.toml
vim src/__init__.py

# 提交
git add .
git commit -m "chore: bump version to x.x.x"
git tag vx.x.x
git push --tags
```

## 故障排查

### 问题：找不到 pyside6-rcc

**解决**：确保已安装 PySide6
```bash
uv add pyside6
```

### 问题：qmldir 未更新

**解决**：删除旧文件重新生成
```bash
rm src/Chakra/qmldir
uv run build-chakra
```

### 问题：打包后 QML 文件找不到

**解决**：检查 `package-data` 是否包含 `*.qml`
```bash
# 检查打包内容
unzip -l dist/*.whl
```

## 工作空间

项目使用 uv 工作空间管理多个包：

```toml
[tool.uv.workspace]
members = ["examples", "utils"]
```

- `utils`: 构建工具包
- `examples`: 示例应用（不会被打包）

## 参考资料

- [PySide6 文档](https://doc.qt.io/qtforpython/)
- [Qt Resource System](https://doc.qt.io/qt-6/resources.html)
- [QML Modules](https://doc.qt.io/qt-6/qtqml-modules-topic.html)
