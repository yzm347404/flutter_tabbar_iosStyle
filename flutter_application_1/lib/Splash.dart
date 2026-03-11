import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  final VoidCallback onPressed;
  const SplashPage({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blue, // 可以自定义背景颜色
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '欢迎使用',
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: onPressed,
              /*
              Image.asset('assets/images/icon.png') 这样的代码时，
              Flutter 会默认 icon.png 是1倍图（主资源）。然后它会根据设备的像素比，
              自动在同级目录下的 2.0x/、3.0x/ 等文件夹中寻找对应的高清图。
              如果在 pubspec.yaml 中采用目录声明的方式（如 - assets/images/），
              Flutter 会先去 assets/images/ 目录下查找名为 icon.png 的文件。
              如果找不到这个1倍图文件，它不会继续去子目录里找，加载就会失败。

              如果你的项目里确实只有2倍图，而想省去1倍图，
              解决方法是：在 pubspec.yaml 中精确声明这些图片的路径，而不是声明整个目录
              assets/images/
              ├── 2.0x/
              │   └── my_icon.png    (72x72px，适用于2倍屏)
              └── 3.0x/
                  └── my_icon.png    (108x108px，适用于3倍屏)
              那么，你的 pubspec.yaml 应该写成这样：
              flutter:
                assets:
                  # 精确声明图片路径，而不是只声明目录
                  - assets/images/2.0x/my_icon.png
                  - assets/images/3.0x/my_icon.png   
              在代码中，你需要直接引用高清图所在的路径，而不是使用不带倍率后缀的路径： 
              / 这样是错误的，Flutter 找不到 assets/images/my_icon.png
              // Image.asset('assets/images/my_icon.png')

              // 正确做法：直接引用 2.0x 下的图片
              Image.asset('assets/images/2.0x/my_icon.png'）   
              ⚠️ 重要提醒：直接使用 Image.asset('assets/images/2.0x/my_icon.png') 
              这种方式后，Flutter 会把这个2倍图当成一个普通图片来处理，
              不再具备自动适配不同分辨率设备的能力。这意味着它在2倍屏的设备上看起来是正常的，
              但在3倍屏的设备上显示时，图片可能会被放大而导致模糊；在1倍屏设备上则可能显示得过大
              为了避免维护多套图片的麻烦，同时也想获得最好的显示效果，可以考虑以下方案：
              
              💡 更好的替代方案
              保留最小图片集：保留1倍图和2倍图。根据实际测试，同时包含1x和2x资源，
              Flutter在3x设备上会选择2x资源并进行缩放，效果比仅用1x资源好很多。
              使用矢量图（推荐）：这是最一劳永逸的方案。
              矢量图（如SVG格式）可以无限缩放而不会失真。配合 flutter_svg 库，
              你可以只维护一套图片资源，完美适配所有分辨率的设备。
              Flutter这套资源匹配机制确实有点绕，主要就是围绕着“1倍图作为查找入口”这个核心逻辑
              */
              child: Image.asset(
                'assets/images/icons/general_btn_previous_nor.png',   
                width: 180,
                height: 50,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
