/*

📖 LayoutBuilder 是什么？

LayoutBuilder 是 Flutter 中一个非常实用的布局辅助组件。它的核心作用是：在布局阶段，获取父组件传递给它的约束（BoxConstraints），并根据这些约束动态构建不同的 UI。

简单来说，它让你能够“感知”到自己可用空间的大小，然后做出响应。

🎯 核心作用

作用	说明
获取父约束	拿到父组件赋予的 minWidth、maxWidth、minHeight、maxHeight
条件渲染	根据可用空间大小，渲染不同的子组件（如：大屏显示一行，小屏换行）
自适应布局	创建真正响应式的 UI，适配不同屏幕尺寸
精确计算	结合 TextPainter 等工具，精确判断文本是否溢出
🔧 基本用法

dart
LayoutBuilder(
  builder: (BuildContext context, BoxConstraints constraints) {
    // constraints 包含：minWidth, maxWidth, minHeight, maxHeight
    double availableWidth = constraints.maxWidth;
    
    if (availableWidth > 600) {
      // 大屏幕：显示宽布局
      return Row(children: [leftWidget, rightWidget]);
    } else {
      // 小屏幕：显示窄布局（上下排列）
      return Column(children: [topWidget, bottomWidget]);
    }
  },
)
📝 常用场景与实例

1️⃣ 根据屏幕宽度切换布局（响应式）

dart
Widget build(BuildContext context) {
  return Scaffold(
    body: LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          // 平板/桌面：并排显示
          return Row(
            children: [
              Expanded(child: SideMenu()),
              Expanded(flex: 3, child: MainContent()),
            ],
          );
        } else {
          // 手机：上下显示
          return Column(
            children: [
              SideMenu(),
              Expanded(child: MainContent()),
            ],
          );
        }
      },
    ),
  );
}
2️⃣ 判断文本是否溢出（你的需求）

dart
class AdaptiveText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const AdaptiveText({required this.text, required this.style});

  @override
  Widget build(BuildContext context) {
    // 先测量文本宽度
    final TextPainter painter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();

    return LayoutBuilder(
      builder: (context, constraints) {
        if (painter.width > constraints.maxWidth) {
          // 文本超出，使用跑马灯
          return Marquee(
            text: text,
            style: style,
            velocity: 100.0,
          );
        } else {
          // 文本未超出，普通显示
          return Text(
            text,
            style: style,
            maxLines: 1,
            overflow: TextOverflow.visible,
          );
        }
      },
    );
  }
}
3️⃣ 动态调整字体大小

dart
LayoutBuilder(
  builder: (context, constraints) {
    // 根据可用宽度调整字体大小
    double fontSize = constraints.maxWidth < 300 ? 14 : 18;
    
    return Text(
      '动态调整的文本',
      style: TextStyle(fontSize: fontSize),
    );
  },
)
4️⃣ 网格布局自适应列数

dart
LayoutBuilder(
  builder: (context, constraints) {
    int crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
    
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 20,
      itemBuilder: (context, index) => Card(child: Center(child: Text('Item $index'))),
    );
  },
)
5️⃣ 自适应 Padding

dart
LayoutBuilder(
  builder: (context, constraints) {
    double horizontalPadding = constraints.maxWidth > 600 ? 40.0 : 16.0;
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Card(child: Text('自适应边距')),
    );
  },
)
⚠️ 注意事项

注意点	说明
只能获取父约束	不能获取子组件的实际大小，那是 RenderObject 的范畴
不能用于异步操作	builder 是同步调用的，不适合做异步判断
避免过度使用	频繁重建会影响性能，注意 const 和缓存
父组件必须有约束	如果父组件是 UnconstrainedBox，maxWidth 可能是 double.infinity
🔄 LayoutBuilder vs 其他方案

方案	适用场景	获取内容
LayoutBuilder	根据父约束做条件布局	父组件给的约束（最大/最小宽高）
MediaQuery	获取屏幕或设备信息	屏幕尺寸、设备方向、字体缩放
CustomMultiChildLayout	复杂的自定义布局	可以获取子组件的实际大小
GlobalKey + RenderObject	获取组件实际渲染尺寸	组件在屏幕上占用的精确像素
💎 总结

LayoutBuilder 是 Flutter 响应式布局的利器，核心价值在于：

让 UI 感知空间边界
根据空间动态决策渲染什么、如何渲染
避免硬编码尺寸，使布局更灵活
对于你的跑马灯需求，用 LayoutBuilder 获取 constraints.maxWidth，再结合 TextPainter 判断文本宽度，是最精准、最优雅的方式。
 */