import 'package:flutter/material.dart';
// 我的 Tab
class ProfileTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 25,
              child: Icon(Icons.person, size: 30),
            ),
            title: Text('用户名'),
            subtitle: Text('个人资料'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileDetailPage(),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('设置'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('收藏'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// 个人资料详情
class ProfileDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人资料'),
      ),
      body: Center(
        child: Text('个人资料详情页'),
      ),
    );
  }
}

// 设置页面
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('通知'),
            value: true,
            onChanged: (value) {},
          ),
          SwitchListTile(
            title: Text('夜间模式'),
            value: false,
            onChanged: (value) {},
          ),
          ListTile(
            title: Text('关于'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// 关于页面
class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关于'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(size: 100),
            SizedBox(height: 20),
            Text('版本 1.0.0'),
          ],
        ),
      ),
    );
  }
}

// 收藏页面
class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('收藏'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.favorite, color: Colors.red),
            title: Text('收藏项目 $index'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteDetailPage(index: index),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// 收藏详情
class FavoriteDetailPage extends StatelessWidget {
  final int index;
  
  FavoriteDetailPage({required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('收藏详情'),
      ),
      body: Center(
        child: Text('收藏项目 $index 的详情'),
      ),
    );
  }
}