import 'package:flutter/material.dart';
import './ExploreTabPage.dart';
import './HomeTabPage.dart';
import './ProfileTabPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iOS 风格 TabBar',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: IOSTabBarDemo(),
    );
  }
}

// iOS 风格的主页面
class IOSTabBarDemo extends StatefulWidget {
  @override
  _IOSTabBarDemoState createState() => _IOSTabBarDemoState();
}

class _IOSTabBarDemoState extends State<IOSTabBarDemo> {
  int _currentIndex = 0;
  
  // 每个 Tab 都有自己的导航键
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // 处理返回按钮：让当前 Tab 的导航栈处理返回
        final isFirstRouteInCurrentTab = 
            !await _navigatorKeys[_currentIndex].currentState!.maybePop();
        
        // 如果是当前 Tab 的根页面，再退出 App
        if (isFirstRouteInCurrentTab) {
          return true;  // 退出 App
        }
        return false;  // 已经处理了返回
      },
      child: Scaffold(
        body: Stack(
          children: [
            // 每个 Tab 的 Navigator 都叠加在一起
            _buildOffstageNavigator(0),
            _buildOffstageNavigator(1),
            _buildOffstageNavigator(2),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '首页',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: '发现',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '我的',
            ),
          ],
        ),
      ),
    );
  }

  // 构建每个 Tab 的 Navigator
  Widget _buildOffstageNavigator(int index) {
    return Offstage(
      offstage: _currentIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) {
              // 返回对应 Tab 的首页
              switch (index) {
                case 0:
                  return HomeTabPage();
                case 1:
                  return ExploreTabPage();
                case 2:
                  return ProfileTabPage();
                default:
                  return Container();
              }
            },
          );
        },
      ),
    );
  }
}