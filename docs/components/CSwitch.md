# CSwitch 组件

开关组件，支持轨道标签和滑块图标。

## 示例

```qml
import Chakra

CSwitch {
    text: "启用通知"
    checked: true
}
```

## 属性

| 属性名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| colorScheme | string | "primary" | 颜色方案 |
| size | string | "md" | 尺寸，可选 "sm" / "md" / "lg" |
| trackLabelOn | string | "" | 开启时轨道上显示的文字 |
| trackLabelOff | string | "" | 关闭时轨道上显示的文字 |
| thumbIconOn | string | "" | 开启时滑块上的图标 |
| thumbIconOff | string | "" | 关闭时滑块上的图标 |

## 示例代码

### 基础用法

```qml
Column {
    spacing: 10

    CSwitch { text: "Wi-Fi" }
    CSwitch { text: "蓝牙"; checked: true }
}
```

### 带轨道标签

```qml
CSwitch {
    text: "状态"
    trackLabelOn: "ON"
    trackLabelOff: "OFF"
}
```

### 带滑块图标

```qml
CSwitch {
    text: "主题"
    thumbIconOn: "sun"
    thumbIconOff: "moon"
}
```

### 不同尺寸

```qml
Row {
    spacing: 20

    CSwitch { size: "sm"; checked: true }
    CSwitch { size: "md"; checked: true }
    CSwitch { size: "lg"; checked: true }
}
```

## 注意事项

1. 轨道标签会使开关轨道变宽以容纳文字。
2. 滑块有悬停放大和按下缩小的动画效果。
3. 继承自 Switch，支持所有原生属性。
