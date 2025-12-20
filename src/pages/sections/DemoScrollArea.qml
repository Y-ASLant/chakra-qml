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
            text: "滚动区域 (CScrollArea)"
            font.pixelSize: AppStyle.fontSize2xl
            font.weight: Font.Bold
            color: AppStyle.textColor
        }

        Text {
            text: "Sizes"
            font.pixelSize: AppStyle.fontSizeLg
            font.weight: Font.Bold
            color: AppStyle.textColor
            topPadding: AppStyle.spacing4
        }

        Row {
            spacing: AppStyle.spacing4

            Column {
                spacing: AppStyle.spacing2

                Text {
                    text: "xs"
                    font.pixelSize: AppStyle.fontSizeSm
                    color: AppStyle.textSecondary
                }

                CScrollArea {
                    size: "xs"
                    vertical: true
                    width: 200
                    height: 150

                    Rectangle {
                        color: AppStyle.isDark ? "#2D3748" : "#EDF2F7"
                        radius: AppStyle.radiusMd
                        width: 180
                        height: 300

                        Text {
                            anchors.centerIn: parent
                            text: "Extra Small\n\n滚动查看更多内容..."
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: AppStyle.fontSizeSm
                            color: AppStyle.textColor
                        }
                    }
                }
            }

            Column {
                spacing: AppStyle.spacing2

                Text {
                    text: "sm"
                    font.pixelSize: AppStyle.fontSizeSm
                    color: AppStyle.textSecondary
                }

                CScrollArea {
                    size: "sm"
                    vertical: true
                    width: 200
                    height: 150

                    Rectangle {
                        color: AppStyle.isDark ? "#2D3748" : "#EDF2F7"
                        radius: AppStyle.radiusMd
                        width: 180
                        height: 300

                        Text {
                            anchors.centerIn: parent
                            text: "Small\n\n滚动查看更多内容..."
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: AppStyle.fontSizeSm
                            color: AppStyle.textColor
                        }
                    }
                }
            }

            Column {
                spacing: AppStyle.spacing2

                Text {
                    text: "md"
                    font.pixelSize: AppStyle.fontSizeSm
                    color: AppStyle.textSecondary
                }

                CScrollArea {
                    size: "md"
                    vertical: true
                    width: 200
                    height: 150

                    Rectangle {
                        color: AppStyle.isDark ? "#2D3748" : "#EDF2F7"
                        radius: AppStyle.radiusMd
                        width: 180
                        height: 300

                        Text {
                            anchors.centerIn: parent
                            text: "Medium\n\n滚动查看更多内容..."
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: AppStyle.fontSizeSm
                            color: AppStyle.textColor
                        }
                    }
                }
            }

            Column {
                spacing: AppStyle.spacing2

                Text {
                    text: "lg"
                    font.pixelSize: AppStyle.fontSizeSm
                    color: AppStyle.textSecondary
                }

                CScrollArea {
                    size: "lg"
                    vertical: true
                    width: 200
                    height: 150

                    Rectangle {
                        color: AppStyle.isDark ? "#2D3748" : "#EDF2F7"
                        radius: AppStyle.radiusMd
                        width: 180
                        height: 300

                        Text {
                            anchors.centerIn: parent
                            text: "Large\n\n滚动查看更多内容..."
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: AppStyle.fontSizeSm
                            color: AppStyle.textColor
                        }
                    }
                }
            }
        }

        Text {
            text: "Horizontal Scrolling"
            font.pixelSize: AppStyle.fontSizeLg
            font.weight: Font.Bold
            color: AppStyle.textColor
            topPadding: AppStyle.spacing4
        }

        Text {
            text: "水平滚动区域"
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
        }

        CScrollArea {
            size: "md"
            horizontal: true
            width: parent.width - AppStyle.spacing6 * 2
            height: 80

            Row {
                spacing: AppStyle.spacing3
                padding: AppStyle.spacing2

                Repeater {
                    model: 15

                    Rectangle {
                        required property int index

                        width: 120
                        height: 60
                        radius: AppStyle.radiusMd
                        color: AppStyle.getSchemeColor(["blue", "green", "purple", "orange", "pink"][index % 5])

                        Text {
                            anchors.centerIn: parent
                            text: "Item " + (parent.index + 1)
                            color: AppStyle.textLight
                            font.pixelSize: AppStyle.fontSizeSm
                            font.weight: Font.Medium
                        }
                    }
                }
            }
        }

        Text {
            text: "Both Directions"
            font.pixelSize: AppStyle.fontSizeLg
            font.weight: Font.Bold
            color: AppStyle.textColor
            topPadding: AppStyle.spacing4
        }

        Text {
            text: "双向滚动区域"
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
        }

        CScrollArea {
            size: "md"
            horizontal: true
            vertical: true
            width: parent.width - AppStyle.spacing6 * 2
            height: 200

            Grid {
                columns: 10
                spacing: AppStyle.spacing3
                padding: AppStyle.spacing2

                Repeater {
                    model: 50

                    Rectangle {
                        required property int index

                        width: 100
                        height: 80
                        radius: AppStyle.radiusMd
                        color: AppStyle.getSchemeColor(["blue", "green", "purple", "orange", "pink", "teal", "cyan", "red"][index % 8])

                        Text {
                            anchors.centerIn: parent
                            text: "Cell " + (parent.index + 1)
                            color: AppStyle.textLight
                            font.pixelSize: AppStyle.fontSizeSm
                            font.weight: Font.Medium
                        }
                    }
                }
            }
        }
    }
}
