from pathlib import Path
from loguru import logger

from .update_resource import (
    gen_qrc,
    update_qrc,
    update_qrcs,
    gen_qmldir,
    gen_qmltypes,
)

__all__ = [
    "build",
    "gen_qrc",
    "update_qrc",
    "update_qrcs",
    "gen_qmldir",
    "gen_qmltypes",
]


def build():
    """Build Chakra QML resources"""
    logger.info("Starting Chakra QML build process...")

    cwd = (Path(__file__).parent / "../../../").resolve()
    chakra_src = cwd / "src" / "Chakra"

    if not chakra_src.exists():
        logger.error(f"Chakra source directory not found: {chakra_src}")
        return

    logger.info(f"Building from: {chakra_src}")

    gen_qmldir(chakra_src, "Chakra", "1.0")

    logger.success("Chakra QML build completed!")
