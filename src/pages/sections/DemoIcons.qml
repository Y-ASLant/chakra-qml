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
            text: "图标 (Phosphor Icons)"
            font.pixelSize: AppStyle.fontSize2xl
            font.weight: Font.Bold
            color: AppStyle.textColor
        }

        Text {
            text: "内置 1530 个 Phosphor 图标，支持自定义颜色和尺寸"
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
        }

        Flow {
            width: parent.width - AppStyle.spacing6 * 2
            spacing: AppStyle.spacing4

            Repeater {
                model: ["house", "user", "gear", "heart", "star", "magnifying-glass", "pencil", "trash", "plus", "x", "check", "arrow-left", "arrow-right", "bell", "envelope", "lock", "eye", "calendar", "download", "upload"]

                delegate: Column {
                    id: iconDelegate
                    required property string modelData
                    spacing: AppStyle.spacing1

                    Rectangle {
                        width: 40
                        height: 40
                        radius: AppStyle.radiusSm
                        color: AppStyle.grayLight

                        CIcon {
                            anchors.centerIn: parent
                            name: iconDelegate.modelData
                            size: 20
                        }
                    }

                    Text {
                        text: iconDelegate.modelData
                        font.pixelSize: AppStyle.fontSizeXs
                        color: AppStyle.textMuted
                        width: 40
                        horizontalAlignment: Text.AlignHCenter
                        elide: Text.ElideRight
                    }
                }
            }
        }

        Text {
            text: "不同尺寸"
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
            topPadding: AppStyle.spacing2
        }

        Row {
            spacing: AppStyle.spacing4

            CIcon {
                name: "star"
                size: 12
            }
            CIcon {
                name: "star"
                size: 16
            }
            CIcon {
                name: "star"
                size: 20
            }
            CIcon {
                name: "star"
                size: 24
            }
            CIcon {
                name: "star"
                size: 32
            }
        }

        Text {
            text: "不同颜色"
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
            topPadding: AppStyle.spacing2
        }

        Row {
            spacing: AppStyle.spacing4

            CIcon {
                name: "heart"
                size: 24
                iconColor: AppStyle.textColor
            }
            CIcon {
                name: "heart"
                size: 24
                iconColor: AppStyle.primaryColor
            }
            CIcon {
                name: "heart"
                size: 24
                iconColor: AppStyle.successColor
            }
            CIcon {
                name: "heart"
                size: 24
                iconColor: AppStyle.warningColor
            }
            CIcon {
                name: "heart"
                size: 24
                iconColor: AppStyle.errorColor
            }
        }

        Text {
            text: "带图标的按钮"
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
            topPadding: AppStyle.spacing2
        }

        Row {
            spacing: AppStyle.spacing3

            CButton {
                text: "新建"
                leftIcon: "plus"
            }

            CButton {
                text: "编辑"
                leftIcon: "pencil"
                variant: "outline"
            }

            CButton {
                text: "删除"
                leftIcon: "trash"
                variant: "ghost"
                colorScheme: "red"
            }

            CButton {
                text: "下载"
                rightIcon: "download"
                variant: "outline"
            }
        }

        Text {
            text: "仅图标按钮"
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
            topPadding: AppStyle.spacing2
        }

        Row {
            spacing: AppStyle.spacing2

            CButton {
                leftIcon: "plus"
                iconOnly: true
            }
            CButton {
                leftIcon: "pencil"
                iconOnly: true
                variant: "outline"
            }
            CButton {
                leftIcon: "trash"
                iconOnly: true
                variant: "ghost"
                colorScheme: "red"
            }
            CButton {
                leftIcon: "gear"
                iconOnly: true
                variant: "ghost"
            }
            CButton {
                leftIcon: "magnifying-glass"
                iconOnly: true
                variant: "outline"
            }
            CButton {
                leftIcon: "bell"
                iconOnly: true
                variant: "ghost"
            }
        }
    }
}
