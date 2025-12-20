import QtQuick
import QtQuick.Controls
import Chakra

CCard {
    id: root
    width: parent.width - AppStyle.spacing6 * 2
    variant: "outline"

    Column {
        width: parent.width
        spacing: AppStyle.spacing4
        padding: AppStyle.spacing6

        Text {
            text: "按钮 (CButton)"
            font.pixelSize: AppStyle.fontSize2xl
            font.weight: Font.Bold
            color: AppStyle.textColor
        }

        Text {
            text: "变体: solid, outline, ghost, link"
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
        }

        Row {
            spacing: AppStyle.spacing3

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

        Text {
            text: "颜色方案"
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
            topPadding: AppStyle.spacing2
        }

        Flow {
            width: parent.width - AppStyle.spacing6 * 2
            spacing: AppStyle.spacing2

            CButton {
                text: "Gray"
                colorScheme: "gray"
            }
            CButton {
                text: "Red"
                colorScheme: "red"
            }
            CButton {
                text: "Green"
                colorScheme: "green"
            }
            CButton {
                text: "Blue"
                colorScheme: "blue"
            }
            CButton {
                text: "Teal"
                colorScheme: "teal"
            }
            CButton {
                text: "Pink"
                colorScheme: "pink"
            }
            CButton {
                text: "Purple"
                colorScheme: "purple"
            }
            CButton {
                text: "Cyan"
                colorScheme: "cyan"
            }
            CButton {
                text: "Orange"
                colorScheme: "orange"
            }
            CButton {
                text: "Yellow"
                colorScheme: "yellow"
            }
        }

        Text {
            text: "尺寸"
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
            topPadding: AppStyle.spacing2
        }

        Row {
            spacing: AppStyle.spacing3

            CButton {
                text: "Small"
                size: "sm"
            }
            CButton {
                text: "Medium"
                size: "md"
            }
            CButton {
                text: "Large"
                size: "lg"
            }
        }
    }
}
