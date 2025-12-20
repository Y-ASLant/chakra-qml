"""
Chakra UI QML - A modern QML component library inspired by Chakra UI

This package provides a comprehensive set of QML components with a focus on
accessibility, themability, and developer experience.
"""

from .. import __version__, __author__

from .CFrameless import CFrameless

COMPONENTS = [
    "CActionBar", "CAlert", "CBadge", "CBox", "CButton", "CCard",
    "CCenter", "CCheckbox", "CContainer", "CDialog", "CDrawer",
    "CFlex", "CIcon", "CInput", "CMenu", "CMenuItem", "CMenuGroup",
    "CMenuSeparator", "CPagination", "CProgress", "CScrollArea",
    "CScrollBar", "CSegmentedControl", "CSelect", "CSpinner",
    "CSwitch", "CTag", "CTooltip", "CWindow"
]

__all__ = [
    "CFrameless", 
    "init", 
    "setup",
    "register_types",
    "add_import_path",
    "get_component_path",
    "COMPONENTS", 
    "__version__", 
    "__author__"
]


def get_component_path():
    """Get the absolute path to the QML components directory."""
    import os
    return os.path.dirname(os.path.abspath(__file__))


def register_types(module_name="Chakra", major_version=1, minor_version=0):
    """
    Register all Python QML types.
    
    Args:
        module_name: QML module name (default: "Chakra")
        major_version: Major version (default: 1)
        minor_version: Minor version (default: 0)
    
    Example:
        from chakra import register_types
        register_types()
    """
    from PySide6.QtQml import qmlRegisterType
    qmlRegisterType(CFrameless, module_name, major_version, minor_version, "CFrameless")


register_qml_types = register_types


def add_import_path(engine):
    """
    Add Chakra component path to QML engine.
    
    Args:
        engine: QQmlApplicationEngine instance
    
    Example:
        from chakra import add_import_path
        add_import_path(engine)
    """
    import os
    component_path = get_component_path()
    chakra_path = os.path.dirname(component_path)
    engine.addImportPath(chakra_path)


setup_qml_import_path = add_import_path


def setup(engine=None, module_name="Chakra", major_version=1, minor_version=0):
    """
    Setup Chakra UI QML - register types and configure import path.
    
    Args:
        engine: QQmlApplicationEngine instance (optional, can add later)
        module_name: QML module name (default: "Chakra")
        major_version: Major version (default: 1)
        minor_version: Minor version (default: 0)
    
    Example:
        from PySide6.QtQml import QQmlApplicationEngine
        from chakra import setup
        
        engine = QQmlApplicationEngine()
        setup(engine)
    """
    register_types(module_name, major_version, minor_version)
    if engine is not None:
        add_import_path(engine)


def init(engine, module_name="Chakra", major_version=1, minor_version=0):
    """
    Initialize Chakra UI QML (alias for setup).
    
    Args:
        engine: QQmlApplicationEngine instance
        module_name: QML module name (default: "Chakra")
        major_version: Major version (default: 1)
        minor_version: Minor version (default: 0)
    
    Example:
        from PySide6.QtQml import QQmlApplicationEngine
        from chakra import init
        
        engine = QQmlApplicationEngine()
        init(engine)
    """
    setup(engine, module_name, major_version, minor_version)
