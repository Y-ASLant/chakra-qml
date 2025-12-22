pragma ComponentBehavior: Bound
import QtQuick
import Chakra

CWindow {
    id: window
    visible: true
    width: 1030
    height: 600
    minimumWidth: 624
    minimumHeight: 400
    title: "Chakra Icons - Phosphor Icons (" + allIconNames.length + " icons)"

    property var allIconNames: []
    property string selectedIcon: ""

    Component.onCompleted: {
        allIconNames = Object.keys(Icons.icons).sort();
    }

    Timer {
        id: copiedTimer
        interval: 2000
        onTriggered: copiedText.visible = false
    }

    Text {
        id: copiedText
        text: ""
        font.pixelSize: 12
        color: AppStyle.successColor
        visible: false
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 8
        z: 1000
    }

    CGridView {
        id: gridView
        anchors.fill: parent
        anchors.leftMargin: AppStyle.spacing2
        anchors.topMargin: AppStyle.spacing2
        anchors.bottomMargin: AppStyle.spacing2
        anchors.rightMargin: AppStyle.spacing1
        cellWidth: 100
        cellHeight: 100

        model: window.allIconNames

        delegate: Item {
            id: iconDelegate
            width: gridView.cellWidth
            height: gridView.cellHeight
            required property string modelData
            required property int index

            Rectangle {
                id: iconCard
                width: 92
                height: 92
                anchors.centerIn: parent
                radius: AppStyle.radiusLg
                scale: window.selectedIcon === iconDelegate.modelData ? 1.05 : (iconMouseArea.pressed ? 0.95 : 1.0)
                color: {
                    if (window.selectedIcon === iconDelegate.modelData)
                        return AppStyle.primaryColor;
                    if (iconMouseArea.containsMouse)
                        return AppStyle.isDark ? Qt.rgba(255, 255, 255, 0.08) : Qt.rgba(0, 0, 0, 0.04);
                    return "transparent";
                }
                border.width: window.selectedIcon === iconDelegate.modelData ? 0 : 1
                border.color: {
                    if (window.selectedIcon === iconDelegate.modelData)
                        return AppStyle.primaryColor;
                    if (iconMouseArea.containsMouse)
                        return AppStyle.borderFocus;
                    return AppStyle.borderColor;
                }

                Behavior on scale {
                    NumberAnimation {
                        duration: AppStyle.durationNormal
                        easing.type: Easing.OutBack
                        easing.overshoot: 2
                    }
                }

                Behavior on color {
                    ColorAnimation {
                        duration: AppStyle.durationFast
                        easing.type: Easing.OutCubic
                    }
                }

                Behavior on border.color {
                    ColorAnimation {
                        duration: AppStyle.durationFast
                        easing.type: Easing.OutCubic
                    }
                }

                Column {
                    anchors.centerIn: parent
                    spacing: AppStyle.spacing2

                    CIcon {
                        name: iconDelegate.modelData
                        size: 32
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: window.selectedIcon === iconDelegate.modelData ? AppStyle.textLight : AppStyle.textColor

                        Behavior on color {
                            ColorAnimation {
                                duration: AppStyle.durationFast
                                easing.type: Easing.OutCubic
                            }
                        }
                    }

                    Text {
                        text: iconDelegate.modelData
                        font.pixelSize: 10
                        color: window.selectedIcon === iconDelegate.modelData ? AppStyle.textLight : AppStyle.textMuted
                        width: 80
                        horizontalAlignment: Text.AlignHCenter
                        elide: Text.ElideMiddle

                        Behavior on color {
                            ColorAnimation {
                                duration: AppStyle.durationFast
                                easing.type: Easing.OutCubic
                            }
                        }
                    }
                }

                MouseArea {
                    id: iconMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        window.selectedIcon = iconDelegate.modelData;
                        clipboardHelper.copyToClipboard(iconDelegate.modelData);
                        copiedText.text = "Copied: " + iconDelegate.modelData;
                        copiedText.visible = true;
                        copiedTimer.restart();
                    }
                }
            }
        }
    }
}
