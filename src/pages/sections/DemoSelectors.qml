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
            text: "Checkbox & Switch"
            font.pixelSize: AppStyle.fontSize2xl
            font.weight: Font.Bold
            color: AppStyle.textColor
        }

        Row {
            spacing: AppStyle.spacing6

            Column {
                spacing: AppStyle.spacing3
                CCheckbox {
                    text: "Default"
                }
                CCheckbox {
                    text: "Checked"
                    checked: true
                }
                CCheckbox {
                    text: "Indeterminate"
                    isIndeterminate: true
                }
                CCheckbox {
                    text: "Success"
                    colorScheme: "success"
                    checked: true
                }
                CCheckbox {
                    text: "Error"
                    colorScheme: "error"
                    checked: true
                }
            }

            Column {
                spacing: AppStyle.spacing3
                CSwitch {
                    text: "默认"
                }
                CSwitch {
                    text: "开启"
                    checked: true
                }
                CSwitch {
                    text: "Success"
                    colorScheme: "success"
                    checked: true
                }
                CSwitch {
                    text: "Warning"
                    colorScheme: "warning"
                    checked: true
                }
            }

            Column {
                spacing: AppStyle.spacing3

                Text {
                    text: "Track Indicator"
                    font.pixelSize: AppStyle.fontSizeSm
                    font.weight: Font.DemiBold
                    color: AppStyle.textSecondary
                }

                CSwitch {
                    size: "lg"
                    trackLabelOn: "ON"
                    trackLabelOff: "OFF"
                }
            }

            Column {
                spacing: AppStyle.spacing3

                Text {
                    text: "Thumb Indicator"
                    font.pixelSize: AppStyle.fontSizeSm
                    font.weight: Font.DemiBold
                    color: AppStyle.textSecondary
                }

                CSwitch {
                    size: "lg"
                    thumbIconOn: "check"
                    thumbIconOff: "x"
                    colorScheme: "success"
                }

                CSwitch {
                    size: "lg"
                    thumbIconOn: "sun"
                    thumbIconOff: "moon"
                }
            }
        }
    }
}
