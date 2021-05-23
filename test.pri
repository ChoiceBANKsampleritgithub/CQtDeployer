unix:exec = $$PWD/UnitTests/build/release/UnitTests
win32:exec = $$PWD/UnitTests/build/release/UnitTests.exe

QT_DIR= $$[QT_HOST_BINS]
win32:QMAKE_BIN= $$QT_DIR/qmake.exe
contains(QMAKE_HOST.os, Linux):{
    QMAKE_BIN= $$QT_DIR/qmake
}

DEPLOYER=cqtdeployer

test.commands =
deployTest.commands = $$DEPLOYER -bin $$exec clear -qmake $$QMAKE_BIN -targetDir $$PWD/deployTests -libDir $$PWD -recursiveDepth 4

!contains(DEFINES, WITHOUT_TESTS) {
    test.depends = deployTest
    unix:test.commands = $$PWD/deployTests/UnitTests.sh -maxwarnings 100000
    win32:test.commands = $$PWD/deployTests/UnitTests.exe -maxwarnings 100000 -o buildLog.log
}

contains(QMAKE_HOST.os, Linux):{
    win32:test.commands =
}


QMAKE_EXTRA_TARGETS += \
    deployTest \
    test


