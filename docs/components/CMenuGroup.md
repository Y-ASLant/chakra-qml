# CMenuGroup 组件

菜单分组组件，用于在 CMenu 中对菜单项进行分组。

## 示例

```qml
import Chakra

CMenu {
    CMenuGroup {
        title: "文件操作"

        CMenuItem { text: "新建" }
        CMenuItem { text: "打开" }
        CMenuItem { text: "保存" }
    }
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| title | string | "" | 分组标题 |
| items | alias | - | 子菜单项（default 属性） |

## 示例代码

### 多个分组

```qml
CMenu {
    CMenuGroup {
        title: "编辑"
        CMenuItem { text: "撤销"; command: "Ctrl+Z" }
        CMenuItem { text: "重做"; command: "Ctrl+Y" }
    }

    CMenuSeparator {}

    CMenuGroup {
        title: "视图"
        CMenuItem { text: "放大"; command: "Ctrl++" }
        CMenuItem { text: "缩小"; command: "Ctrl+-" }
    }
}
```

## 注意事项

1. 分组标题使用小号灰色文字显示。
2. 建议配合 CMenuSeparator 使用以区分不同分组。
