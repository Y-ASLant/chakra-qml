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
            text: "Menu 菜单"
            font.pixelSize: AppStyle.fontSize2xl
            font.weight: Font.Bold
            color: AppStyle.textColor
        }

        Text {
            text: "下拉菜单组件，支持图标、快捷键、分组、危险操作等"
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
        }

        Row {
            spacing: AppStyle.spacing4

            // 基础菜单
            CMenu {
                menuWidth: 180

                CMenuItem {
                    text: "新建文件"
                    menuIcon: "file"
                    command: "Ctrl+N"
                    onClicked: console.log("新建文件")
                }
                CMenuItem {
                    text: "打开..."
                    menuIcon: "folder"
                    command: "Ctrl+O"
                    onClicked: console.log("打开")
                }
                CMenuItem {
                    text: "保存"
                    menuIcon: "save"
                    command: "Ctrl+S"
                    onClicked: console.log("保存")
                }
                CMenuSeparator {}
                CMenuItem {
                    text: "设置"
                    menuIcon: "settings"
                    onClicked: console.log("设置")
                }
            }

            // 带分组的菜单
            CMenu {
                trigger: CButton {
                    text: "分组菜单"
                    rightIcon: "chevron-down"
                    variant: "outline"
                    colorScheme: "teal"
                }
                menuWidth: 200

                CMenuGroup {
                    title: "编辑"
                    CMenuItem {
                        text: "撤销"
                        menuIcon: "rotate-ccw"
                        command: "Ctrl+Z"
                    }
                    CMenuItem {
                        text: "重做"
                        menuIcon: "rotate-cw"
                        command: "Ctrl+Y"
                    }
                }
                CMenuSeparator {}
                CMenuGroup {
                    title: "剪贴板"
                    CMenuItem {
                        text: "剪切"
                        menuIcon: "scissors"
                        command: "Ctrl+X"
                    }
                    CMenuItem {
                        text: "复制"
                        menuIcon: "copy"
                        command: "Ctrl+C"
                    }
                    CMenuItem {
                        text: "粘贴"
                        menuIcon: "clipboard"
                        command: "Ctrl+V"
                    }
                }
            }

            // 带危险操作的菜单
            CMenu {
                trigger: CButton {
                    text: "更多操作"
                    rightIcon: "chevron-down"
                    colorScheme: "gray"
                    variant: "ghost"
                }
                menuWidth: 160

                CMenuItem {
                    text: "重命名"
                    menuIcon: "edit"
                }
                CMenuItem {
                    text: "移动到..."
                    menuIcon: "folder"
                }
                CMenuItem {
                    text: "归档"
                    menuIcon: "archive"
                }
                CMenuSeparator {}
                CMenuItem {
                    text: "删除"
                    menuIcon: "trash-2"
                    colorScheme: "danger"
                }
            }

            // 禁用项目的菜单
            CMenu {
                trigger: CButton {
                    text: "权限菜单"
                    rightIcon: "chevron-down"
                    variant: "outline"
                    colorScheme: "purple"
                }
                menuWidth: 180

                CMenuItem {
                    text: "查看"
                    menuIcon: "eye"
                }
                CMenuItem {
                    text: "编辑"
                    menuIcon: "edit"
                    isDisabled: true
                }
                CMenuItem {
                    text: "删除"
                    menuIcon: "trash-2"
                    isDisabled: true
                    colorScheme: "danger"
                }
            }
        }

        // 不同位置的菜单
        Text {
            text: "菜单位置"
            font.pixelSize: AppStyle.fontSizeLg
            font.weight: Font.Medium
            color: AppStyle.textColor
            topPadding: AppStyle.spacing4
        }

        Row {
            spacing: AppStyle.spacing4

            CMenu {
                placement: "bottom"
                trigger: CButton {
                    text: "下方 (默认)"
                    variant: "outline"
                    size: "sm"
                }
                menuWidth: 120

                CMenuItem { text: "选项 1"; size: "sm" }
                CMenuItem { text: "选项 2"; size: "sm" }
                CMenuItem { text: "选项 3"; size: "sm" }
            }

            CMenu {
                placement: "top"
                trigger: CButton {
                    text: "上方"
                    variant: "outline"
                    size: "sm"
                }
                menuWidth: 120

                CMenuItem { text: "选项 1"; size: "sm" }
                CMenuItem { text: "选项 2"; size: "sm" }
                CMenuItem { text: "选项 3"; size: "sm" }
            }

            CMenu {
                placement: "right"
                trigger: CButton {
                    text: "右侧"
                    variant: "outline"
                    size: "sm"
                }
                menuWidth: 120

                CMenuItem { text: "选项 1"; size: "sm" }
                CMenuItem { text: "选项 2"; size: "sm" }
                CMenuItem { text: "选项 3"; size: "sm" }
            }

            CMenu {
                placement: "left"
                trigger: CButton {
                    text: "左侧"
                    variant: "outline"
                    size: "sm"
                }
                menuWidth: 120

                CMenuItem { text: "选项 1"; size: "sm" }
                CMenuItem { text: "选项 2"; size: "sm" }
                CMenuItem { text: "选项 3"; size: "sm" }
            }
        }
    }
}
