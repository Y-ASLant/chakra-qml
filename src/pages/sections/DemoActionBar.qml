import QtQuick
import Chakra

CCard {
    id: root
    width: parent.width - AppStyle.spacing6 * 2
    variant: "outline"

    property alias check1: actionBarCheck1
    property alias check2: actionBarCheck2
    property alias check3: actionBarCheck3

    Column {
        width: parent.width
        spacing: AppStyle.spacing4
        padding: AppStyle.spacing6

        Text {
            text: "ActionBar"
            font.pixelSize: AppStyle.fontSize2xl
            font.weight: Font.Bold
            color: AppStyle.textColor
        }

        Text {
            text: "底部浮动操作栏，用于批量操作"
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
        }

        Row {
            spacing: AppStyle.spacing3

            CCheckbox {
                id: actionBarCheck1
                text: "项目 1"
            }
            CCheckbox {
                id: actionBarCheck2
                text: "项目 2"
            }
            CCheckbox {
                id: actionBarCheck3
                text: "项目 3"
            }
        }

        Text {
            text: "勾选上方复选框查看 ActionBar"
            font.pixelSize: AppStyle.fontSizeXs
            color: AppStyle.textMuted
        }
    }
}
