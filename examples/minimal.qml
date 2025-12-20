import QtQuick
import Chakra

CWindow {
    visible: true
    width: 640
    height: 480
    title: "Minimal Chakra App"

    Column {
        anchors.centerIn: parent
        spacing: AppStyle.spacing4

        Text {
            text: "Hello Chakra QML"
            font.pixelSize: AppStyle.fontSize2xl
            color: AppStyle.textColor
            anchors.horizontalCenter: parent.horizontalCenter
        }

        CButton {
            text: "Click Me"
            colorScheme: "primary"
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: console.log("Button clicked!")
        }
    }
}
