import sys
from pathlib import Path
from PySide6.QtCore import QDir
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtQuickControls2 import QQuickStyle

project_root = Path(__file__).parent.parent
sys.path.insert(0, str(project_root))
QDir.setCurrent(str(project_root))


QQuickStyle.setStyle("Basic")

app = QGuiApplication(sys.argv)

engine = QQmlApplicationEngine()
engine.addImportPath("src")

tests_dir = Path(__file__).parent / "qml"
test_files = list(tests_dir.glob("tst_*.qml"))

if not test_files:
    print("No test files found in tests/qml/")
    sys.exit(1)

print(f"Found {len(test_files)} test file(s)")
print("-" * 50)

failed_tests = []
passed_tests = []

for test_file in test_files:
    print(f"\nRunning: {test_file.name}")
    print("-" * 50)

    engine.clearComponentCache()

    for obj in engine.rootObjects():
        engine.deleteLater()

    engine.load(str(test_file))

    if not engine.rootObjects():
        print(f"ERROR: Failed to load test: {test_file.name}")
        failed_tests.append(test_file.name)
        continue

    test_obj = engine.rootObjects()[0]

    if test_obj.property("running"):
        print("Test is running...")
        QGuiApplication.processEvents()

    if test_obj.property("completed"):
        passed_tests.append(test_file.name)
        print(f"✓ PASSED: {test_file.name}")
    else:
        failed_tests.append(test_file.name)
        print(f"✗ FAILED: {test_file.name}")
        if test_obj.property("failureCount") > 0:
            print(f"  Failures: {test_obj.property('failureCount')}")
        if test_obj.property("errorCount") > 0:
            print(f"  Errors: {test_obj.property('errorCount')}")

print("\n" + "=" * 50)
print("Test Summary")
print("=" * 50)
print(f"Total: {len(test_files)}")
print(f"Passed: {len(passed_tests)}")
print(f"Failed: {len(failed_tests)}")

if failed_tests:
    print("\nFailed tests:")
    for test_name in failed_tests:
        print(f"  - {test_name}")
    sys.exit(1)
else:
    print("\nAll tests passed!")
    sys.exit(0)
