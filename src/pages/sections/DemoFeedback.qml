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
            text: "Alert 提示"
            font.pixelSize: AppStyle.fontSize2xl
            font.weight: Font.Bold
            color: AppStyle.textColor
        }

        CAlert {
            width: parent.width - AppStyle.spacing6 * 2
            status: "info"
            title: "信息提示"
            description: "这是一条信息提示消息"
        }

        CAlert {
            width: parent.width - AppStyle.spacing6 * 2
            status: "success"
            variant: "solid"
            title: "操作成功"
            description: "您的操作已成功完成"
        }

        CAlert {
            width: parent.width - AppStyle.spacing6 * 2
            status: "warning"
            variant: "left-accent"
            title: "警告"
            description: "请注意这个警告信息"
            isClosable: true
        }

        CAlert {
            width: parent.width - AppStyle.spacing6 * 2
            status: "error"
            title: "错误"
            description: "发生了一个错误"
        }
    }
}
