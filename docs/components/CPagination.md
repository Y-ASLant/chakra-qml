# CPagination 组件

分页器组件，支持多种尺寸和紧凑模式。

## 示例

```qml
import Chakra

CPagination {
    count: 100
    page: 1
    pageSize: 10
    onPageRequested: function(newPage) {
        console.log("跳转到第", newPage, "页")
    }
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| count | int | 1 | 总数据条数 |
| page | int | 1 | 当前页码 |
| pageSize | int | 10 | 每页条数 |
| siblingCount | int | 1 | 当前页两侧显示的页码数 |
| size | string | "md" | 尺寸，可选 "sm" / "md" / "lg" |
| variant | string | "outline" | 变体 |
| colorScheme | string | "primary" | 颜色方案 |
| isCompact | bool | false | 是否紧凑模式 |
| showsFirstLast | bool | true | 是否显示首尾页按钮 |
| totalPages | int | - | 总页数（只读，自动计算） |

## 信号

| 信号名 | 参数 | 描述 |
|--------|------|------|
| pageRequested | int newPage | 请求翻页时触发 |

## 示例代码

### 基础用法

```qml
CPagination {
    count: 200
    page: 5
    pageSize: 20
}
```

### 紧凑模式

```qml
CPagination {
    count: 100
    page: 1
    isCompact: true
}
```

### 隐藏首尾按钮

```qml
CPagination {
    count: 100
    page: 1
    showsFirstLast: false
}
```

### 自定义显示数量

```qml
CPagination {
    count: 500
    page: 10
    siblingCount: 2  // 当前页两侧各显示2个页码
}
```

### 配合列表使用

```qml
Column {
    spacing: 20

    ListView {
        id: listView
        model: dataModel
        // ...
    }

    CPagination {
        count: totalCount
        page: currentPage
        pageSize: 10
        onPageRequested: function(newPage) {
            currentPage = newPage
            loadData(newPage)
        }
    }
}
```

## 注意事项

1. 页码过多时会自动显示省略号。
2. 紧凑模式只显示当前页/总页数和前后翻页按钮。
3. 首页/末页按钮在第一页/最后一页时自动禁用。
