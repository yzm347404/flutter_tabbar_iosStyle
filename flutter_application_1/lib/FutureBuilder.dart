/*
FutureBuilder 是 Flutter 中处理异步任务（如网络请求、数据库读取）的利器。它能根据异步操作的不同状态（加载中、成功、失败）自动构建对应的 UI，让你无需手动管理状态和 setState。

它就像一个智能的 UI 开关，核心逻辑都围绕 AsyncSnapshot 这个“快照”展开。下面是它的一个基本用法示例，你可以从中看到其完整的结构：

dart
FutureBuilder<String>(
  future: fetchData(), // 你的异步任务
  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
    // 1. 判断是否在加载中
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }
    // 2. 判断是否发生了错误
    else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }
    // 3. 判断是否成功获取数据
    else if (snapshot.hasData) {
      return Text('Data: ${snapshot.data}');
    }
    // 4. 其他情况（例如 future 为 null）
    else {
      return Text('No data');
    }
  },
)
🚀 如何使用 FutureBuilder

使用 FutureBuilder 主要分三步走：

准备 Future：这是你要执行的异步任务，比如一个返回 Future<String> 的网络请求方法。
创建 FutureBuilder：将它放在你的 Widget 树中，并传入 future 参数。
实现 builder 函数：这是核心。根据 AsyncSnapshot 参数的状态，返回不同的 Widget。
1. 关键参数与 AsyncSnapshot 对象

future: 你传入的异步任务。切记，这个 Future 对象必须在 initState 或其他地方提前创建好，绝对不能在 builder 或 build 方法中直接创建，否则会导致无限重建。
initialData: 可选参数，在 Future 完成前显示的初始数据。
AsyncSnapshot: builder 函数的第二个参数，包含了异步任务的当前状态。

AsyncSnapshot 属性	说明
connectionState	连接状态，主要关注 waiting（等待中）和 done（已完成）。
hasData	bool，是否有数据返回。
hasError	bool，是否发生错误。
data	成功时返回的数据。
error	失败时的错误对象。
2. 判断顺序建议

为了 UI 的健壮性，推荐按以下顺序处理状态：
hasError → hasData → 默认（如加载中或空状态）。

✅ 正确实践与避坑指南

这是新手最容易犯错的地方，请一定注意：

正确初始化 Future：推荐在 StatefulWidget 的 initState 方法中创建 Future 对象并保存，而不是在 build 方法中直接传参。

dart
// ✅ 正确做法：在 initState 中初始化
class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  late final Future<String> _myFuture;

  @override
  void initState() {
    super.initState();
    _myFuture = fetchData(); // 只执行一次
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _myFuture, // 直接引用
      builder: (context, snapshot) {
        // ...
      },
    );
  }
}
错误做法：在 build 方法里直接调用 fetchData()。这样每次 Widget 重建都会发起新请求，可能造成死循环和性能浪费。
💎 进阶技巧

封装复用：你可以将通用的异步加载逻辑（如加载动画、错误提示）封装成一个自定义组件，提升代码复用率。
处理竞态条件：如果异步任务触发频繁（如搜索建议），需考虑取消旧请求，避免旧数据覆盖新数据。
性能优化：可以为 FutureBuilder 设置 key，当 future 不变时复用实例，避免不必要的重建。
 */