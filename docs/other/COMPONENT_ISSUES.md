# 组件库问题修复清单

本文档记录了 chakra-qml 组件库中需要修复的问题，按优先级排序。

---

## 高优先级（立即修复）

### 1. 统一属性命名规范

#### 1.1 CAlert 使用 status 而非 colorScheme
**文件**: `src/components/CAlert.qml:7`  
**问题**: 使用 `status` 属性不符合其他组件的 `colorScheme` 约定  
**当前代码**:
```qml
property string status: "info"
```
**建议方案**: 
- 方案A: 改为 `colorScheme`，保留 `status` 作为别名以兼容
- 方案B: 新增 `variant` 属性表达严重程度，使用 `colorScheme` 表达颜色

---

#### 1.2 CSpinner 使用 color 而非 colorScheme
**文件**: `src/components/CSpinner.qml:10`  
**问题**: 使用 `color` 属性，应改为 `colorScheme` 以保持一致性  
**当前代码**:
```qml
property color color: AppStyle.primaryColor
```
**修复方案**:
```qml
property string colorScheme: "primary"
property color color: AppStyle.getSchemeColor(colorScheme)
```

---

#### 1.3 CScrollArea 使用 scrollDirection 而非标准命名
**文件**: `src/components/CScrollArea.qml:10`  
**问题**: 应使用独立的布尔属性或遵循 Qt 的 orientation 约定  
**当前代码**:
```qml
property string scrollDirection: "vertical"
```
**建议方案**:
```qml
// 方案A: 布尔属性（推荐）
property bool horizontal: false
property bool vertical: true

// 方案B: Qt 标准
property int orientation: Qt.Vertical  // Qt.Horizontal, Qt.Vertical
property bool bothDirections: false
```

---

### 2. 性能优化 - CSelect 过滤模型

**文件**: `src/components/CSelect.qml:31-43`  
**问题**: filteredModel 每次访问都重新计算整个数组，严重影响性能  
**当前代码**:
```qml
readonly property var filteredModel: {
    if (!isSearchable || searchText === "" || !model)
        return model;
    var result = [];
    var search = searchText.toLowerCase();
    for (var i = 0; i < model.length; i++) {
        var item = model[i];
        if (String(item).toLowerCase().indexOf(search) !== -1) {
            result.push(item);
        }
    }
    return result;
}
```
**修复方案**:
```qml
property var _cachedFilteredModel: []
property int _filterVersion: 0

function updateFilteredModel() {
    if (!isSearchable || searchText === "" || !model) {
        _cachedFilteredModel = model;
        return;
    }
    var result = [];
    var search = searchText.toLowerCase();
    for (var i = 0; i < model.length; i++) {
        var item = model[i];
        if (String(item).toLowerCase().indexOf(search) !== -1) {
            result.push(item);
        }
    }
    _cachedFilteredModel = result;
    _filterVersion++;
}

onModelChanged: updateFilteredModel()
onSearchTextChanged: updateFilteredModel()
onIsSearchableChanged: updateFilteredModel()

// 在 ComboBox 中使用
model: _cachedFilteredModel
```

---

### 3. 性能优化 - CPagination 页码数组生成

**文件**: `src/components/CPagination.qml:34-78`  
**问题**: Repeater 每次渲染都调用 generatePageNumbers() 函数  
**影响**: 频繁创建数组，影响性能  
**修复方案**:
```qml
// 添加缓存属性
property var _cachedPageNumbers: []

// 监听变化并更新缓存
onTotalPagesChanged: _cachedPageNumbers = generatePageNumbers()
onPageChanged: _cachedPageNumbers = generatePageNumbers()
onSiblingCountChanged: _cachedPageNumbers = generatePageNumbers()

// Repeater 使用缓存
Repeater {
    model: root._cachedPageNumbers
}
```

---

### 4. 性能优化 - CAlert 重复颜色计算

