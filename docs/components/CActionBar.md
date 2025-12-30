# CActionBar 组件

操作栏组件，用于批量操作时显示的浮动工具栏。

## 示例

```qml
import Chakra

CActionBar {
    open: selectedCount > 0
    selectionCount: selectedCount

    CButton { text: "删除"; colorScheme: "error" }
    CButton { text: "移动"; variant: "outline" }
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| open | bool | false | 是否显示 |
| selectionCount | int | 0 | 选中数量 |
| content | alias | - | 内容区域（default 属性） |

## 信号

| 信号名 | 描述 |
|--------|------|
| closed | 关闭时触发 |
| selectAllClicked | 全选按钮点击时触发 |

## 示例代码

### 基础用法

```qml
Item {
    property int selectedCount: 0

    ListView {
        // 列表内容...
    }

    CActionBar {
        open: selectedCount > 0
        selectionCount: selectedCount

        CButton { text: "删除"; colorScheme: "error"; leftIcon: "trash" }
        CButton { text: "导出"; variant: "outline"; leftIcon: "download" }
        CButton { text: "取消"; variant: "ghost"; onClicked: selectedCount = 0 }
    }
}
```

### 配合表格使用

```qml
Column {
    TableView {
        id: table
        // 表格内容...
    }

    CActionBar {
        open: table.selectedRows.length > 0
        selectionCount: table.selectedRows.length

        CButton { text: "批量编辑"; leftIcon: "edit" }
        CButton { text: "批量删除"; colorScheme: "error"; leftIcon: "trash" }
    }
}
```

## 注意事项

1. 操作栏固定在父容器底部，有上浮动画。
2. 自动显示选中数量。
3. 有阴影效果，确保在内容之上可见。
4. 关闭时有淡出和下沉动画。
