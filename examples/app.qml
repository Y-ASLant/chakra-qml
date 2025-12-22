import QtQuick
import QtQuick.Layouts
import Chakra

CWindow {
    width: 640
    height: 460
    minimumWidth: 400
    minimumHeight: 420
    title: "Chakra UI QML"
    visible: true
    showMaximize: false

    showTitleBar: true
    showThemeToggle: true

    ColumnLayout {
        anchors.centerIn: parent
        spacing: AppStyle.spacing5
        width: parent.width * 0.84

        Text {
            text: "Chakra UI QML"
            font.pixelSize: 32
            font.weight: Font.Bold
            color: AppStyle.textColor
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: "A modern QML component library"
            font.pixelSize: 16
            color: AppStyle.textSecondary
            Layout.alignment: Qt.AlignHCenter
        }
        CCard {
            Layout.fillWidth: true
            Text {
                text: "Quick Examples"
                font.pixelSize: 24
                font.weight: Font.Bold
                color: AppStyle.textColor
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
            }
            CSpacer {
                size: AppStyle.spacing4
            }

            ColumnLayout {
                spacing: AppStyle.spacing3
                Layout.fillWidth: true

                CInput {
                    placeholderText: "Enter your username..."
                    Layout.fillWidth: true
                }

                CInput {
                    placeholderText: "Enter your password..."
                    Layout.fillWidth: true
                    type: "password"
                }

                RowLayout {
                    spacing: AppStyle.spacing3
                    Layout.alignment: Qt.AlignHCenter

                    CButton {
                        text: "Get Started"
                        colorScheme: "blue"
                        onClicked: Qt.openUrlExternally("https://github.com/Y-ASLant/chakra-qml")
                    }

                    CButton {
                        text: "Learn More"
                        variant: "outline"
                        colorScheme: "blue"
                        onClicked: Qt.openUrlExternally("https://github.com/Y-ASLant/chakra-qml/issues")
                    }
                }
            }
        }
    }
}
