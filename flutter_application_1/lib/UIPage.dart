import 'package:flutter/material.dart';
import './CustomTitle.dart';
import './UIScrollerPage.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
/*
1. 核心原理：Stack 的宽高如何决定？

Flutter 中，一个组件的尺寸通常由 约束（Constraints） 决定。Stack 的尺寸遵循以下逻辑：

情况 A：当 Stack 有父组件且父组件有约束时

如果父组件（例如一个 SizedBox 或 Container）强制 Stack 必须是一个固定大小（例如宽 200，高 200），那么 Stack 就会是 200x200。
如果父组件（例如 Scaffold 的 body）允许 Stack 自由选择大小，那么 Stack 会尝试扩张到能包裹住所有未被定位（non-positioned）的子组件。
情况 B：根据子组件决定大小（最常见）

Stack 的大小计算规则依赖于它的两个属性：fit 和 clipBehavior，以及子组件的类型。

非定位子组件（没有用 Positioned 包裹的）： 这些组件会影响 Stack 自身的大小。Stack 会试图变得足够大，以容纳所有非定位子组件。
定位子组件（用 Positioned 包裹的）： 这些组件不影响 Stack 的自身大小。 如果所有子组件都是 Positioned（即没有非定位组件），
那么 Stack 会试图变得尽可能小，除非父组件强制它变大。
*/

/*
关于使listview 能scroll到指定位置的最佳方案是使用scrollable_positioned_list: ^0.3.8 的ScrollablePositionedList
因为如果使用原生的listview会存在一开始无法获取item的context导致无法scroll到指定位置的问题，导致crash
而scrollable_positioned_list则是通过监听item的位置来实现滚动的，所以不会存在这个问题。
*/

/*
特性	                         SizedBox.expand	                                Expanded
父组件要求	                        任何组件	                              必须是 Row、Column 或 Flex
作用	                            占满父组件的全部空间	                     填充父组件的剩余空间
多个子组件	                       只能有一个子组件	                         可以有多个，按 flex 分配
等效代码	          width: double.infinity, height: double.infinity	      自动计算剩余空间
常见用途	                        让子组件填充父组件	                       让子组件等比例缩放，让子组件铺满整个区域	在 Row/Column 中让某个组件撑开
*/

class UIPage extends StatefulWidget {
  @override
  _UIPageState createState() => _UIPageState();
}

class _UIPageState extends State<UIPage> {
  final List<String> items = List.generate(50, (index) => 'Item $index');
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();
  late int currentIndex;

  Widget itemBuilder(BuildContext context, int index) {
    return CustomTitle(
      key: Key('$index'),
      title: items[index],
      onPressed: (title) {
        debugPrint('点击了 ${items[index]},title=$title');
      },
    );
  }

  void _scrollToIndex(int index) {
    _itemScrollController.scrollTo(
      index: index - 1,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      alignment: 0.5, // 0.5 表示居中
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('UI Page')),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            Container(
              width: 100,
              height: 100,
              color: Colors.blue,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Container(width: 40, height: 40, color: Colors.red),
                  ),
                  Positioned(
                    bottom: -10,
                    right: -10,
                    child: Container(
                      width: 40,
                      height: 40,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 100,
              height: 100,
              color: Colors.orange,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(width: 40, height: 40, color: Colors.red),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 40,
                      height: 40,
                      color: Colors.yellow,
                      child: Container(
                        width: 50,
                        height: 50,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 300,
              height: 200,
              color: Colors.purple,
              child: Wrap(
                direction: Axis.horizontal,
                //列间距
                spacing: 20,
                //行间距
                runSpacing: 30,
                children: [
                  Container(
                    height: 30,
                    color: Colors.green,
                    padding: EdgeInsets.all(2),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // 背景色
                        foregroundColor: Colors.yellow, // 字体颜色
                        textStyle: TextStyle(
                          fontSize: 18, // 字体大小
                          fontWeight: FontWeight.bold, // 字体粗细
                        ),
                      ),
                      onPressed: () {
                        debugPrint('按钮被点击');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            settings: RouteSettings(name: 'UIScrollerPage'),
                            builder: (context) => UIScrollerPage(),
                          ),
                        );
                      },
                      child: Text('跳转到ScrollerPage'),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 30,
                    color: Colors.green,
                    padding: EdgeInsets.all(2),
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          Colors.red,
                        ),
                        foregroundColor: WidgetStateProperty.all<Color>(
                          Colors.yellow,
                        ),
                      ),
                      onPressed: () {
                        debugPrint('按钮被点击');
                        // 处理点击事件
                      },
                      child: Text('点击我'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      debugPrint('GestureDetector 被点击');
                    },
                    child: Container(
                      width: 100,
                      height: 30,
                      color: Colors.yellow,
                    ),
                  ),
                  Image.asset(
                    "assets/images/icons/general_btn_previous_nor.png",
                  ),
                ],
              ),
            ),
            Container(
              width: 400,
              height: 185,
              color: Colors.pink,
              child: Row(
                spacing: 10,
                children: [
                  Container(
                    width: 200,
                    height: 185,
                    color: Colors.red,
                    child: ScrollablePositionedList.builder(
                      itemScrollController: _itemScrollController,
                      itemPositionsListener: _itemPositionsListener,
                      itemBuilder: itemBuilder,
                      itemCount: items.length,
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 30,
                    color: Colors.green,
                    child: TextField(
                      decoration: InputDecoration(
                        // labelText: '输入索引',
                        // border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        int? index = int.tryParse(value);
                        if (index!= null &&
                            index >= 1 &&
                            index <= items.length) {
                          currentIndex = index;
                        }
                      },
                    ),
                  ),
                  Container(
                    height: 30,
                    color: Colors.green,
                    child: ElevatedButton(
                      onPressed: () {
                        _scrollToIndex(currentIndex);
                      },
                      child: Text("跳到"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
