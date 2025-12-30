# CSegmentedControl 组件问题记录

## 问题 1: Binding Loop

**错误信息:**
```
QML CSegmentedControl: Binding loop detected for property "maxItemWidth"
```

**原因:**
在属性绑定中修改 `TextMetrics.text` 会触发绑定重新计算，导致无限循环。

```qml
// 错误写法
property int maxItemWidth: {
    itemMetrics.text = items[i];  // 修改会触发重新计算
    return itemMetrics.width;
}
```

**解决方案:**
改用函数 + 信号处理器显式更新。

```qml
function calcMaxWidth() { ... }
property int maxItemWidth: 60

onItemsChanged: maxItemWidth = calcMaxWidth()
Component.onCompleted: maxItemWidth = calcMaxWidth()
```

---

## 问题 2: Property Set Multiple Times

**错误信息:**
```
Property value set multiple times
```

**原因:**
同一个信号处理器 `onItemsChanged` 定义了两次。

```qml
// 错误写法 - 两个 onItemsChanged
onItemsChanged: { currentIndex = 0; }
onItemsChanged: maxItemWidth = calcMaxWidth()  // 重复!
```

**解决方案:**
合并为一个处理器。

```qml
onItemsChanged: {
    if (currentIndex >= items.length)
        currentIndex = 0;
    maxItemWidth = calcMaxWidth();
}
```

---

**日期:** 2024-12-17