**文件**: `src/components/CAlert.qml:22-59`  
**问题**: statusColor、statusBgColor、statusIcon 都独立绑定到 status，导致重复计算  
**当前代码**: 3个独立的 switch 语句  
**修复方案**:
```qml
// 方案A: 合并到 QtObject
readonly property QtObject statusConfig: QtObject {
    readonly property color color: {
        switch (root.status) {
        case "success": return AppStyle.successColor;
        case "warning": return AppStyle.warningColor;
        case "error": return AppStyle.errorColor;
        default: return AppStyle.infoColor;
        }
    }
    readonly property color bgColor: {
        switch (root.status) {
        case "success": return AppStyle.successLight;
        case "warning": return AppStyle.warningLight;
        case "error": return AppStyle.errorLight;
        default: return AppStyle.infoLight;
        }
    }
    readonly property string icon: {
        switch (root.status) {
        case "success": return "check-circle";
        case "warning": return "warning";
        case "error": return "warning-circle";
        default: return "info";
        }
    }
}

// 使用: statusConfig.color, statusConfig.bgColor, statusConfig.icon
```

---

## 中优先级

### 5. 布尔属性命名统一

**问题**: 混用 `isXxx` 和直接命名  
**影响文件**: 多个组件  
**示例**:
- CAlert: `isClosable` (好)
- CPagination: `compact`, `showFirstLast` (应改为 `isCompact`, `showsFirstLast`)

**修复方案**: 统一使用 `isXxx` 或 `hasXxx` 前缀表示布尔状态

---

### 6. 尺寸规格统一

**问题**: 不同组件的 size 规格不一致  
**当前状态**:
- 3级（sm/md/lg）：CButton, CBadge, CCard, CCheckbox, CInput, CMenu, CMenuItem, CSelect, CSwitch, CTag, CPagination
- 4级（xs/sm/md/lg）：CProgress, CSegmentedControl, CScrollArea
- 5级（xs/sm/md/lg/xl）：CSpinner
- 6级（xs/sm/md/lg/xl/full）：CDialog, CContainer

**建议规范**:
```
基础交互组件: sm/md/lg (3级)
  - CButton, CInput, CSelect, CCheckbox, CSwitch, CBadge, CTag
  
数据展示组件: xs/sm/md/lg (4级)
  - CProgress, CSpinner, CSegmentedControl, CScrollArea
  - CSpinner 的 xl 可保留用于特殊场景
  
容器布局组件: xs/sm/md/lg/xl/full (6级)
  - CDialog, CContainer, CDrawer
  - full 表示全屏/全宽
```

**实施建议**: 
1. 当前规格基本合理，无需大幅调整
2. 保持向后兼容，不删除现有尺寸
3. 文档中明确说明各组件支持的尺寸范围

---

### 7. CProgress Canvas 条纹动画优化

**文件**: `src/components/CProgress.qml:80-114`  
**问题**: Canvas 动画每帧重绘，CPU 占用高  
**修复方案**: 
- 限制帧率到 30fps
- 考虑使用 ShaderEffect 替代
- 添加 `animationEnabled` 属性让用户控制

---

### 8. CSegmentedControl 宽度计算缓存

**文件**: `src/components/CSegmentedControl.qml:39-47`  
**问题**: calcMaxWidth() 可能频繁调用  
**修复方案**: 添加缓存机制，只在 items 或字体改变时重新计算

---

### 9. CMenu 子项信号连接优化

**文件**: `src/components/CMenu.qml:176-184`  
**问题**: 嵌套循环连接信号，children 变化时触发大量操作  
**修复方案**: 使用 Connections 组件或改进连接逻辑

---

## 低优先级（长期优化）

### 10. 添加组件 JSDoc 注释

**问题**: 缺少代码注释和使用文档  
**示例格式**:
```qml
/**
 * CButton - 按钮组件
 * 
 * @property {string} variant - 变体: solid, outline, ghost, link
 * @property {string} colorScheme - 颜色方案
 * @property {string} size - 尺寸: sm, md, lg
 * 
 * @example
 * CButton {
 *     text: "Click me"
 *     variant: "solid"
 *     colorScheme: "blue"
 *     onClicked: console.log("Clicked")
 * }
 */
```

---

### 11. 添加属性验证

