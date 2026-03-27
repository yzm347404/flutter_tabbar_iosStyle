import 'package:flutter/material.dart';


class UIScrollerPage extends StatefulWidget {
  @override
  _UIScrollerPageState createState() => _UIScrollerPageState();
}

class _UIScrollerPageState extends State<UIScrollerPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      debugPrint('滚动位置: ${_scrollController.position.pixels}');
      debugPrint('最大范围: ${_scrollController.position.maxScrollExtent}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scroller Page')),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Center(child: Column(
          children: [
            Container(width: 200, height: 200, color: Colors.red),
            Container(width: 200, height: 200, color: Colors.green),
            Container(width: 200, height: 200, color: Colors.blue),
            Container(width: 200, height: 200, color: Colors.yellow),
          ],)
        ),
      ),
    );
  }
}
