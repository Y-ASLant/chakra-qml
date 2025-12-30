# CSpinner 组件

加载指示器组件，用于显示加载状态。

## 示例

```qml
import Chakra

CSpinner {
    size: "md"
    colorScheme: "primary"
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| size | string | "md" | 尺寸，可选 "xs" / "sm" / "md" / "lg" / "xl" |
| colorScheme | string | "primary" | 颜色方案 |
| color | color | - | 自定义颜色（覆盖 colorScheme） |

## 示例代码

### 不同尺寸

```qml
Row {
    spacing: 20
    
    CSpinner { size: "xs" }
    CSpinner { size: "sm" }
    CSpinner { size: "md" }
    CSpinner { size: "lg" }
    CSpinner { size: "xl" }
}
```

### 不同颜色

```qml
Row {
    spacing: 20

    CSpinner { colorScheme: "primary" }
    CSpinner { colorScheme: "success" }
    CSpinner { colorScheme: "warning" }
    CSpinner { colorScheme: "error" }
}
```

### 自定义颜色

```qml
CSpinner {
    color: "#ff6b6b"
}
```

### 配合按钮使用

```qml
CButton {
    text: "加载中"
    isLoading: true  // 按钮内置 Spinner
}
```

## 注意事项

1. 使用 Canvas 绘制，性能良好。
2. 只在可见时运行动画，隐藏时自动停止。
3. CButton 的 `isLoading` 属性会自动显示 Spinner。
