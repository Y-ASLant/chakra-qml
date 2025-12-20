pragma ComponentBehavior: Bound
import QtQuick
import Chakra

CWindow {
    visible: true
    width: 1200
    height: 800
    minimumWidth: 816
    minimumHeight: 560
    title: "Chakra Icons - Phosphor Icons (" + allIconNames.length + " icons)"

    property var allIconNames: []
    property int currentPage: 1
    property int itemsPerPage: 0
    property int totalPages: 1

    Component.onCompleted: {
        allIconNames = Object.keys(Icons.icons).sort();
        calculateItemsPerPage();
        updatePageModel();
    }

    function calculateItemsPerPage() {
        var cols = Math.floor((gridView.width) / 90);
        var rows = Math.floor((gridView.height) / 90);
        itemsPerPage = cols * rows;
        var newTotalPages = Math.max(1, Math.ceil(allIconNames.length / itemsPerPage));
        
        if (currentPage > newTotalPages) {
            currentPage = newTotalPages;
        }
        
        totalPages = newTotalPages;
    }

    function updatePageModel() {
        iconListModel.clear();
        var startIndex = (currentPage - 1) * itemsPerPage;
        var endIndex = Math.min(startIndex + itemsPerPage, allIconNames.length);
        for (var i = startIndex; i < endIndex; i++) {
            iconListModel.append({
                name: allIconNames[i]
            });
        }
    }

    function goToPage(page) {
        currentPage = Math.max(1, Math.min(page, totalPages));
        updatePageModel();
    }

    function getPageNumbers() {
        var pages = [];
        var maxVisible = 15;
        
        if (totalPages <= maxVisible) {
            for (var i = 1; i <= totalPages; i++) {
                pages.push(i);
            }
        } else {
            if (currentPage <= 8) {
                for (var i = 1; i <= 11; i++) pages.push(i);
                pages.push(-1);
                pages.push(totalPages);
            } else if (currentPage >= totalPages - 7) {
                pages.push(1);
                pages.push(-1);
                for (var i = totalPages - 10; i <= totalPages; i++) pages.push(i);
            } else {
                pages.push(1);
                pages.push(-1);
                for (var i = currentPage - 4; i <= currentPage + 4; i++) {
                    pages.push(i);
                }
                pages.push(-1);
                pages.push(totalPages);
            }
        }
        return pages;
    }

    onWidthChanged: {
        calculateItemsPerPage();
        updatePageModel();
    }

    onHeightChanged: {
        calculateItemsPerPage();
        updatePageModel();
    }

    ListModel {
        id: iconListModel
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
        anchors.topMargin: 5
        z: 1000
    }

    Item {
        anchors.fill: parent

        GridView {
            id: gridView
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -35
            width: Math.floor(parent.width / 90) * 90
            height: Math.floor((parent.height - 70) / 90) * 90
            cellWidth: 90
            cellHeight: 90
            clip: true
            interactive: false

            model: iconListModel

                delegate: Column {
                    id: iconDelegate
                    width: 85
                    height: 85
                    spacing: 3
                    required property string name

                    Rectangle {
                        id: iconBox
                        width: 55
                        height: 55
                        color: iconMouseArea.pressed ? AppStyle.primaryColor : (iconMouseArea.containsMouse ? Qt.lighter(AppStyle.borderColor, 1.1) : AppStyle.borderColor)
                        radius: AppStyle.radiusMd
                        anchors.horizontalCenter: parent.horizontalCenter
                        scale: iconMouseArea.pressed ? 0.95 : (iconMouseArea.containsMouse ? 1.05 : 1.0)

                        Behavior on scale {
                            NumberAnimation {
                                duration: 100
                                easing.type: Easing.OutCubic
                            }
                        }

                        Behavior on color {
                            ColorAnimation {
                                duration: 150
                            }
                        }

                        CIcon {
                            id: iconItem
                            name: iconDelegate.name
                            size: 28
                            color: iconMouseArea.pressed ? "white" : AppStyle.textColor
                            anchors.centerIn: parent

                            Behavior on color {
                                ColorAnimation {
                                    duration: 150
                                }
                            }
                        }

                        MouseArea {
                            id: iconMouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor

                            onClicked: {
                                clipboardHelper.copyToClipboard(iconDelegate.name);
                                copiedText.text = "Copied: " + iconDelegate.name;
                                copiedText.visible = true;
                                copiedTimer.restart();
                            }
                        }
                    }

                    Text {
                        text: iconDelegate.name
                        font.pixelSize: 9
                        color: AppStyle.textMuted
                        width: parent.width
                        horizontalAlignment: Text.AlignHCenter
                        elide: Text.ElideMiddle
                    }
                }
            }

        Rectangle {
            width: parent.width * 0.8
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            color: "transparent"

            Row {
                anchors.centerIn: parent
                spacing: 6

                Rectangle {
                    width: 40
                    height: 40
                    color: currentPage > 1 ? (firstMouseArea.containsMouse ? Qt.lighter(AppStyle.borderColor, 1.05) : "transparent") : "transparent"
                    border.color: AppStyle.borderColor
                    border.width: 1
                    radius: AppStyle.radiusSm

                    Text {
                        text: "<<"
                        font.pixelSize: 13
                        color: currentPage > 1 ? AppStyle.textColor : AppStyle.textMuted
                        anchors.centerIn: parent
                    }

                    MouseArea {
                        id: firstMouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: currentPage > 1 ? Qt.PointingHandCursor : Qt.ArrowCursor
                        enabled: currentPage > 1
                        onClicked: goToPage(1)
                    }
                }

                Rectangle {
                    width: 40
                    height: 40
                    color: currentPage > 1 ? (prevMouseArea.containsMouse ? Qt.lighter(AppStyle.borderColor, 1.05) : "transparent") : "transparent"
                    border.color: AppStyle.borderColor
                    border.width: 1
                    radius: AppStyle.radiusSm

                    Text {
                        text: "<"
                        font.pixelSize: 13
                        color: currentPage > 1 ? AppStyle.textColor : AppStyle.textMuted
                        anchors.centerIn: parent
                    }

                    MouseArea {
                        id: prevMouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: currentPage > 1 ? Qt.PointingHandCursor : Qt.ArrowCursor
                        enabled: currentPage > 1
                        onClicked: goToPage(currentPage - 1)
                    }
                }

                Repeater {
                    model: getPageNumbers()

                    Rectangle {
                        required property var modelData
                        
                        width: modelData === -1 ? 30 : 40
                        height: 40
                        color: modelData === currentPage ? AppStyle.primaryColor : (pageMouseArea.containsMouse ? Qt.lighter(AppStyle.borderColor, 1.05) : "transparent")
                        border.color: AppStyle.borderColor
                        border.width: modelData === -1 ? 0 : 1
                        radius: AppStyle.radiusSm

                        Text {
                            text: modelData === -1 ? "..." : modelData
                            font.pixelSize: 13
                            color: modelData === currentPage ? "white" : AppStyle.textColor
                            anchors.centerIn: parent
                        }

                        MouseArea {
                            id: pageMouseArea
                            anchors.fill: parent
                            hoverEnabled: modelData !== -1
                            cursorShape: modelData !== -1 ? Qt.PointingHandCursor : Qt.ArrowCursor
                            enabled: modelData !== -1 && modelData !== currentPage
                            onClicked: if (modelData !== -1) goToPage(modelData)
                        }
                    }
                }

                Rectangle {
                    width: 40
                    height: 40
                    color: currentPage < totalPages ? (nextMouseArea.containsMouse ? Qt.lighter(AppStyle.borderColor, 1.05) : "transparent") : "transparent"
                    border.color: AppStyle.borderColor
                    border.width: 1
                    radius: AppStyle.radiusSm

                    Text {
                        text: ">"
                        font.pixelSize: 13
                        color: currentPage < totalPages ? AppStyle.textColor : AppStyle.textMuted
                        anchors.centerIn: parent
                    }

                    MouseArea {
                        id: nextMouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: currentPage < totalPages ? Qt.PointingHandCursor : Qt.ArrowCursor
                        enabled: currentPage < totalPages
                        onClicked: goToPage(currentPage + 1)
                    }
                }

                Rectangle {
                    width: 40
                    height: 40
                    color: currentPage < totalPages ? (lastMouseArea.containsMouse ? Qt.lighter(AppStyle.borderColor, 1.05) : "transparent") : "transparent"
                    border.color: AppStyle.borderColor
                    border.width: 1
                    radius: AppStyle.radiusSm

                    Text {
                        text: ">>"
                        font.pixelSize: 13
                        color: currentPage < totalPages ? AppStyle.textColor : AppStyle.textMuted
                        anchors.centerIn: parent
                    }

                    MouseArea {
                        id: lastMouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: currentPage < totalPages ? Qt.PointingHandCursor : Qt.ArrowCursor
                        enabled: currentPage < totalPages
                        onClicked: goToPage(totalPages)
                    }
                }
            }
        }
    }
}
