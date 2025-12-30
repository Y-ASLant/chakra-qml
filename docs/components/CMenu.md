# CMenu 组件

菜单组件，支持自定义触发器和多种定位方式。

## 示例

```qml
import Chakra

CMenu {
    CMenuItem { text: "新建"; menuIcon: "plus" }
    CMenuItem { text: "打开"; menuIcon: "folder" }
    CMenuSeparator {}
    CMenuItem { text: "删除"; menuIcon: "trash"; colorScheme: "red" }
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| size | string | "md" | 尺寸，可选 "sm" / "md" / "lg" |
| trigger | Component | CButton | 触发器组件 |
| menuWidth | int | 200 | 菜单宽度 |
| maxHeight | int | 300 | 菜单最大高度 |
| placement | string | "bottom" | 定位，可选 "bottom" / "top" / "left" / "right" |
| isOpen | bool | - | 菜单是否打开（只读） |

## 信号

| 信号名 | 描述 |
|--------|------|
| menuOpened | 菜单打开时触发 |
| menuClosed | 菜单关闭时触发 |

## 方法

| 方法名 | 描述 |
|--------|------|
| open() | 打开菜单 |
| close() | 关闭菜单 |
| toggle() | 切换菜单 |

## 示例代码

### 自定义触发器

```qml
CMenu {
    trigger: CButton {
        text: "操作"
        rightIcon: "chevron-down"
    }

    CMenuItem { text: "编辑" }
    CMenuItem { text: "复制" }
    CMenuItem { text: "删除" }
}
```

### 带分组

```qml
CMenu {
    CMenuGroup {
        title: "文件"
        CMenuItem { text: "新建" }
        CMenuItem { text: "打开" }
    }

    CMenuSeparator {}

    CMenuGroup {
        title: "编辑"
        CMenuItem { text: "撤销" }
        CMenuItem { text: "重做" }
    }
}
```

### 带快捷键

```qml
CMenu {
    CMenuItem { text: "保存"; menuIcon: "save"; command: "Ctrl+S" }
    CMenuItem { text: "另存为"; command: "Ctrl+Shift+S" }
}
```

## 注意事项

1. 点击菜单项后默认会关闭菜单。
2. 菜单内容超出 maxHeight 时会显示滚动条。
3. 有进入和退出动画效果。
