pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

/*
    CInput - 输入框组件

    == 组件库特有属性 ==
    variant      : 变体，可选 "outline" | "filled" | "flushed"，默认 "outline"
    type         : 输入类型，可选 "text" | "password"，默认 "text"
    size         : 尺寸，可选 "sm" | "md" | "lg"，默认 "md"
    isInvalid    : 是否无效状态（显示错误样式），默认 false
    isDisabled   : 是否禁用，默认 false
    isClearable  : 是否显示清除按钮，默认 false
    maxLength    : 最大长度（0 表示无限制），默认 0
    leftElement  : 左侧自定义元素，类型 Component
    rightElement : 右侧自定义元素，类型 Component
*/
TextField {
    id: root

    // 变体: outline, filled, flushed
    property string variant: "outline"

    // 类型: text, password
    property string type: "text"

    // 尺寸: sm, md, lg
    property string size: "md"

    // 密码可见性 (内部状态)
    property bool _passwordVisible: false

    // 是否无效
    property bool isInvalid: false

    // 是否禁用
    property bool isDisabled: false

    // 是否显示清除按钮
    property bool isClearable: false

    // 最大长度 (0 表示无限制)
    property int maxLength: 0

    // 左右元素
    property Component leftElement: null
    property Component rightElement: null

    enabled: !isDisabled
    maximumLength: maxLength > 0 ? maxLength : 32767

    // 尺寸配置
    property int inputHeight: AppStyle.getInputHeight(size)
    property int fontSize: AppStyle.getFontSize(size)

    implicitHeight: inputHeight
    implicitWidth: AppStyle.inputWidth

    leftPadding: leftElement ? leftLoader.width + AppStyle.spacing3 : AppStyle.spacing3
    rightPadding: {
        var pad = AppStyle.spacing3;
        if (type === "password")
            pad += eyeBtn.width + AppStyle.spacing1;
        if (isClearable && text.length > 0)
            pad += clearBtn.width + AppStyle.spacing1;
        if (rightElement)
            pad += rightLoader.width + AppStyle.spacing1;
        return pad;
    }

    font.pixelSize: fontSize
    color: AppStyle.textColor
    placeholderTextColor: AppStyle.textMuted
    selectByMouse: true
    echoMode: (type === "password" && !_passwordVisible) ? TextInput.Password : TextInput.Normal

    background: Rectangle {
        radius: root.variant === "flushed" ? 0 : AppStyle.radiusSm

        color: {
            if (root.variant === "filled")
                return AppStyle.backgroundColor;
            return "transparent";
        }

        border.width: root.variant === "flushed" ? 0 : 1
        border.color: {
            if (root.isInvalid)
                return AppStyle.borderError;
            if (root.activeFocus)
                return AppStyle.borderFocus;
            return AppStyle.borderColor;
        }

        Behavior on color {
            ColorAnimation {
                duration: AppStyle.durationNormal
                easing.type: Easing.OutCubic
            }
        }

        Behavior on border.color {
            ColorAnimation {
                duration: AppStyle.durationFast
                easing.type: Easing.OutCubic
            }
        }

        // flushed 模式下只有底部边框
        Rectangle {
            visible: root.variant === "flushed"
            anchors.bottom: parent.bottom
            width: parent.width
            height: root.activeFocus ? 2 : 1
            color: {
                if (root.isInvalid)
                    return AppStyle.borderError;
                if (root.activeFocus)
                    return AppStyle.borderFocus;
                return AppStyle.borderColor;
            }
        }

        opacity: root.enabled ? 1 : 0.5
    }

    // 左侧元素
    Loader {
        id: leftLoader
        sourceComponent: root.leftElement
        anchors.left: parent.left
        anchors.leftMargin: AppStyle.spacing3
        anchors.verticalCenter: parent.verticalCenter
    }

    // 密码可见性切换按钮
    CIcon {
        id: eyeBtn
        visible: root.type === "password"
        name: root._passwordVisible ? "eye" : "eye-slash"
        size: root.fontSize
        iconColor: eyeArea.containsMouse ? AppStyle.textColor : AppStyle.textMuted
        anchors.right: root.rightElement ? rightLoader.left : parent.right
        anchors.rightMargin: AppStyle.spacing2
        anchors.verticalCenter: parent.verticalCenter

        MouseArea {
            id: eyeArea
            anchors.fill: parent
            anchors.margins: -4
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: root._passwordVisible = !root._passwordVisible
        }
    }

    // 清除按钮
    CIcon {
        id: clearBtn
        visible: root.isClearable && root.text.length > 0
        name: "x"
        size: root.fontSize
        iconColor: clearArea.containsMouse ? AppStyle.textColor : AppStyle.textMuted
        anchors.right: root.type === "password" ? eyeBtn.left : (root.rightElement ? rightLoader.left : parent.right)
        anchors.rightMargin: AppStyle.spacing2
        anchors.verticalCenter: parent.verticalCenter

        MouseArea {
            id: clearArea
            anchors.fill: parent
            anchors.margins: -4
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: root.clear()
        }
    }

    // 右侧元素
    Loader {
        id: rightLoader
        sourceComponent: root.rightElement
        anchors.right: parent.right
        anchors.rightMargin: AppStyle.spacing3
        anchors.verticalCenter: parent.verticalCenter
    }
}
