import QtQuick
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
            text: "Badge & Tag"
            font.pixelSize: AppStyle.fontSize2xl
            font.weight: Font.Bold
            color: AppStyle.textColor
        }

        Text {
            text: "Badge"
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
        }

        Row {
            spacing: AppStyle.spacing3
            CBadge {
                text: "Default"
            }
            CBadge {
                text: "Success"
                colorScheme: "success"
            }
            CBadge {
                text: "Warning"
                colorScheme: "warning"
                variant: "solid"
            }
            CBadge {
                text: "Error"
                colorScheme: "error"
                variant: "outline"
            }
        }

        Text {
            text: "Tag"
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
            topPadding: AppStyle.spacing2
        }

        Row {
            spacing: AppStyle.spacing3
            CTag {
                text: "React"
            }
            CTag {
                text: "Vue"
                colorScheme: "success"
            }
            CTag {
                text: "Angular"
                colorScheme: "error"
                isClosable: true
            }
            CTag {
                text: "Svelte"
                colorScheme: "warning"
                variant: "solid"
            }
        }
    }
}
