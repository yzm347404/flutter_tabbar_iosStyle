import 'package:flutter/material.dart';

/*
1. 核心原理：Stack 的宽高如何决定？

Flutter 中，一个组件的尺寸通常由 约束（Constraints） 决定。Stack 的尺寸遵循以下逻辑：

情况 A：当 Stack 有父组件且父组件有约束时

如果父组件（例如一个 SizedBox 或 Container）强制 Stack 必须是一个固定大小（例如宽 200，高 200），那么 Stack 就会是 200x200。
如果父组件（例如 Scaffold 的 body）允许 Stack 自由选择大小，那么 Stack 会尝试扩张到能包裹住所有未被定位（non-positioned）的子组件。
情况 B：根据子组件决定大小（最常见）

Stack 的大小计算规则依赖于它的两个属性：fit 和 clipBehavior，以及子组件的类型。

非定位子组件（没有用 Positioned 包裹的）： 这些组件会影响 Stack 自身的大小。Stack 会试图变得足够大，以容纳所有非定位子组件。
定位子组件（用 Positioned 包裹的）： 这些组件不影响 Stack 的自身大小。 如果所有子组件都是 Positioned（即没有非定位组件），
那么 Stack 会试图变得尽可能小，除非父组件强制它变大。
 */

class UIPage extends StatefulWidget {
  @override
  _UIPageState createState() => _UIPageState();
}

class _UIPageState extends State<UIPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('UI Page')),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Container(
              width: 100,
              height: 100,
              color: Colors.blue,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Container(width: 50, height: 50, color: Colors.red),
                  ),
                  Positioned(
                    bottom: -20,
                    right: -20,
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 100,
              height: 100,
              color: Colors.orange,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.red,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.yellow,
                      child: Container(
                        width: 50,
                        height: 50,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