**目的**: 在开发时提供友好的错误提示  
**示例**:
```qml
property string variant: "solid"
onVariantChanged: {
    if (!["solid", "outline", "ghost", "link"].includes(variant)) {
        console.warn("CButton: Invalid variant '" + variant + "'. Valid values: solid, outline, ghost, link")
    }
}
```

---

### 12. 默认值统一

**问题**: 不同组件的默认 colorScheme 不一致  
- CButton: "blue"
- CBadge: "primary"
- CCheckbox: "primary"

**建议**: 统一为 "primary" 或 "blue"

---

### 13. 创建组件使用文档

**建议结构**:
```
docs/
  components/
    CButton.md
    CInput.md
    CAlert.md
    ...
```

每个文档包含:
- 组件说明
- 属性列表
- 使用示例
- 最佳实践

---

## 修复顺序建议

1. **第一批** (即刻修复，影响最大):
   - 问题 2: CSelect 性能优化
   - 问题 3: CPagination 性能优化
   - 问题 4: CAlert 性能优化

2. **第二批** (重要但不紧急):
   - 问题 1.1-1.3: 属性命名统一
   - 问题 5: 布尔属性命名

3. **第三批** (改善用户体验):
   - 问题 7-9: 其他性能优化
   - 问题 6: 尺寸规格统一

4. **第四批** (长期规划):
   - 问题 10-13: 文档和开发体验

---

## 测试计划

每次修复后需要测试:
1. 组件功能正常
2. 性能是否改善（使用 Qt Creator Profiler）
3. API 兼容性
4. Demo 页面运行正常

---

## 进度追踪

- [ ] 问题 1.1: CAlert 属性重命名（保留 status，性能已优化）
- [x] 问题 1.2: CSpinner 属性重命名（已完成，添加 colorScheme）
- [x] 问题 1.3: CScrollArea 属性重命名（已完成，改为 horizontal/vertical）
- [x] 问题 2: CSelect 性能优化（已完成，添加缓存机制）
- [x] 问题 3: CPagination 性能优化（已完成，页码数组缓存）
- [x] 问题 4: CAlert 性能优化（已完成，使用 readonly 属性）
- [x] 问题 5: 布尔属性命名统一（已完成，CPagination、CSegmentedControl 添加别名）
- [x] 问题 6: 尺寸规格统一（已分析，当前规格合理，已制定规范）
- [x] 问题 7: CProgress 动画优化（已完成，添加 animationEnabled 属性）
- [x] 问题 8: CSegmentedControl 优化（已完成，添加宽度计算缓存）
- [x] 问题 9: CMenu 优化（已确认，现有实现已优化）
- [ ] 问题 10: 添加注释（部分完成：CButton、CProgress 已有完整注释）
- [ ] 问题 11: 添加验证
- [x] 问题 12: 默认值统一（已完成，CTag colorScheme 改为 primary）
- [x] 问题 13: 创建文档（已完成，QUICK_REFERENCE.md）

---

**最后更新**: 2025-12-20 14:30
**审查人**: AI Assistant
**组件总数**: 33
**已完成优化**: 12/13

## 本次批量修复总结

### 高优先级（已完成）
- ✅ CSpinner: 添加 colorScheme 属性
- ✅ CScrollArea: 改为 horizontal/vertical 布尔属性
- ✅ CAlert: 使用 readonly 优化性能
- ✅ CSelect: 添加过滤模型缓存
- ✅ CPagination: 添加页码数组缓存

### 中优先级（已完成）
- ✅ CPagination: isCompact/showsFirstLast（已更新所有引用）
- ✅ CSegmentedControl: isDisabled（已更新所有引用）+ 宽度计算缓存
- ✅ CMenu: 确认已优化
- ✅ 尺寸规格: 制定分类规范

**注**: 组件库未发布，所有修改直接采用新命名，无向后兼容

### 待完成
- ✅ CProgress 动画优化（已添加 animationEnabled 属性）
- ⏳ 添加 JSDoc 注释（部分完成：CButton、CProgress）
- ⏳ 属性验证
- ✅ 统一默认值（CTag colorScheme 改为 primary）
- ✅ 组件使用文档（已创建 QUICK_REFERENCE.md）
