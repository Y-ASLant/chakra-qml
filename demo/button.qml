import QtQuick
import "../src/Chakra"

Window {
    visible: true
    width: 720
    height: 600
    title: "CButton - 示例"

    CScrollArea {
        anchors.fill: parent
        size: "sm"
        
        Column {
            spacing: 24

            // === 变体 (variant) ===
            Column {
                spacing: 8
                Text {
                    text: "Variant"
                    font.pixelSize: 16
                    font.bold: true
                    color: AppStyle.textColor
                }
                Row {
                    spacing: 12
                    CButton {
                        text: "Solid"
                        variant: "solid"
                    }
                    CButton {
                        text: "Outline"
                        variant: "outline"
                    }
                    CButton {
                        text: "Ghost"
                        variant: "ghost"
                    }
                    CButton {
                        text: "Link"
                        variant: "link"
                    }
                }
            }

            // === 颜色方案 (colorScheme) ===
            Column {
                spacing: 8
                Text {
                    text: "ColorScheme"
                    font.pixelSize: 16
                    font.bold: true
                    color: AppStyle.textColor
                }
                Row {
                    spacing: 12
                    CButton {
                        text: "Blue"
                        colorScheme: "blue"
                    }
                    CButton {
                        text: "Green"
                        colorScheme: "green"
                    }
                    CButton {
                        text: "Red"
                        colorScheme: "red"
                    }
                    CButton {
                        text: "Orange"
                        colorScheme: "orange"
                    }
                    CButton {
                        text: "Purple"
                        colorScheme: "purple"
                    }
                }
                Row {
                    spacing: 12
                    CButton {
                        text: "Primary"
                        colorScheme: "primary"
                    }
                    CButton {
                        text: "Success"
                        colorScheme: "success"
                    }
                    CButton {
                        text: "Warning"
                        colorScheme: "warning"
                    }
                    CButton {
                        text: "Error"
                        colorScheme: "error"
                    }
                }
            }

            // === 尺寸 (size) ===
            Column {
                spacing: 8
                Text {
                    text: "Size"
                    font.pixelSize: 16
                    font.bold: true
                    color: AppStyle.textColor
                }
                Row {
                    spacing: 12
                    CButton {
                        text: "Small"
                        size: "sm"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    CButton {
                        text: "Medium"
                        size: "md"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    CButton {
                        text: "Large"
                        size: "lg"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }

            // === 图标按钮 ===
            Column {
                spacing: 8
                Text {
                    text: "With Icons"
                    font.pixelSize: 16
                    font.bold: true
                    color: AppStyle.textColor
                }
                Row {
                    spacing: 12
                    CButton {
                        text: "Settings"
                        leftIcon: "settings"
                    }
                    CButton {
                        text: "Download"
                        rightIcon: "download"
                    }
                    CButton {
                        text: "Edit"
                        leftIcon: "edit"
                        rightIcon: "chevron-right"
                    }
                }
            }

            // === 仅图标按钮 ===
            Column {
                spacing: 8
                Text {
                    text: "Icon Only"
                    font.pixelSize: 16
                    font.bold: true
                    color: AppStyle.textColor
                }
                Row {
                    spacing: 12
                    CButton {
                        iconOnly: true
                        leftIcon: "plus"
                        size: "sm"
                    }
                    CButton {
                        iconOnly: true
                        leftIcon: "search"
                        size: "md"
                    }
                    CButton {
                        iconOnly: true
                        leftIcon: "menu"
                        size: "lg"
                    }
                    CButton {
                        iconOnly: true
                        leftIcon: "trash"
                        colorScheme: "error"
                    }
                    CButton {
                        iconOnly: true
                        leftIcon: "heart"
                        variant: "outline"
                    }
                }
            }

            // === 全宽按钮 ===
            Column {
                spacing: 8
                width: 300
                Text {
                    text: "Full Width"
                    font.pixelSize: 16
                    font.bold: true
                    color: AppStyle.textColor
                }
                CButton {
                    text: "Full Width Button"
                    fullWidth: true
                }
                CButton {
                    text: "Full Width Outline"
                    fullWidth: true
                    variant: "outline"
                }
            }

            // === 加载状态 ===
            Column {
                spacing: 8
                Text {
                    text: "Loading State"
                    font.pixelSize: 16
                    font.bold: true
                    color: AppStyle.textColor
                }
                Row {
                    spacing: 12
                    CButton {
                        text: "Loading..."
                        isLoading: true
                    }
                    CButton {
                        text: "Loading"
                        isLoading: true
                        variant: "outline"
                    }
                    CButton {
                        text: "Loading"
                        isLoading: true
                        colorScheme: "green"
                    }
                }
            }

            // === 禁用状态 ===
            Column {
                spacing: 8
                Text {
                    text: "Disabled"
                    font.pixelSize: 16
                    font.bold: true
                    color: AppStyle.textColor
                }
                Row {
                    spacing: 12
                    CButton {
                        text: "Disabled"
                        enabled: false
                    }
                    CButton {
                        text: "Disabled"
                        enabled: false
                        variant: "outline"
                    }
                    CButton {
                        text: "Disabled"
                        enabled: false
                        variant: "ghost"
                    }
                }
            }
        }
    }
}
