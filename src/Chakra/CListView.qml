pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

/*
    CListView - 虚拟化列表视图组件

    == 组件库特有属性 ==
    scrollBarSize : 滚动条尺寸，可选 "sm" | "md" | "lg"，默认 "md"

    继承 ListView 的所有属性：model, delegate, spacing 等
*/
ListView {
    id: root

    property string scrollBarSize: "md"

    clip: true
    boundsBehavior: Flickable.StopAtBounds
    boundsMovement: Flickable.StopAtBounds

    ScrollBar.vertical: CScrollBar {
        scrollBarSize: root.scrollBarSize
    }

    ScrollBar.horizontal: CScrollBar {
        scrollBarSize: root.scrollBarSize
    }
}
