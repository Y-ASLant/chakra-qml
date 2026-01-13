pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import Chakra

/*
    CPopupCloseButton - 弹窗关闭按钮组件
*/
Text {
    id: root

    property Popup popup: parent
    property int size: 20

    // 图标
    font.family: Icons.fontFamily
    font.pixelSize: root.size
    color: AppStyle.textMuted
    text: Icons.icons["x"] || ""

    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter

    MouseArea {
        anchors.fill: parent
        anchors.margins: -8
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onClicked: root.popup.close()
        onContainsMouseChanged: {
            root.color = containsMouse ? AppStyle.textColor : AppStyle.textMuted
        }
    }
}
