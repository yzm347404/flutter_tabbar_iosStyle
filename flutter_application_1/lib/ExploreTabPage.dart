import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/EventBusService.dart';
/*
setState vs ValueNotifier + ValueListenableBuilder 详细对比

特性	       setState	                                      ValueNotifier + ValueListenableBuilder
Widget      类型	必须使用 StatefulWidget	                     可以使用 StatelessWidget
重建范围	    整个 build 方法都会重建	                           只重建被 ValueListenableBuilder 包裹的部分
多个变量处理	任何一个变量变化，整个组件全部重建	                 每个变量独立监听，只有变化的变量对应的 UI 重建
代码复杂度	  简单直观，学习成本低	                              稍复杂但更灵活，需要理解响应式编程概念
性能表现	    可能过度重建，造成不必要的性能开销	                    精确重建，性能更优，特别适合复杂 UI
状态位置	    状态必须定义在 State 类中	                          状态可以在任何地方（外部、静态、传入等）
生命周期管理	由 Flutter 框架自动管理	                         需要手动调用 dispose() 释放资源
调试难度	   简单，但难以定位不必要的重建	                         较复杂，但可以精确追踪每个变量的变化
状态共享	   难以跨组件共享	                                    易于跨组件共享状态
适用场景	   简单、局部的UI状态	                                 复杂状态、需要精确控制重建的场景
 */


// 发现 Tab
class ExploreTabPage extends StatefulWidget {
  const ExploreTabPage({super.key});
  
  @override
  _ExploreTabPageState createState() => _ExploreTabPageState();
}

class _ExploreTabPageState extends State<ExploreTabPage> {
  static final _titleNotifier = ValueNotifier<String>('发现');

  @override
  void dispose() {
    _titleNotifier.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder(valueListenable: _titleNotifier, builder: (context, title, child) {
          return Text(title);
        }),
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
              _titleNotifier.value = '发现 $index';
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
  
  const ExploreDetailPage({super.key, required this.index});

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