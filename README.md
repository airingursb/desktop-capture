# Desktop Capture - Mac侧边栏快速输入应用

这是一个Mac原生应用程序，复刻了DEVONthink样式的侧边栏快速输入界面。

## 功能特点

- 📝 系统状态栏图标，点击显示输入界面
- 🎯 简洁的表单界面，包含Name、Body、URL字段
- 🔧 Format和Location下拉选择器
- ➕ 快速添加按钮
- 🖥️ 原生Mac应用，无dock图标

## 运行方式

```bash
# 构建应用
swift build

# 运行应用
swift run
```

运行后，状态栏会出现📝图标，点击即可弹出输入界面。

## 项目结构

```
DesktopCapture/
├── Package.swift              # Swift包配置
└── Sources/DesktopCapture/
    ├── main.swift            # 应用入口
    ├── AppDelegate.swift     # 应用委托和状态栏管理
    └── ContentView.swift     # 主UI界面
```

## 技术栈

- Swift + SwiftUI
- AppKit (状态栏集成)
- macOS 13.0+

## 使用说明

1. 运行应用后，状态栏会显示📝图标
2. 点击图标弹出输入界面
3. 填写相关内容后点击"Add"按钮
4. 应用会在控制台打印输入的内容（可扩展为保存到文件等功能）