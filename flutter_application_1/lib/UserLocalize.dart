import 'package:shared_preferences/shared_preferences.dart';

class UserLocalize {
  static Future<void> saveUserSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', '张三');
    await prefs.setInt('age', 25);
    await prefs.setBool('isLogin', true);
    await prefs.setStringList('tags', ['vip', 'premium']);
  }

  // 读取数据
  static Future<void> loadUserSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username') ?? '默认用户';
    final age = prefs.getInt('age') ?? 0;
    final isLogin = prefs.getBool('isLogin') ?? false;
    final tags = prefs.getStringList('tags') ?? [];
  }
}
