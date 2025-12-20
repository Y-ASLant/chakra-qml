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
            text: "Progress & Spinner"
            font.pixelSize: AppStyle.fontSize2xl
            font.weight: Font.Bold
            color: AppStyle.textColor
        }

        Text {
            text: "Progress"
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
        }

        CProgress {
            width: 300
            value: 60
        }
        CProgress {
            width: 300
            value: 80
            colorScheme: "success"
        }
        Row {
            spacing: AppStyle.spacing3

            Column {
                spacing: AppStyle.spacing2

                CProgress {
                    width: 250
                    value: 40
                    colorScheme: "warning"
                    hasStripe: true
                    isAnimated: true
                }

                Text {
                    text: "条纹动画 (animationEnabled: true)"
                    font.pixelSize: AppStyle.fontSizeXs
                    color: AppStyle.textMuted
                }
            }

            Column {
                spacing: AppStyle.spacing2

                CProgress {
                    width: 250
                    value: 40
                    colorScheme: "warning"
                    hasStripe: true
                    isAnimated: true
                    animationEnabled: false
                }

                Text {
                    text: "禁用动画 (animationEnabled: false)"
                    font.pixelSize: AppStyle.fontSizeXs
                    color: AppStyle.textMuted
                }
            }
        }

        CProgress {
            width: 300
            isIndeterminate: true
            colorScheme: "error"
        }

        Text {
            text: "Spinner"
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
            topPadding: AppStyle.spacing2
        }

        Row {
            spacing: AppStyle.spacing6
            CSpinner {
                size: "xs"
            }
            CSpinner {
                size: "sm"
            }
            CSpinner {
                size: "md"
            }
            CSpinner {
                size: "lg"
            }
            CSpinner {
                size: "xl"
                color: AppStyle.successColor
            }
        }
    }
}
