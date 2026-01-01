import QtQuick
import Chakra

CCard {
    id: root
    width: parent.width - AppStyle.spacing6 * 2
    variant: "outline"

    Column {
        width: parent.width
        spacing: AppStyle.spacing4

        Text {
            text: "布局组件"
            font.pixelSize: AppStyle.fontSize2xl
            font.weight: Font.Bold
            color: AppStyle.textColor
        }

        Text {
            text: "CBox - 基础盒子容器"
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
        }

        CFlow {
            width: parent.width
            spacing: AppStyle.spacing3

            CBox {
                width: 120
                height: 80
                padding: AppStyle.spacing3
                backgroundColor: AppStyle.primaryColor
                cornerRadius: AppStyle.radiusMd

                Text {
                    text: "带内边距"
                    color: "white"
                    anchors.centerIn: parent
                }
            }

            CBox {
                width: 120
                height: 80
                borderWidth: 2
                borderColor: AppStyle.primaryColor
                cornerRadius: AppStyle.radiusLg
                backgroundColor: "transparent"

                Text {
                    text: "带边框"
                    color: AppStyle.textColor
                    anchors.centerIn: parent
                }
            }

            CBox {
                width: 120
                height: 80
                padding: AppStyle.spacing4
                backgroundColor: AppStyle.surfaceColor
                borderWidth: 1
                borderColor: AppStyle.borderColor
                cornerRadius: AppStyle.radiusXl

                Column {
                    spacing: 4
                    anchors.centerIn: parent

                    Text {
                        text: "组合使用"
                        font.pixelSize: AppStyle.fontSizeSm
                        color: AppStyle.textColor
                    }
                    Text {
                        text: "边框+圆角"
                        font.pixelSize: AppStyle.fontSizeXs
                        color: AppStyle.textSecondary
                    }
                }
            }
        }

        Text {
            text: "CFlex - 弹性布局容器"
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
            topPadding: AppStyle.spacing2
        }

        Column {
            width: parent.width
            spacing: AppStyle.spacing2

            Text {
                text: "水平布局 (direction: row)"
                font.pixelSize: AppStyle.fontSizeXs
                color: AppStyle.textMuted
            }

            CFlex {
                width: parent.width
                direction: "row"
                justify: "space-between"
                align: "center"
                gap: AppStyle.spacing2

                CButton {
                    text: "按钮 1"
                    size: "sm"
                }
                CButton {
                    text: "按钮 2"
                    size: "sm"
                    colorScheme: "success"
                }
                CButton {
                    text: "按钮 3"
                    size: "sm"
                    colorScheme: "error"
                }
            }

            Text {
                text: "垂直布局 (direction: column, justify: center)"
                font.pixelSize: AppStyle.fontSizeXs
                color: AppStyle.textMuted
                topPadding: AppStyle.spacing2
            }

            CBox {
                width: 300
                height: 100
                backgroundColor: AppStyle.surfaceColor
                borderWidth: 1
                borderColor: AppStyle.borderColor
                cornerRadius: AppStyle.radiusSm

                CFlex {
                    anchors.fill: parent
                    direction: "column"
                    justify: "center"
                    align: "start"
                    gap: AppStyle.spacing2
                    padding: AppStyle.spacing2

                    Text {
                        text: "项目 1"
                        font.pixelSize: AppStyle.fontSizeSm
                        color: AppStyle.textColor
                    }
                    
                    Text {
                        text: "项目 2"
                        font.pixelSize: AppStyle.fontSizeSm
                        color: AppStyle.textColor
                    }
                }
            }
        }

        Text {
            text: "CCenter - 居中容器"
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
            topPadding: AppStyle.spacing2
        }

        CBox {
            width: 300
            height: 120
            backgroundColor: AppStyle.surfaceColor
            borderWidth: 1
            borderColor: AppStyle.borderColor
            cornerRadius: AppStyle.radiusMd

            CCenter {
                anchors.fill: parent

                Column {
                    spacing: AppStyle.spacing2

                    CIcon {
                        name: "check-circle"
                        size: 32
                        color: AppStyle.successColor
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        text: "内容自动居中"
                        font.pixelSize: AppStyle.fontSizeSm
                        color: AppStyle.textColor
                    }
                }
            }
        }

        Text {
            text: "CContainer - 响应式容器（限制最大宽度并居中）"
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
            topPadding: AppStyle.spacing2
        }

        Column {
            width: parent.width
            spacing: AppStyle.spacing3

            CBox {
                width: parent.width
                height: 80
                backgroundColor: AppStyle.surfaceColor
                borderWidth: 1
                borderColor: AppStyle.borderColor
                cornerRadius: AppStyle.radiusSm

                CContainer {
                    size: "sm"
                    anchors.fill: parent

                    Rectangle {
                        width: parent.width
                        height: 80
                        color: Qt.rgba(AppStyle.primaryColor.r, AppStyle.primaryColor.g, AppStyle.primaryColor.b, 0.1)
                        radius: AppStyle.radiusSm
                        border.width: 2
                        border.color: AppStyle.primaryColor

                        Column {
                            anchors.centerIn: parent
                            spacing: 4

                            Text {
                                text: "size: sm"
                                font.pixelSize: AppStyle.fontSizeSm
                                font.weight: Font.Medium
                                color: AppStyle.textColor
                                anchors.horizontalCenter: parent.horizontalCenter
                            }

                            Text {
                                text: "最大宽度 640px，自动居中"
                                font.pixelSize: AppStyle.fontSizeXs
                                color: AppStyle.textSecondary
                            }
                        }
                    }
                }
            }

            CBox {
                width: parent.width
                height: 80
                backgroundColor: AppStyle.surfaceColor
                borderWidth: 1
                borderColor: AppStyle.borderColor
                cornerRadius: AppStyle.radiusSm

                CContainer {
                    size: "md"
                    anchors.fill: parent

                    Rectangle {
                        width: parent.width
                        height: 80
                        color: Qt.rgba(AppStyle.successColor.r, AppStyle.successColor.g, AppStyle.successColor.b, 0.1)
                        radius: AppStyle.radiusSm
                        border.width: 2
                        border.color: AppStyle.successColor

                        Column {
                            anchors.centerIn: parent
                            spacing: 4

                            Text {
                                text: "size: md"
                                font.pixelSize: AppStyle.fontSizeSm
                                font.weight: Font.Medium
                                color: AppStyle.textColor
                                anchors.horizontalCenter: parent.horizontalCenter
                            }

                            Text {
                                text: "最大宽度 768px，自动居中"
                                font.pixelSize: AppStyle.fontSizeXs
                                color: AppStyle.textSecondary
                            }
                        }
                    }
                }
            }

            CBox {
                width: parent.width
                height: 80
                backgroundColor: AppStyle.surfaceColor
                borderWidth: 1
                borderColor: AppStyle.borderColor
                cornerRadius: AppStyle.radiusSm

                CContainer {
                    size: "lg"
                    anchors.fill: parent

                    Rectangle {
                        width: parent.width
                        height: 80
                        color: Qt.rgba(AppStyle.warningColor.r, AppStyle.warningColor.g, AppStyle.warningColor.b, 0.1)
                        radius: AppStyle.radiusSm
                        border.width: 2
                        border.color: AppStyle.warningColor

                        Column {
                            anchors.centerIn: parent
                            spacing: 4

                            Text {
                                text: "size: lg"
                                font.pixelSize: AppStyle.fontSizeSm
                                font.weight: Font.Medium
                                color: AppStyle.textColor
                                anchors.horizontalCenter: parent.horizontalCenter
                            }

                            Text {
                                text: "最大宽度 1024px，自动居中"
                                font.pixelSize: AppStyle.fontSizeXs
                                color: AppStyle.textSecondary
                            }
                        }
                    }
                }
            }
        }
    }
}
