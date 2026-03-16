import 'package:flutter/material.dart';

/*
使用provider来跨组件通信，使得组件可以直接使用StatelessWidget而不是StatefulWidget从而更加简化代码。
因为使用Eventbus + setState(首先带来的问题就是不能局部刷新)， 
而Eventbus + VilueNotifer 可以局部刷新，但是需要声明为StatefulWidget，因为需要dispose里面去相应dispose 
*/

/*
Provider.of<NewsItemModel>(context, listen: false) listen这个参数是控制是否监听数据变化，默认是true，
如果是false就不会监听数据变化，也就不会自动更新UI了，这个时候就相当于直接获取数据了，不会自动更新UI了。

展示数据用 true（界面要更新）
触发事件用 false（按钮不需要重建）
initState 必 false（还没构建完）
*/

/*
监听provier更新ui的三种方式

Provider.of、Selector、Consumer 的关系
// 方式一：Provider.of - 直接在 build 方法中获取模型数据，监听数据变化，自动更新 UI
Text(
  Provider.of<NewsItemModel>(context, listen: true).title
)

// 方式二：Consumer - 监听整个 Model，当 Model 中**任何**数据变化时，这里都会重建
Consumer<NewsItemModel>(
  builder: (context, newsModel, child) => Text(newsModel.title),
)

// 方式三：Selector - 只监听特定字段（性能最优），主要用于复杂页面，需要性能优化，只有 title 变化时才重建
Selector<NewsItemModel, String>(
  selector: (context, newsModel) => newsModel.title,
  builder: (context, title, child) => Text(title),
)
 */
class NewsItemModel extends ChangeNotifier {
  String? title = "";
  String? description = "";
  String? imageUrl = "";

  NewsItemModel({
     this.title,
     this.description,
     this.imageUrl,
  });

  void updateNews({String? newTitle , String? newDescription, String? newImageUrl}) {
    if (newTitle !=null) {
      title = newTitle;
    }
    if (newDescription != null) {
      description = newDescription;
    }
    if (newImageUrl!=null) {
      imageUrl = newImageUrl;
    }
    notifyListeners(); // 通知监听器更新 UI
  }
}