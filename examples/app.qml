import QtQuick
import QtQuick.Layouts
import Chakra

CWindow {
    width: 600
    height: 500
    title: "Chakra UI QML"
    visible: true

    showTitleBar: true
    showThemeToggle: true

    ColumnLayout {
        anchors.centerIn: parent
        spacing: AppStyle.spacing5
        width: parent.width * 0.8

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
            title: "Quick Example"
            variant: "outline"
            Layout.fillWidth: true
            Layout.topMargin: AppStyle.spacing4

            ColumnLayout {
                spacing: AppStyle.spacing3
                Layout.fillWidth: true

                CInput {
                    placeholderText: "Enter your email..."
                    Layout.fillWidth: true
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
                        onClicked: Qt.openUrlExternally("https://github.com/Y-ASLant/chakra-qml#readme")
                    }
                }
            }
        }

        CAlert {
            status: "info"
            description: "29 components ready to use"
            variant: "subtle"
            Layout.fillWidth: true
        }
    }
}
