import 'package:flutter/material.dart';
// 发现 Tab
class ExploreTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('发现'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExploreDetailPage(index: index),
                ),
              );
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image, size: 50),
                  Text('发现 $index'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// 发现详情页
class ExploreDetailPage extends StatelessWidget {
  final int index;
  
  ExploreDetailPage({required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('发现详情'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('发现项目 $index 的详情'),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('更多内容'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExploreMorePage(index: index),
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

// 发现更多页
class ExploreMorePage extends StatelessWidget {
  final int index;
  
  ExploreMorePage({required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('更多内容'),
      ),
      body: Center(
        child: Text('发现项目的更多内容'),
      ),
    );
  }
}