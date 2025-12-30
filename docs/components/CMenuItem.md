# CMenuItem 组件

菜单项组件，用于 CMenu 内部。

## 示例

```qml
import Chakra

CMenuItem {
    text: "编辑"
    menuIcon: "edit"
    onClicked: console.log("编辑")
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| size | string | "md" | 尺寸，可选 "sm" / "md" / "lg" |
| menuIcon | string | "" | 图标名称 |
| command | string | "" | 快捷键文本 |
| colorScheme | string | "" | 颜色方案，可选 "red" / "danger" 用于危险操作 |
| isDisabled | bool | false | 是否禁用 |
| closeOnClick | bool | true | 点击后是否关闭菜单 |
| value | var | null | 值（用于 Radio/Checkbox 菜单项） |

## 信号

| 信号名 | 描述 |
|--------|------|
| closeMenu | 关闭菜单信号（内部使用） |

## 示例代码

### 带图标

```qml
CMenu {
    CMenuItem { text: "首页"; menuIcon: "house" }
    CMenuItem { text: "设置"; menuIcon: "gear" }
    CMenuItem { text: "用户"; menuIcon: "user" }
}
```

### 危险操作

```qml
CMenu {
    CMenuItem { text: "编辑" }
    CMenuSeparator {}
    CMenuItem { text: "删除"; menuIcon: "trash"; colorScheme: "red" }
}
```

### 禁用项

```qml
CMenu {
    CMenuItem { text: "可用" }
    CMenuItem { text: "禁用"; isDisabled: true }
}
```

### 不关闭菜单

```qml
CMenu {
    CMenuItem {
        text: "切换选项"
        closeOnClick: false
        onClicked: checked = !checked
    }
}
```

## 注意事项

1. 必须在 CMenu 内部使用。
2. `colorScheme: "red"` 或 `"danger"` 会使文字和图标变红。
3. 点击时有缩放动画效果。
