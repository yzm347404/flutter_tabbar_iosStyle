import 'package:flutter/material.dart';
import 'package:flutter_application_1/EventBusService.dart';
import 'package:flutter/services.dart';

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
                    settings: RouteSettings(name: 'HomeDetailPage'),
                    builder: (context) => HomeDetailPage(itemId: index),
                    //全屏对话框样式（iOS 从底部弹出） 相当于present, 默认返回按钮是关闭图标，一般返回按钮是箭头图标
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

class HomeSubDetailPage extends StatefulWidget {
  final int itemId;
  
  HomeSubDetailPage({required this.itemId});

  @override
  _HomeSubDetailPageState createState() => _HomeSubDetailPageState();
}

class _HomeSubDetailPageState extends State<HomeSubDetailPage> {

  @override
  void initState() {
    super.initState();
    // 2. 进入页面时，强制开启横屏（允许左右横屏）
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // 3. 退出页面时，恢复为竖屏
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('子详情页'),
        //重写了返回按钮，默认是箭头图标，重写后变成了返回图标，需要自己实现返回逻辑
        leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          // 自定义返回逻辑
          // 发送登出事件，触发登录页面
          EventBusService.instance.fire(LogoutEvent("123",'John')); 

          // 返回上一层
          // Navigator.pop(context);
          // 回根page
          // Navigator.popUntil(context, (route) => route.isFirst); 
          // 回到特定page, 需要在push时设置RouteSettings(name: 'HomeDetailPage')
          Navigator.popUntil(context, (route) => route.settings.name == 'HomeDetailPage'); 
        },
      ),
      ),
      body: Center(
        child: Text('这是更深一层的详情页'),
      ),
    );
  }
}