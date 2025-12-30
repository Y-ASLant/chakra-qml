# CCard 组件

卡片组件，支持多种变体、标题描述和自定义头部/底部。

## 示例

```qml
import Chakra

CCard {
    title: "卡片标题"
    description: "这是卡片描述"

    Text { text: "卡片内容" }
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| variant | string | "elevated" | 变体，可选 "elevated" / "outline" / "filled" / "subtle" |
| size | string | "md" | 尺寸，可选 "sm" / "md" / "lg" |
| title | string | "" | 卡片标题 |
| description | string | "" | 卡片描述 |
| header | Component | null | 头部自定义内容 |
| footer | Component | null | 底部自定义内容 |
| autoPadding | bool | true | 是否自动内边距 |
| padding | int | 16 | 内边距大小 |
| spacing | int | 16 | 内容间距 |
| hovered | bool | - | 悬停状态（只读） |

## 示例代码

### 不同变体

```qml
Row {
    spacing: 20

    CCard { title: "Elevated"; variant: "elevated"; width: 200 }
    CCard { title: "Outline"; variant: "outline"; width: 200 }
    CCard { title: "Filled"; variant: "filled"; width: 200 }
    CCard { title: "Subtle"; variant: "subtle"; width: 200 }
}
```

### 带头部和底部

```qml
CCard {
    width: 300

    header: Image {
        source: "cover.jpg"
        width: parent.width
        height: 150
        fillMode: Image.PreserveAspectCrop
    }

    title: "文章标题"
    description: "这是文章摘要..."

    footer: Row {
        padding: 16
        spacing: 10

        CButton { text: "阅读更多"; variant: "outline" }
        CButton { text: "收藏"; leftIcon: "heart"; variant: "ghost" }
    }
}
```

### 自定义内容

```qml
CCard {
    width: 300

    Column {
        spacing: 10

        Text { text: "用户信息"; font.bold: true }
        Text { text: "姓名：张三" }
        Text { text: "邮箱：zhangsan@example.com" }
    }
}
```

## 注意事项

1. `elevated` 变体带有阴影效果，悬停时阴影会增强。
2. 悬停时边框颜色会变化，提供视觉反馈。
3. 子元素宽度会自动适应卡片内容区域宽度。
