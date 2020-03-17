# flutter_tim

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# 问题：
在实现消息页面时，页面中有 items水平滑动手势 和 list竖直滑动列表，竖直滑动手势控制appBar的显示和隐藏，items自带的滑动事件
理想实现结果是水平手势触发 items水平滑动和item的ScrollView，竖直滑动手势触发 ListView和appBar的滑动事件响应，
**目前：**