pragma ComponentBehavior: Bound

import QtQuick
import Chakra

/*
    CContentWidthUpdater - 内容宽度更新器组件
*/
Item {
    id: root

    property Item target: parent
    property int contentPadding: AppStyle.spacing6
    readonly property int targetWidth: target.width - contentPadding * 2

    Timer {
        id: updateTimer
        interval: 16
        repeat: false
        onTriggered: {
            AppStyle.updateChildrenWidth(root.target, root.targetWidth);
            for (let i = 0; i < root.target.children.length; i++) {
                let child = root.target.children[i];
                if (child && child.implicitWidth !== undefined) {
                    child.x = root.contentPadding;
                }
            }
        }
    }

    function scheduleUpdate() {
        updateTimer.restart();
    }

    Component.onCompleted: scheduleUpdate()
}
