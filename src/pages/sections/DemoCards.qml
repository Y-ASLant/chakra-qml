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
            text: "Card 卡片"
            font.pixelSize: AppStyle.fontSize2xl
            font.weight: Font.Bold
            color: AppStyle.textColor
        }

        Text {
            text: "用于展示相关内容的容器组件"
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
        }

        // Variants
        Text {
            text: "Variants"
            font.pixelSize: AppStyle.fontSizeLg
            font.weight: Font.Medium
            color: AppStyle.textColor
            topPadding: AppStyle.spacing2
        }

        Row {
            spacing: AppStyle.spacing4

            CCard {
                width: 200
                variant: "elevated"
                title: "Elevated"
                description: "This is the card body with shadow effect."
            }

            CCard {
                width: 200
                variant: "outline"
                title: "Outline"
                description: "This is the card body with border."
            }

            CCard {
                width: 200
                variant: "filled"
                title: "Filled"
                description: "This is the card body with filled background."
            }

            CCard {
                width: 200
                variant: "subtle"
                title: "Subtle"
                description: "This is the card body with subtle style."
            }
        }

        // Sizes
        Text {
            text: "Sizes"
            font.pixelSize: AppStyle.fontSizeLg
            font.weight: Font.Medium
            color: AppStyle.textColor
            topPadding: AppStyle.spacing4
        }

        Text {
            text: "Use the size prop to change the size of the Card."
            font.pixelSize: AppStyle.fontSizeSm
            color: AppStyle.textSecondary
        }

        Row {
            spacing: AppStyle.spacing4

            CCard {
                width: 180
                size: "sm"
                variant: "elevated"
                title: "Small Card"
                description: "Compact size with reduced padding and smaller text."
            }

            CCard {
                width: 220
                size: "md"
                variant: "elevated"
                title: "Medium Card"
                description: "Default size with standard padding and text."
            }

            CCard {
                width: 280
                size: "lg"
                variant: "elevated"
                title: "Large Card"
                description: "Larger size with increased padding and bigger text for better readability."
            }
        }

        // Sizes with Content
        Text {
            text: "Sizes with Custom Content"
            font.pixelSize: AppStyle.fontSizeLg
            font.weight: Font.Medium
            color: AppStyle.textColor
            topPadding: AppStyle.spacing4
        }

        Row {
            spacing: AppStyle.spacing4

            CCard {
                width: 200
                size: "sm"
                variant: "outline"
                spacing: AppStyle.spacing2

                Text {
                    text: "Small Size"
                    font.pixelSize: AppStyle.fontSizeMd
                    font.weight: Font.Medium
                    color: AppStyle.textColor
                }

                Text {
                    text: "Padding: 12px"
                    font.pixelSize: AppStyle.fontSizeXs
                    color: AppStyle.textSecondary
                    wrapMode: Text.WordWrap
                }

                CButton {
                    text: "Action"
                    size: "sm"
                }
            }

            CCard {
                width: 240
                size: "md"
                variant: "outline"
                spacing: AppStyle.spacing3

                Text {
                    text: "Medium Size"
                    font.pixelSize: AppStyle.fontSizeLg
                    font.weight: Font.Medium
                    color: AppStyle.textColor
                }

                Text {
                    text: "Padding: 16px (default)"
                    font.pixelSize: AppStyle.fontSizeSm
                    color: AppStyle.textSecondary
                    wrapMode: Text.WordWrap
                }

                CButton {
                    text: "Action"
                    size: "md"
                }
            }

            CCard {
                width: 300
                size: "lg"
                variant: "outline"
                spacing: AppStyle.spacing4

                Text {
                    text: "Large Size"
                    font.pixelSize: AppStyle.fontSizeXl
                    font.weight: Font.Medium
                    color: AppStyle.textColor
                }

                Text {
                    text: "Padding: 24px with more spacious layout"
                    font.pixelSize: AppStyle.fontSizeMd
                    color: AppStyle.textSecondary
                    wrapMode: Text.WordWrap
                }

                CButton {
                    text: "Action"
                    size: "lg"
                }
            }
        }

        // With Custom Content
        Text {
            text: "With Custom Content"
            font.pixelSize: AppStyle.fontSizeLg
            font.weight: Font.Medium
            color: AppStyle.textColor
            topPadding: AppStyle.spacing4
        }

        Row {
            spacing: AppStyle.spacing4

            CCard {
                width: 280
                variant: "elevated"
                spacing: AppStyle.spacing3

                Row {
                    spacing: AppStyle.spacing3

                    Rectangle {
                        width: 48
                        height: 48
                        radius: AppStyle.radiusFull
                        color: AppStyle.primaryColor

                        Text {
                            anchors.centerIn: parent
                            text: "JD"
                            color: "white"
                            font.weight: Font.Bold
                        }
                    }

                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 2

                        Text {
                            text: "John Doe"
                            font.pixelSize: AppStyle.fontSizeMd
                            font.weight: Font.Medium
                            color: AppStyle.textColor
                        }

                        Text {
                            text: "Software Engineer"
                            font.pixelSize: AppStyle.fontSizeSm
                            color: AppStyle.textSecondary
                        }
                    }
                }

                Text {
                    text: "Building amazing products with modern technologies."
                    font.pixelSize: AppStyle.fontSizeSm
                    color: AppStyle.textSecondary
                    wrapMode: Text.WordWrap
                }

                Row {
                    spacing: AppStyle.spacing2

                    CButton {
                        text: "Follow"
                        size: "sm"
                    }

                    CButton {
                        text: "Message"
                        size: "sm"
                        variant: "outline"
                    }
                }
            }

            // Within Form - Sign Up Card
            CCard {
                width: 300
                variant: "elevated"
                title: "Sign up"
                description: "Fill in the form below to create an account"
                spacing: AppStyle.spacing3

                CInput {
                    placeholderText: "First name"
                }

                CInput {
                    placeholderText: "Last name"
                }

                CInput {
                    placeholderText: "Email"
                }

                CInput {
                    placeholderText: "Password"
                    echoMode: TextInput.Password
                }

                CButton {
                    text: "Create account"
                    fullWidth: true
                }

                Text {
                    text: "Already have an account? Sign in"
                    font.pixelSize: AppStyle.fontSizeSm
                    color: AppStyle.primaryColor
                    horizontalAlignment: Text.AlignHCenter

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }

            CCard {
                width: 280
                variant: "outline"
                autoPadding: false

                Column {
                    width: parent.width
                    spacing: 0

                    Rectangle {
                        width: parent.width
                        height: 120
                        color: AppStyle.primaryColor
                        radius: AppStyle.radiusLg

                        Rectangle {
                            anchors.bottom: parent.bottom
                            width: parent.width
                            height: parent.radius
                            color: parent.color
                        }

                        CIcon {
                            anchors.centerIn: parent
                            name: "image"
                            size: 40
                            iconColor: "white"
                            opacity: 0.5
                        }
                    }

                    Column {
                        width: parent.width
                        padding: AppStyle.spacing4
                        spacing: AppStyle.spacing2

                        Text {
                            text: "Beautiful Landscape"
                            font.pixelSize: AppStyle.fontSizeLg
                            font.weight: Font.Medium
                            color: AppStyle.textColor
                        }

                        Text {
                            text: "Explore the amazing views and scenic beauty of nature."
                            font.pixelSize: AppStyle.fontSizeSm
                            color: AppStyle.textSecondary
                            width: parent.width - AppStyle.spacing4 * 2
                            wrapMode: Text.WordWrap
                        }

                        CButton {
                            text: "View Details"
                            size: "sm"
                            variant: "ghost"
                            leftIcon: "arrow-right"
                        }
                    }
                }
            }
        }
    }
}
