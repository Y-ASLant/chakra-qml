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
            text: "Tooltip 工具提示"
            font.pixelSize: AppStyle.fontSize2xl
            font.weight: Font.Bold
            color: AppStyle.textColor
        }

        Text {
            text: "悬停在按钮上查看提示"
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
        }

        Row {
            spacing: AppStyle.spacing6

            CButton {
                text: "上方提示"
                
                CTooltip {
                    text: "这是上方的提示信息"
                    placement: "top"
                    visible: parent.hovered
                }
            }

            CButton {
                text: "下方提示"
                colorScheme: "success"
                
                CTooltip {
                    text: "这是下方的提示信息"
                    placement: "bottom"
                    visible: parent.hovered
                }
            }

            CButton {
                text: "左侧提示"
                colorScheme: "warning"
                
                CTooltip {
                    text: "这是左侧的提示信息"
                    placement: "left"
                    visible: parent.hovered
                }
            }

            CButton {
                text: "右侧提示"
                colorScheme: "error"
                
                CTooltip {
                    text: "这是右侧的提示信息"
                    placement: "right"
                    visible: parent.hovered
                }
            }
        }

        Text {
            text: "图标按钮配合提示"
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
            topPadding: AppStyle.spacing2
        }

        Row {
            spacing: AppStyle.spacing3

            CButton {
                iconOnly: true
                leftIcon: "check"
                size: "sm"
                
                CTooltip {
                    text: "确认"
                    visible: parent.hovered
                }
            }

            CButton {
                iconOnly: true
                leftIcon: "x"
                size: "sm"
                colorScheme: "error"
                variant: "ghost"
                
                CTooltip {
                    text: "关闭"
                    visible: parent.hovered
                }
            }

            CButton {
                iconOnly: true
                leftIcon: "info"
                size: "sm"
                variant: "outline"
                
                CTooltip {
                    text: "查看详情"
                    visible: parent.hovered
                }
            }

            CButton {
                iconOnly: true
                leftIcon: "settings"
                size: "sm"
                variant: "ghost"
                
                CTooltip {
                    text: "设置"
                    visible: parent.hovered
                }
            }
        }

        Text {
            text: "表单元素配合提示"
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
            topPadding: AppStyle.spacing2
        }

        Row {
            spacing: AppStyle.spacing4

            Column {
                spacing: AppStyle.spacing2

                Item {
                    width: checkboxItem.width
                    height: checkboxItem.height

                    CCheckbox {
                        id: checkboxItem
                        text: "启用功能"
                    }

                    HoverHandler {
                        id: checkboxHover
                    }
                    
                    CTooltip {
                        text: "勾选以启用高级功能"
                        visible: checkboxHover.hovered
                    }
                }

                Item {
                    width: switchItem.width
                    height: switchItem.height

                    CSwitch {
                        id: switchItem
                        text: "自动保存"
                    }

                    HoverHandler {
                        id: switchHover
                    }
                    
                    CTooltip {
                        text: "开启后将自动保存您的更改"
                        visible: switchHover.hovered
                    }
                }
            }

            Item {
                width: badgeItem.width
                height: badgeItem.height
                anchors.verticalCenter: parent.verticalCenter

                CBadge {
                    id: badgeItem
                    text: "新功能"
                    colorScheme: "blue"
                }

                HoverHandler {
                    id: badgeHover
                }
                
                CTooltip {
                    text: "这是最新添加的功能"
                    visible: badgeHover.hovered
                }
            }
        }

        Text {
            text: "长文本提示"
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
            topPadding: AppStyle.spacing2
        }

        CButton {
            text: "查看详细信息"
            variant: "outline"
            
            CTooltip {
                text: "这是一个较长的提示信息，用于展示更多的说明内容。Tooltip 会自动换行显示。"
                visible: parent.hovered
            }
        }
    }
}
