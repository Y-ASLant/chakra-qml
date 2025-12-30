# Publishing Guide for Chakra UI QML

This guide explains how to build and publish the `chakra-qtquick` package to PyPI.

## Prerequisites

1. Install build tools:
```bash
pip install build twine
```

2. Get a PyPI account:
   - Register at https://pypi.org/account/register/
   - Generate an API token at https://pypi.org/manage/account/token/

3. Configure your PyPI credentials:
```bash
# Create or edit ~/.pypirc (Linux/macOS) or %USERPROFILE%\.pypirc (Windows)
[pypi]
username = __token__
password = pypi-YOUR_API_TOKEN_HERE
```

## Pre-Release Checklist

- [ ] Update version in `pyproject.toml`
- [ ] Update `__version__` in `src/components/__init__.py`
- [ ] Update `CHANGELOG.md` (if exists)
- [ ] Run tests (if any)
- [ ] Check that all QML files are included in `MANIFEST.in`
- [ ] Review `README.md` for accuracy
- [ ] Commit all changes to git

## Building the Package

### 1. Clean previous builds

```bash
# Windows
if exist dist rmdir /s /q dist
if exist build rmdir /s /q build
if exist *.egg-info rmdir /s /q *.egg-info

# Linux/macOS
rm -rf dist/ build/ *.egg-info
```

### 2. Build the distribution

```bash
python -m build
```

This creates two files in the `dist/` directory:
- `chakra_ui_qml-X.Y.Z-py3-none-any.whl` (wheel)
- `chakra_ui_qml-X.Y.Z.tar.gz` (source distribution)

### 3. Verify the package contents

```bash
# Check wheel contents
python -m zipfile -l dist/chakra_ui_qml-*.whl

# Check source distribution contents
tar -tzf dist/chakra_ui_qml-*.tar.gz
```

**Important:** Verify that all `.qml` files and `qmldir` are included!

## Testing Locally

Before publishing, test the package locally:

```bash
# Install in a virtual environment
python -m venv test-env
test-env\Scripts\activate  # Windows
# source test-env/bin/activate  # Linux/macOS

# Install from local wheel
pip install dist/chakra_ui_qml-*.whl

# Test import
python -c "from chakra_ui_qml import CFrameless, get_component_path; print(get_component_path())"

# Run a test app
python your_test_app.py
```

## Publishing

### Test PyPI (Recommended First)

1. Upload to Test PyPI:
```bash
python -m twine upload --repository testpypi dist/*
```

2. Install from Test PyPI:
```bash
pip install --index-url https://test.pypi.org/simple/ --extra-index-url https://pypi.org/simple/ chakra-qtquick
```

3. Test the installation thoroughly

### Production PyPI

When ready for production:

```bash
python -m twine upload dist/*
```

## Post-Release

1. Create a git tag:
```bash
git tag v0.1.0
git push origin v0.1.0
```

2. Create a GitHub release:
   - Go to https://github.com/Y-ASLant/chakra-qml/releases/new
   - Select the tag
   - Add release notes
   - Attach the wheel file

3. Announce the release:
   - Update project website/blog
   - Post on social media
   - Update documentation

## Version Numbering

Follow [Semantic Versioning](https://semver.org/):

- **MAJOR** (X.0.0): Breaking API changes
- **MINOR** (0.X.0): New features, backwards compatible
- **PATCH** (0.0.X): Bug fixes, backwards compatible

## Troubleshooting

### QML files not included

Check `MANIFEST.in` and `pyproject.toml` package data settings.

### Import errors after installation

Verify the package structure with:
```bash
pip show -f chakra-qtquick
```

### Windows-only features

Document platform-specific features (like CFrameless) in README.

## Automation with GitHub Actions (Optional)

Create `.github/workflows/publish.yml`:

```yaml
name: Publish to PyPI

on:
  release:
    types: [published]

jobs:
  publish:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-python@v4
        with:
          python-version: '3.10'
      - name: Install dependencies
        run: |
          pip install build twine
      - name: Build package
        run: python -m build
      - name: Publish to PyPI
        env:
          TWINE_USERNAME: __token__
          TWINE_PASSWORD: ${{ secrets.PYPI_API_TOKEN }}
        run: twine upload dist/*
```

## Quick Release Script

Create `scripts/release.sh` (Linux/macOS) or `scripts/release.bat` (Windows):

```bash
#!/bin/bash
set -e

VERSION=$1
if [ -z "$VERSION" ]; then
    echo "Usage: ./release.sh <version>"
    exit 1
fi

# Update version
sed -i "s/version = .*/version = \"$VERSION\"/" pyproject.toml
sed -i "s/__version__ = .*/__version__ = \"$VERSION\"/" src/components/__init__.py

# Build
rm -rf dist/ build/ *.egg-info
python -m build

# Test
pip install dist/*.whl

# Git
git add .
git commit -m "Release v$VERSION"
git tag "v$VERSION"

echo "Ready to publish!"
echo "Run: python -m twine upload dist/*"
```

## Support

For questions or issues, open an issue at:
https://github.com/Y-ASLant/chakra-qml/issues
