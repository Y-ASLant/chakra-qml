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
            text: "Pagination 分页"
            font.pixelSize: AppStyle.fontSize2xl
            font.weight: Font.Bold
            color: AppStyle.textColor
        }

        Text {
            text: "用于导航页面序列的组件"
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
        }

        Text {
            text: "Sizes"
            font.pixelSize: AppStyle.fontSizeLg
            font.weight: Font.Medium
            color: AppStyle.textColor
            topPadding: AppStyle.spacing2
        }

        Text {
            text: "Use the size prop to change the size of the pagination."
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
        }

        Column {
            width: parent.width
            spacing: AppStyle.spacing3

            Text {
                text: "Small"
                font.pixelSize: AppStyle.fontSizeSm
                color: AppStyle.textSecondary
            }

            CPagination {
                count: 100
                page: 3
                pageSize: 10
                size: "sm"
            }

            Text {
                text: "Medium (default)"
                font.pixelSize: AppStyle.fontSizeSm
                color: AppStyle.textSecondary
                topPadding: AppStyle.spacing2
            }

            CPagination {
                count: 100
                page: 3
                pageSize: 10
                size: "md"
            }

            Text {
                text: "Large"
                font.pixelSize: AppStyle.fontSizeSm
                color: AppStyle.textSecondary
                topPadding: AppStyle.spacing2
            }

            CPagination {
                count: 100
                page: 3
                pageSize: 10
                size: "lg"
            }
        }

        Text {
            text: "Variants"
            font.pixelSize: AppStyle.fontSizeLg
            font.weight: Font.Medium
            color: AppStyle.textColor
            topPadding: AppStyle.spacing4
        }

        Text {
            text: "Use the variant prop to control the variant of the pagination items."
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
        }

        Column {
            width: parent.width
            spacing: AppStyle.spacing3

            Text {
                text: "Outline"
                font.pixelSize: AppStyle.fontSizeSm
                color: AppStyle.textSecondary
            }

            CPagination {
                count: 100
                page: 3
                pageSize: 10
                variant: "outline"
            }

            Text {
                text: "Solid"
                font.pixelSize: AppStyle.fontSizeSm
                color: AppStyle.textSecondary
                topPadding: AppStyle.spacing2
            }

            CPagination {
                count: 100
                page: 3
                pageSize: 10
                variant: "solid"
            }

            Text {
                text: "Ghost"
                font.pixelSize: AppStyle.fontSizeSm
                color: AppStyle.textSecondary
                topPadding: AppStyle.spacing2
            }

            CPagination {
                count: 100
                page: 3
                pageSize: 10
                variant: "ghost"
            }
        }

        Text {
            text: "Sibling Count"
            font.pixelSize: AppStyle.fontSizeLg
            font.weight: Font.Medium
            color: AppStyle.textColor
            topPadding: AppStyle.spacing4
        }

        Text {
            text: "Use siblingCount to control the number of sibling pages to show."
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
        }

        Column {
            width: parent.width
            spacing: AppStyle.spacing3

            Text {
                text: "Sibling Count = 1 (default)"
                font.pixelSize: AppStyle.fontSizeSm
                color: AppStyle.textSecondary
            }

            CPagination {
                count: 100
                page: 5
                pageSize: 10
                siblingCount: 1
            }

            Text {
                text: "Sibling Count = 2"
                font.pixelSize: AppStyle.fontSizeSm
                color: AppStyle.textSecondary
                topPadding: AppStyle.spacing2
            }

            CPagination {
                count: 100
                page: 5
                pageSize: 10
                siblingCount: 2
            }
        }

        Text {
            text: "Compact"
            font.pixelSize: AppStyle.fontSizeLg
            font.weight: Font.Medium
            color: AppStyle.textColor
            topPadding: AppStyle.spacing4
        }

        Text {
            text: "Use compact mode for mobile views."
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
        }

        Row {
            spacing: AppStyle.spacing3

            CPagination {
                id: compactPagination
                count: 100
                page: 3
                pageSize: 10
                isCompact: true
            }

            CButton {
                text: "Prev"
                size: "md"
                variant: "outline"
                enabled: compactPagination.page > 1
                onClicked: compactPagination.goToPage(compactPagination.page - 1)
            }

            CButton {
                text: "Next"
                size: "md"
                variant: "outline"
                enabled: compactPagination.page < compactPagination.totalPages
                onClicked: compactPagination.goToPage(compactPagination.page + 1)
            }
        }

        Text {
            text: "Controlled"
            font.pixelSize: AppStyle.fontSizeLg
            font.weight: Font.Medium
            color: AppStyle.textColor
            topPadding: AppStyle.spacing4
        }

        Text {
            text: "Control the current page with page property."
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
        }

        Column {
            width: parent.width
            spacing: AppStyle.spacing3

            CPagination {
                id: controlledPagination
                count: 50
                page: currentPage
                pageSize: 5
                showsFirstLast: true
                onPageRequested: function(newPage) {
                    currentPage = newPage;
                }

                property int currentPage: 1
            }

            Text {
                text: "Current page: " + controlledPagination.currentPage + " / " + controlledPagination.totalPages
                font.pixelSize: AppStyle.fontSizeSm
                color: AppStyle.textColor
            }

            Row {
                spacing: AppStyle.spacing2

                CButton {
                    text: "Go to page 1"
                    size: "sm"
                    variant: "outline"
                    onClicked: controlledPagination.currentPage = 1
                }

                CButton {
                    text: "Go to page 5"
                    size: "sm"
                    variant: "outline"
                    onClicked: controlledPagination.currentPage = 5
                }

                CButton {
                    text: "Go to last page"
                    size: "sm"
                    variant: "outline"
                    onClicked: controlledPagination.currentPage = controlledPagination.totalPages
                }
            }
        }

        Text {
            text: "Color Schemes"
            font.pixelSize: AppStyle.fontSizeLg
            font.weight: Font.Medium
            color: AppStyle.textColor
            topPadding: AppStyle.spacing4
        }

        Column {
            width: parent.width
            spacing: AppStyle.spacing3

            Repeater {
                model: ["blue", "green", "purple", "pink", "teal"]

                delegate: Row {
                    required property string modelData
                    spacing: AppStyle.spacing3

                    Text {
                        text: modelData
                        font.pixelSize: AppStyle.fontSizeSm
                        color: AppStyle.textSecondary
                        width: 80
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    CPagination {
                        count: 100
                        page: 3
                        pageSize: 10
                        colorScheme: modelData
                    }
                }
            }
        }
    }
}
