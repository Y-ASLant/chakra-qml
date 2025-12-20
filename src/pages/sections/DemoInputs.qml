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
            text: "输入框 (CInput)"
            font.pixelSize: AppStyle.fontSize2xl
            font.weight: Font.Bold
            color: AppStyle.textColor
        }

        Row {
            spacing: AppStyle.spacing4

            Column {
                spacing: AppStyle.spacing2
                Text {
                    text: "Outline"
                    font.pixelSize: AppStyle.fontSizeSm
                    color: AppStyle.textSecondary
                }
                CInput {
                    placeholderText: "输入内容..."
                    variant: "outline"
                }
            }

            Column {
                spacing: AppStyle.spacing2
                Text {
                    text: "Filled"
                    font.pixelSize: AppStyle.fontSizeSm
                    color: AppStyle.textSecondary
                }
                CInput {
                    placeholderText: "输入内容..."
                    variant: "filled"
                }
            }

            Column {
                spacing: AppStyle.spacing2
                Text {
                    text: "Flushed"
                    font.pixelSize: AppStyle.fontSizeSm
                    color: AppStyle.textSecondary
                }
                CInput {
                    placeholderText: "输入内容..."
                    variant: "flushed"
                }
            }
        }

        Row {
            spacing: AppStyle.spacing4

            Column {
                spacing: AppStyle.spacing2
                Text {
                    text: "Clearable"
                    font.pixelSize: AppStyle.fontSizeSm
                    color: AppStyle.textSecondary
                }
                CInput {
                    placeholderText: "可清除..."
                    isClearable: true
                }
            }

            Column {
                spacing: AppStyle.spacing2
                Text {
                    text: "Max Length (10)"
                    font.pixelSize: AppStyle.fontSizeSm
                    color: AppStyle.textSecondary
                }
                CInput {
                    placeholderText: "最多10字符"
                    maxLength: 10
                    isClearable: true
                }
            }

            Column {
                spacing: AppStyle.spacing2
                Text {
                    text: "Password"
                    font.pixelSize: AppStyle.fontSizeSm
                    color: AppStyle.textSecondary
                }
                CInput {
                    placeholderText: "Enter password..."
                    type: "password"
                }
            }
        }

        Row {
            spacing: AppStyle.spacing4

            Column {
                spacing: AppStyle.spacing2
                Text {
                    text: "Invalid"
                    font.pixelSize: AppStyle.fontSizeSm
                    color: AppStyle.textSecondary
                }
                CInput {
                    placeholderText: "错误状态"
                    isInvalid: true
                }
            }

            Column {
                spacing: AppStyle.spacing2
                Text {
                    text: "Disabled"
                    font.pixelSize: AppStyle.fontSizeSm
                    color: AppStyle.textSecondary
                }
                CInput {
                    placeholderText: "禁用状态"
                    isDisabled: true
                }
            }
        }

        Text {
            text: "下拉选择 (CSelect)"
            font.pixelSize: AppStyle.fontSize2xl
            font.weight: Font.Bold
            color: AppStyle.textColor
            topPadding: AppStyle.spacing4
        }

        Row {
            spacing: AppStyle.spacing4

            Column {
                spacing: AppStyle.spacing2
                Text {
                    text: "Basic"
                    font.pixelSize: AppStyle.fontSizeSm
                    color: AppStyle.textSecondary
                }
                CSelect {
                    model: ["Apple", "Banana", "Cherry", "Date", "Elderberry"]
                    placeholder: "Select fruit"
                }
            }

            Column {
                spacing: AppStyle.spacing2
                Text {
                    text: "Searchable"
                    font.pixelSize: AppStyle.fontSizeSm
                    color: AppStyle.textSecondary
                }
                CSelect {
                    model: ["Beijing", "Shanghai", "Guangzhou", "Shenzhen", "Hangzhou", "Nanjing", "Chengdu", "Wuhan"]
                    placeholder: "Search city..."
                    isSearchable: true
                }
            }

            Column {
                spacing: AppStyle.spacing2
                Text {
                    text: "Filled"
                    font.pixelSize: AppStyle.fontSizeSm
                    color: AppStyle.textSecondary
                }
                CSelect {
                    model: ["Small", "Medium", "Large"]
                    placeholder: "Select size"
                    variant: "filled"
                }
            }

            Column {
                spacing: AppStyle.spacing2
                Text {
                    text: "Disabled"
                    font.pixelSize: AppStyle.fontSizeSm
                    color: AppStyle.textSecondary
                }
                CSelect {
                    model: ["Option A", "Option B"]
                    placeholder: "Disabled"
                    isDisabled: true
                }
            }
        }
    }
}
