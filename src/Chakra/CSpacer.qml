pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

/*
    CSpacer - 间距组件

    == 属性 ==
    size: int - 间距大小 (默认: AppStyle.spacing4)
    horizontal: bool - 是否水平方向 (默认: false)
    fill: bool - 是否填充剩余空间 (默认: false)
    minSize: int - 最小尺寸 (默认: 0)
    maxSize: int - 最大尺寸 (默认: -1, 无限制)

    == 使用示例 ==
    CSpacer { size: AppStyle.spacing4 }  // 固定垂直间距
    CSpacer { horizontal: true; size: 20 }  // 固定水平间距
    CSpacer { fill: true }  // 弹性填充剩余空间
    CSpacer { fill: true; minSize: 10; maxSize: 100 }  // 带约束的弹性填充
*/
Item {
    id: root

    property int size: AppStyle.spacing4
    property bool horizontal: false
    property bool fill: false
    property int minSize: 0
    property int maxSize: -1

    implicitWidth: horizontal ? size : 0
    implicitHeight: horizontal ? 0 : size

    Layout.fillWidth: horizontal && fill
    Layout.fillHeight: !horizontal && fill

    Layout.minimumWidth: horizontal ? minSize : 0
    Layout.minimumHeight: horizontal ? 0 : minSize

    Layout.maximumWidth: horizontal ? (maxSize > 0 ? maxSize : Infinity) : -1
    Layout.maximumHeight: horizontal ? -1 : (maxSize > 0 ? maxSize : Infinity)

    Layout.preferredWidth: horizontal && !fill ? size : -1
    Layout.preferredHeight: !horizontal && !fill ? size : -1
}
