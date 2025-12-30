# CMenuSeparator 组件

菜单分隔线组件，用于在 CMenu 中分隔菜单项。

## 示例

```qml
import Chakra

CMenu {
    CMenuItem { text: "编辑" }
    CMenuSeparator {}
    CMenuItem { text: "删除" }
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| topMargin | int | AppStyle.spacing1 | 上边距 |
| bottomMargin | int | AppStyle.spacing1 | 下边距 |

## 示例代码

### 基础用法

```qml
CMenu {
    CMenuItem { text: "复制" }
    CMenuItem { text: "粘贴" }
    CMenuSeparator {}
    CMenuItem { text: "删除"; colorScheme: "red" }
}
```

### 自定义边距

```qml
CMenu {
    CMenuItem { text: "选项 A" }
    CMenuSeparator { topMargin: 8; bottomMargin: 8 }
    CMenuItem { text: "选项 B" }
}
```

## 注意事项

1. 分隔线两侧有小边距，不会贴边显示。
2. 颜色跟随主题自动变化。
