import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

/*
Dart 提供了三种参数类型：
必需位置参数 - 最基本的参数形式
可选位置参数 ([]) - 可选的、按顺序传递的参数
命名参数 ({}) - 可选的、按名称传递的参数

写法	                                是否必需	能否省略	使用场景
void xx(String a)	                    ✅ 必需	❌ 不能	核心参数，没有合理默认值
void xx(String? a)	                  ✅ 必需	❌ 不能	核心参数，但允许 null
void xx([String? a])	                ❌ 可选	✅ 可以	次要参数，有默认行为
void xx([String a = ''])	            ❌ 可选	✅ 可以	次要参数，有具体默认值
 */

class UIRefreshListPage extends StatefulWidget {
  @override
  _UIRefreshListPageState createState() => _UIRefreshListPageState();
}

class _UIRefreshListPageState extends State<UIRefreshListPage> {
  final items = List.generate(50, (i) => 'Item $i');
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();
  final EasyRefreshController _refreshController = EasyRefreshController(
    controlFinishRefresh: true, // 启用手动控制刷新完成
    controlFinishLoad: true, // 启用手动控制加载完成
  );

  final itemsNotifier = ValueNotifier<List<String>>([]);

  void onRefresh() async {
    await Future.delayed(Duration(milliseconds: 200));
    itemsNotifier.value = items;
    _refreshController.finishRefresh(IndicatorResult.success);
  }

  void onLoad() async {
    await Future.delayed(Duration(milliseconds: 200));
    var currentItems = itemsNotifier.value;
    var newItems = List.generate(
      20,
      (i) => 'new item ${currentItems.length + i}',
    );
    itemsNotifier.value = [...currentItems, ...newItems];
    _refreshController.finishLoad(itemsNotifier.value.length < 100 ? IndicatorResult.success : IndicatorResult.noMore);
  }

  void xx(String? a){

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    itemsNotifier.value = items;
  }

  @override
  void dispose() {
    itemsNotifier.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Refresh List')),
      body: EasyRefresh(
        controller: _refreshController,
        header: MaterialHeader(),
        footer: MaterialFooter(),
        onRefresh: () {
          onRefresh();
        },
        onLoad: () {
          onLoad();
        },
        child: ValueListenableBuilder<List<String>>(
          valueListenable: itemsNotifier,
          builder: (context, items, _) {
            return SizedBox.expand(
              child: ScrollablePositionedList.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(items[index]));
                },
                itemScrollController: _itemScrollController,
                itemPositionsListener: _itemPositionsListener,
              ),
            );
          },
        ),
      ),
    );
  }
}
