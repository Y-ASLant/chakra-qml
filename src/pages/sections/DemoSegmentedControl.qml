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
            text: "Segmented Control"
            font.pixelSize: AppStyle.fontSize2xl
            font.weight: Font.Bold
            color: AppStyle.textColor
        }

        Text {
            text: "尺寸: xs, sm, md, lg"
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
        }

        Column {
            spacing: AppStyle.spacing3

            CSegmentedControl {
                items: ["React", "Vue", "Angular"]
                size: "xs"
            }

            CSegmentedControl {
                items: ["React", "Vue", "Angular"]
                size: "sm"
            }

            CSegmentedControl {
                items: ["React", "Vue", "Angular"]
                size: "md"
            }

            CSegmentedControl {
                items: ["React", "Vue", "Angular"]
                size: "lg"
            }
        }

        Text {
            text: "垂直方向"
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
            topPadding: AppStyle.spacing2
        }

        Row {
            spacing: AppStyle.spacing4

            CSegmentedControl {
                items: ["日", "周", "月"]
                orientation: "vertical"
                size: "sm"
            }

            CSegmentedControl {
                items: ["列表", "网格", "详情"]
                orientation: "vertical"
            }
        }

        Text {
            text: "禁用状态"
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
            topPadding: AppStyle.spacing2
        }

        Row {
            spacing: AppStyle.spacing4

            CSegmentedControl {
                items: ["选项1", "选项2", "选项3"]
                isDisabled: true
            }

            CSegmentedControl {
                items: ["可用", "禁用", "可用"]
                disabledItems: ["禁用"]
            }
        }
    }
}
