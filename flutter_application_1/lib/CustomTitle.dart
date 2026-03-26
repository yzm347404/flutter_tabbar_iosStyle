import 'package:flutter/material.dart';

typedef CustomTitleOnTapAction = void Function(String title);

class CustomTitle extends StatefulWidget {
  final String title;
  final CustomTitleOnTapAction? onPressed;
  CustomTitle({Key? key, required this.title, this.onPressed})
    : super(key: key);

  @override
  _CustomTitleState createState() => _CustomTitleState();
}

class _CustomTitleState extends State<CustomTitle> {
  /*
  错误使用
  static final selectedNotifier = ValueNotifier<bool>(false);
  static 变量的生命周期应该和 App 一致，在实例的 dispose 中释放会导致后续实例无法使用
  这种写法会导致所有 CustomTitle 实例共享同一个 selectedNotifier，导致点击一个标题会影响所有标题的状态。·
  */
  final selectedNotifier = ValueNotifier<bool>(false);

  /*
  statefulWidget生命周期
  创建 State 对象
    │
    ▼
initState()  ← 只执行一次
    │
    ▼
didChangeDependencies()  ← 可能多次
    │
    ▼
build()  ← 第一次构建
    │
    ▼
    ├─── 用户交互/事件触发 setState() ────┐
    │                                      │
    ├─── 父组件重建，参数变化 ────────────┤
    │                                      │
    └─── InheritedWidget 变化 ────────────┤
                                           ▼
                                    didUpdateWidget()  ← 仅在 widget 参数变化时
                                           │
                                           ▼
                                    didChangeDependencies()  ← 依赖变化时
                                           │
                                           ▼
                                        build()  ← 重新构建
                                           │
    ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┘
    
    页面关闭/Widget 移除
           │
           ▼
    deactivate()  ← 从树中移除（可能重新插入）
           │
           ▼
         dispose()  ← 永久销毁*/
  
  @override
  void initState() {
    super.initState();
    debugPrint('1. initState - 状态初始化');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('2. didChangeDependencies - 依赖变化（可能多次调用）');
  }

  /*
  didUpdateWidget 的执行时机
  触发方式	                             didUpdateWidget 是否执行	                  说明
  父组件 setState 并传入新参数	           ✅ 执行	widget                  被重新创建，但 State 被复用
  内部 setState	                         ❌ 不执行	                      widget 本身没变，只是 State 变了
  ValueNotifier 触发重建	               ❌ 不执行	                     只是 ValueListenableBuilder 重建，不是 widget 重建
  父组件重新 build 但参数相同	             ⚠️ 不一定	                      如果参数相同，Flutter 可能优化不重建
   */
  @override
  void didUpdateWidget(covariant CustomTitle oldWidget) { 
    super.didUpdateWidget(oldWidget);
    debugPrint('3. didUpdateWidget - Widget 配置更新');
  }

  @override
  void deactivate() {
    super.deactivate();
    debugPrint('5. deactivate - 从树中移除（可能重新插入）');
  }
  
    @override
  void dispose() {
    debugPrint('6. dispose - 永久销毁');
    selectedNotifier.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
     debugPrint('4. build - 构建 UI');
    return GestureDetector(
      onTap: () {
        if (widget.onPressed != null) {
          selectedNotifier.value = !selectedNotifier.value;
          widget.onPressed!(widget.title);
        }
      },
      child: ValueListenableBuilder(
        valueListenable: selectedNotifier,
        builder: (context, title, child) {
          return Container(
            padding: const EdgeInsets.all(16),
            color: selectedNotifier.value ? Colors.green : Colors.yellow,
            child: Center(
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
