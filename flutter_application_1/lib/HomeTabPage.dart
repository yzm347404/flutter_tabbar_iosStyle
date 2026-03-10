import 'package:flutter/material.dart';
// 首页 Tab
class HomeTabPage extends StatelessWidget {
  const HomeTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
                backgroundColor: Colors.primaries[index % Colors.primaries.length],
              ),
              title: Text('新闻标题 $index'),
              subtitle: Text('点击查看详情'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // 在当前 Tab 的导航栈中推入新页面
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeDetailPage(itemId: index),
                    //全屏对话框样式（iOS 从底部弹出） 相当于present
                    fullscreenDialog: true
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// 首页详情页
class HomeDetailPage extends StatelessWidget {
  final int itemId;
  
  HomeDetailPage({required this.itemId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('详情页33 $itemId'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '这是第 $itemId 项的详情',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('进入子详情'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeSubDetailPage(itemId: itemId),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// 子详情页
class HomeSubDetailPage extends StatelessWidget {
  final int itemId;
  
  HomeSubDetailPage({required this.itemId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('子详情页'),
      ),
      body: Center(
        child: Text('这是更深一层的详情页'),
      ),
    );
  }
}