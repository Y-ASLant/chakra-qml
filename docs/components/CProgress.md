# CProgress 组件

进度条组件，支持条纹效果和不确定状态。

## 示例

```qml
import Chakra

CProgress {
    value: 60
    colorScheme: "primary"
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| value | real | 0 | 进度值（0-100） |
| colorScheme | string | "primary" | 颜色方案 |
| size | string | "md" | 尺寸，可选 "xs" / "sm" / "md" / "lg" |
| hasStripe | bool | false | 是否显示条纹效果 |
| isAnimated | bool | false | 是否动画条纹（需配合 hasStripe） |
| animationEnabled | bool | true | 是否启用动画（全局开关） |
| isIndeterminate | bool | false | 是否不确定状态（加载中） |

## 示例代码

### 基础用法

```qml
Column {
    spacing: 10
    width: 300

    CProgress { value: 25 }
    CProgress { value: 50 }
    CProgress { value: 75 }
    CProgress { value: 100 }
}
```

### 不同颜色

```qml
Column {
    spacing: 10
    width: 300

    CProgress { value: 60; colorScheme: "primary" }
    CProgress { value: 60; colorScheme: "success" }
    CProgress { value: 60; colorScheme: "warning" }
    CProgress { value: 60; colorScheme: "error" }
}
```

### 条纹效果

```qml
Column {
    spacing: 10
    width: 300

    CProgress { value: 60; hasStripe: true }
    CProgress { value: 60; hasStripe: true; isAnimated: true }
}
```

### 不确定状态

```qml
CProgress {
    isIndeterminate: true
    colorScheme: "primary"
}
```

## 注意事项

1. 条纹动画使用 Canvas 实现，兼容性好。
2. 不确定状态下进度条会来回滑动。
3. 可通过 `animationEnabled` 全局禁用动画以优化性能。
