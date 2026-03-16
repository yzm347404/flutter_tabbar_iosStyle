import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/EventBusService.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/provider/NewsItemModel.dart';
import 'package:provider/provider.dart';

// 首页 Tab
class HomeTabPage extends StatelessWidget {
  const HomeTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    //使用最简单获取模型数据，监听数据变化，自动更新UI
    final title = Provider.of<NewsItemModel>(context).title;
    return Scaffold(
      appBar: AppBar(
        title: Text(title != null ? '点击了 $title' : '首页'),
        leading: IconButton(
          onPressed: () => {
            // 自定义返回逻辑
            // 发送登出事件，触发登录页面
            EventBusService.instance.fire(LogoutEvent("123", 'John')),
          },
          icon: Icon(Icons.login),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () {
              // 切换
              if (context.locale == Locale('zh')) {
                context.setLocale(Locale('en'));
              } else {
                context.setLocale(Locale('zh'));
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
                backgroundColor:
                    Colors.primaries[index % Colors.primaries.length],
              ),
              title: Text('新闻标题 $index'),
              subtitle: Text('这是第 $index 项的详情-provider'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Provider.of<NewsItemModel>(context, listen: false).updateNews(
                  newTitle: '新闻标题 $index',
                  newDescription: '这是第 $index 项的详情-provider',
                );
                // 在当前 Tab 的导航栈中推入新页面
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    settings: RouteSettings(name: 'HomeDetailPage'),
                    builder: (context) => HomeDetailPage(itemId: index),
                    //全屏对话框样式（iOS 从底部弹出） 相当于present, 默认返回按钮是关闭图标，一般返回按钮是箭头图标
                    fullscreenDialog: true,
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
        //使用 Selector 监听模型数据特定属性变化，自动更新标题，局部更新
        title: Selector<NewsItemModel, String>(
          builder: (context, title, child) => Text(title),
          selector: (context, model) => model.title ?? '',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 使用 Consumer 监听模型数据变化，自动更新描述，局部更新
            Consumer<NewsItemModel>(
              builder: (context, model, child) =>
                  Text(model.description ?? '', style: TextStyle(fontSize: 20)),
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
            // 返回上一层
            // Navigator.pop(context);
            // 回根page
            // Navigator.popUntil(context, (route) => route.isFirst);
            // 回到特定page, 需要在push时设置RouteSettings(name: 'HomeDetailPage')
            Navigator.popUntil(
              context,
              (route) => route.settings.name == 'HomeDetailPage',
            );
          },
        ),
      ),
      body: Center(child: Text('这是更深一层的详情页')),
    );
  }
}
