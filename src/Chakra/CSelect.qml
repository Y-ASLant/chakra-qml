pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

/*
    CSelect - 选择器组件

    == 组件库特有属性 ==
    variant      : 变体，可选 "outline" | "filled" | "flushed"，默认 "outline"
    size         : 尺寸，可选 "sm" | "md" | "lg"，默认 "md"
    placeholder  : 占位符文本，默认 "Select option"
    isInvalid    : 是否无效状态，默认 false
    isDisabled   : 是否禁用，默认 false
    isSearchable : 是否可搜索，默认 false
*/
ComboBox {
    id: root

    property string variant: "outline"
    property string size: "md"
    property string placeholder: "Select option"
    property bool isInvalid: false
    property bool isDisabled: false
    property bool isSearchable: false

    property string searchText: ""

    readonly property var filteredModel: {
        if (!isSearchable || searchText === "" || !model) {
            return model || [];
        }
        var search = searchText.toLowerCase();
        return model.filter(function(item) {
            return String(item).toLowerCase().indexOf(search) !== -1;
        });
    }

    function getBorderColor(isFocused: bool): color {
        if (isInvalid) return AppStyle.borderError;
        if (isFocused) return AppStyle.borderFocus;
        return AppStyle.borderColor;
    }

    property int inputHeight: AppStyle.getInputHeight(size)
    property int fontSize: AppStyle.getFontSize(size)

    enabled: !isDisabled

    implicitHeight: inputHeight
    implicitWidth: AppStyle.inputWidth

    contentItem: Text {
        leftPadding: AppStyle.spacing3
        rightPadding: AppStyle.spacing8
        text: root.displayText || root.placeholder
        font.pixelSize: root.fontSize
        color: root.displayText ? AppStyle.textColor : AppStyle.textMuted
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    indicator: CIcon {
        x: root.width - width - AppStyle.spacing3
        y: root.height / 2 - height / 2
        name: "chevron-down"
        size: 14
        iconColor: AppStyle.textMuted

        rotation: root.popup.visible ? 180 : 0
        Behavior on rotation {
            NumberAnimation {
                duration: AppStyle.durationFast
                easing.type: Easing.OutCubic
            }
        }
    }

    background: Rectangle {
        radius: root.variant === "flushed" ? 0 : AppStyle.radiusLg
        color: root.variant === "filled" ? AppStyle.backgroundColor : "transparent"
        border.width: root.variant === "flushed" ? 0 : 1
        border.color: root.getBorderColor(root.popup.visible)
        opacity: root.enabled ? 1 : 0.5

        Behavior on border.color {
            ColorAnimation {
                duration: AppStyle.durationFast
                easing.type: Easing.OutCubic
            }
        }

        Rectangle {
            visible: root.variant === "flushed"
            anchors.bottom: parent.bottom
            width: parent.width
            height: root.popup.visible ? 2 : 1
            color: root.getBorderColor(root.popup.visible)
        }
    }

    popup: Popup {
        y: root.height + 4
        width: root.width
        implicitHeight: contentItem.implicitHeight + 8
        padding: 4

        enter: Transition {
            NumberAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: AppStyle.durationFast
                easing.type: Easing.OutCubic
            }
            NumberAnimation {
                property: "scale"
                from: 0.95
                to: 1
                duration: AppStyle.durationFast
                easing.type: Easing.OutCubic
            }
        }
        exit: Transition {
            NumberAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: AppStyle.durationXFast
                easing.type: Easing.OutCubic
            }
            NumberAnimation {
                property: "scale"
                from: 1
                to: 0.95
                duration: AppStyle.durationXFast
                easing.type: Easing.OutCubic
            }
        }
        transformOrigin: Popup.Top

        onOpened: {
            if (root.isSearchable) {
                searchField.text = "";
                searchField.forceActiveFocus();
            }
        }

        onClosed: root.searchText = ""

        contentItem: Column {
            spacing: 4

            TextField {
                id: searchField
                visible: root.isSearchable
                width: parent.width
                height: root.inputHeight - 8
                placeholderText: "Search..."
                font.pixelSize: root.fontSize
                color: AppStyle.textColor
                placeholderTextColor: AppStyle.textMuted
                leftPadding: AppStyle.spacing3
                selectByMouse: true

                background: Rectangle {
                    radius: AppStyle.radiusSm
                    color: AppStyle.backgroundColor
                    border.width: 1
                    border.color: searchField.activeFocus ? AppStyle.borderFocus : AppStyle.borderColor
                }

                onTextChanged: root.searchText = text
            }

            ListView {
                clip: true
                width: parent.width
                implicitHeight: Math.min(contentHeight, 200)
                model: root.isSearchable ? root.filteredModel : (root.popup.visible ? root.delegateModel : null)
                currentIndex: root.highlightedIndex

                ScrollIndicator.vertical: ScrollIndicator {}
            }
        }

        background: Rectangle {
            color: AppStyle.surfaceColor
            radius: AppStyle.radiusLg
            border.width: 1
            border.color: AppStyle.borderColor

            Behavior on color {
                ColorAnimation {
                    duration: AppStyle.durationNormal
                    easing.type: Easing.OutCubic
                }
            }
        }
    }

    delegate: ItemDelegate {
        id: delegateItem
        required property int index
        required property var modelData

        width: root.width - 8
        height: root.inputHeight - 8

        contentItem: Text {
            text: delegateItem.modelData
            font.pixelSize: root.fontSize
            color: delegateItem.highlighted ? AppStyle.primaryColor : AppStyle.textColor
            verticalAlignment: Text.AlignVCenter
            leftPadding: AppStyle.spacing2
        }

        background: Rectangle {
            radius: AppStyle.radiusSm
            color: delegateItem.highlighted ? Qt.rgba(AppStyle.primaryColor.r, AppStyle.primaryColor.g, AppStyle.primaryColor.b, 0.1) : "transparent"

            Behavior on color {
                ColorAnimation {
                    duration: AppStyle.durationFast
                    easing.type: Easing.OutCubic
                }
            }
        }

        highlighted: root.highlightedIndex === delegateItem.index
    }
}
