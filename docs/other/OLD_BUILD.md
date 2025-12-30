# 构建和安装指南

## 快速构建

### 1. 清理旧构建文件

```bash
# Windows
if exist dist rmdir /s /q dist
if exist build rmdir /s /q build
if exist chakra_qtquick.egg-info rmdir /s /q chakra_qtquick.egg-info

# Linux/macOS
rm -rf dist/ build/ *.egg-info
```

### 2. 构建 whl 包

```bash
python -m build
```

构建完成后，whl 文件会在 `dist/` 目录下：
- `dist/chakra_qtquick-1.0.0-py3-none-any.whl`
- `dist/chakra_qtquick-1.0.0.tar.gz`

### 3. 安装到本地

```bash
# 卸载旧版本（如果有）
pip uninstall chakra-qtquick -y

# 安装新构建的包
pip install dist/chakra_qtquick-1.0.0-py3-none-any.whl
```

### 4. 测试安装

```bash
# 测试导入
python -c "import chakra_ui; print(chakra_ui.__version__)"

# 运行示例
cd example
python main.py
```

## 一键构建脚本

### Windows (build.bat)

```batch
@echo off
echo Cleaning old builds...
if exist dist rmdir /s /q dist
if exist build rmdir /s /q build
if exist chakra_qtquick.egg-info rmdir /s /q chakra_qtquick.egg-info

echo Building package...
python -m build

echo Installing package...
pip uninstall chakra-qtquick -y
pip install dist\chakra_qtquick-1.0.0-py3-none-any.whl

echo Done!
echo Test with: python -c "import chakra_ui; print(chakra_ui.__version__)"
```

### Linux/macOS (build.sh)

```bash
#!/bin/bash
echo "Cleaning old builds..."
rm -rf dist/ build/ *.egg-info

echo "Building package..."
python -m build

echo "Installing package..."
pip uninstall chakra-qtquick -y
pip install dist/chakra_qtquick-1.0.0-py3-none-any.whl

echo "Done!"
echo "Test with: python -c \"import chakra_ui; print(chakra_ui.__version__)\""
```

## 常见问题

### 构建失败
确保安装了构建工具：
```bash
pip install build twine
```

### 导入失败
检查包是否正确安装：
```bash
pip list | grep chakra
```

### 版本不对
确保卸载了旧版本：
```bash
pip uninstall chakra-qtquick -y
pip cache purge
```

## 发布到 PyPI

详见 [PUBLISHING.md](PUBLISHING.md)
