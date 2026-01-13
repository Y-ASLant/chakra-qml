"""
Chakra UI QML - A modern QML component library inspired by Chakra UI

This package provides a comprehensive set of QML components with a focus on
accessibility, themability, and developer experience.
"""

__version__ = "0.1.0"
__author__ = "ASLant"

from .Chakra import (  # type: ignore[import-not-found]
    CFrameless,
    init,
    setup,
    register_types,
    add_import_path,
    get_component_path,
    COMPONENTS,
)

__all__ = [
    "CFrameless",
    "init",
    "setup",
    "register_types",
    "add_import_path",
    "get_component_path",
    "COMPONENTS",
    "__version__",
    "__author__",
]
