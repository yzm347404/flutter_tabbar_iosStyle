import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/EventBusService.dart';

// 我的 Tab
class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({super.key});

  @override
  _ProfileTabPageState createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  /*
  late 关键字
  告诉编译器："这个变量会稍后被初始化，我保证在使用前赋值"
  变量必须有值（非空），只是初始化延迟了
  如果使用前没赋值，运行时会报错

  可选类型（?）
  表示变量可以为 null
  是类型系统的一部分，告诉编译器："这个变量可能没有值"
  使用前需要判空处理
 */
  late StreamSubscription _logoutSubscription;
  String? _username;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 监听登出事件
    _logoutSubscription = EventBusService.instance.on<LogoutEvent>().listen((event) {
      setState(() {
        _username = event.username; // 更新用户名显示
      });
    });
  }

  @override
  void dispose() {
    // 取消订阅（类似 iOS 的 removeObserver）
    _logoutSubscription.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_username ?? '我的')),
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
              
              /*获取根 Navigator
              final rootNavigator = Navigator.of(context);
              获取最顶层的 Navigator
              final rootNavigator = Navigator.of(context, rootNavigator: true);
              */
              //直接使用Navigator是tab中的Navigator，可以保持tabar
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileDetailPage(),
                ),
              );

              ///别名路由需要使用根navigator，那么就吧tabar遮住了，如果要现实，那么只能使用分别的navigator
              // Navigator.of(
              //   context,
              //   rootNavigator: true,
              // ).pushNamed('/profileDetail');
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
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.favorite),
            title: Text('收藏'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesPage()),
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
  const ProfileDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('个人资料')),
      body: Center(child: Text('个人资料详情页')),
    );
  }
}

class ProfileInfo {
  String? name;
}

// 设置页面
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 获取参数
    //final args = ModalRoute.of(context)!.settings.arguments as ProfileInfo;
    return Scaffold(
      appBar: AppBar(title: Text('设置')),
      body: ListView(
        children: [
          SwitchListTile(title: Text('通知'), value: true, onChanged: (value) {}),
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
                MaterialPageRoute(builder: (context) => AboutPage()),
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
      appBar: AppBar(title: Text('关于')),
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
      appBar: AppBar(title: Text('收藏')),
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
      appBar: AppBar(title: Text('收藏详情')),
      body: Center(child: Text('收藏项目 $index 的详情')),
    );
  }
}
