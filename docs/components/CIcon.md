# CIcon 组件

图标组件，使用图标字体显示图标。

## 示例

```qml
import Chakra

CIcon {
    name: "heart"
    size: 24
    iconColor: AppStyle.primaryColor
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| name | string | "" | 图标名称 |
| size | int | 16 | 图标大小（像素） |
| iconColor | color | AppStyle.textColor | 图标颜色 |

## 示例代码

### 基础用法

```qml
Row {
    spacing: 16

    CIcon { name: "house" }
    CIcon { name: "user" }
    CIcon { name: "gear" }
    CIcon { name: "heart" }
}
```

### 不同尺寸

```qml
Row {
    spacing: 16

    CIcon { name: "star"; size: 12 }
    CIcon { name: "star"; size: 16 }
    CIcon { name: "star"; size: 24 }
    CIcon { name: "star"; size: 32 }
}
```

### 不同颜色

```qml
Row {
    spacing: 16

    CIcon { name: "heart"; iconColor: AppStyle.primaryColor }
    CIcon { name: "heart"; iconColor: AppStyle.successColor }
    CIcon { name: "heart"; iconColor: AppStyle.warningColor }
    CIcon { name: "heart"; iconColor: AppStyle.errorColor }
}
```

### 配合按钮使用

```qml
CButton {
    leftIcon: "download"
    text: "下载"
}
```

## 可用图标

常用图标名称包括：
- 导航：`house`, `arrow-left`, `arrow-right`, `chevron-down`, `chevron-up`
- 操作：`plus`, `minus`, `x`, `check`, `search`, `download`, `upload`
- 用户：`user`, `users`, `gear`, `bell`
- 状态：`info`, `warning`, `check-circle`, `warning-circle`
- 其他：`heart`, `star`, `sun`, `moon`, `eye`, `eye-slash`

## 注意事项

1. 图标使用 Icons 单例中的字体，确保字体已正确加载。
2. 如果图标名称不存在，将显示空白。
3. 可在 Icons.qml 中查看所有可用图标。
