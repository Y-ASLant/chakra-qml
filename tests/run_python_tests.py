import sys
import unittest
from pathlib import Path

tests_dir = Path(__file__).parent / "python"

if not tests_dir.exists():
    print(f"Tests directory not found: {tests_dir}")
    sys.exit(1)

loader = unittest.TestLoader()
suite = loader.discover(str(tests_dir), pattern="test_*.py")

runner = unittest.TextTestRunner(verbosity=2)
result = runner.run(suite)

sys.exit(0 if result.wasSuccessful() else 1)
