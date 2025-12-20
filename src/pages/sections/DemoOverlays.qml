import QtQuick
import Chakra

CCard {
    id: root
    width: parent.width - AppStyle.spacing6 * 2
    variant: "outline"

    signal openDialog
    signal openDrawer
    signal openFramelessWindow

    Column {
        width: parent.width
        spacing: AppStyle.spacing4
        padding: AppStyle.spacing6

        Text {
            text: "Dialog & Drawer"
            font.pixelSize: AppStyle.fontSize2xl
            font.weight: Font.Bold
            color: AppStyle.textColor
        }

        Row {
            spacing: AppStyle.spacing3

            CButton {
                text: "打开 Dialog"
                onClicked: root.openDialog()
            }

            CButton {
                text: "打开 Drawer"
                variant: "outline"
                onClicked: root.openDrawer()
            }

            CButton {
                text: "无边框圆角窗口"
                variant: "ghost"
                onClicked: root.openFramelessWindow()
            }
        }
    }
}
