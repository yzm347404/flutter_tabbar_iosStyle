import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class MultiNetworkAssetLoader extends AssetLoader {
  final String baseUrl; // 聚合接口地址

  MultiNetworkAssetLoader({required this.baseUrl});

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    final langCode = locale.languageCode;
    final cacheKey = 'translations_all'; // 所有语言共用一个缓存键

    // 1. 尝试从缓存加载
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(cacheKey);

    Map<String, dynamic> allTranslations = {};

    if (cachedData != null) {
      allTranslations = json.decode(cachedData);
      // 如果当前语言在缓存中存在，直接返回
      if (allTranslations.containsKey(langCode)) {
        debugPrint('从缓存加载 [$langCode] 成功');
        return allTranslations[langCode];
      }
    }

    // 2. 从网络加载所有语言
    try {
      final url = Uri.parse(baseUrl);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        allTranslations = json.decode(response.body);

        // 3. 保存到缓存
        await prefs.setString(cacheKey, json.encode(allTranslations));
        debugPrint('从网络加载所有语言成功，已缓存');

        // 返回当前语言的翻译
        if (allTranslations.containsKey(langCode)) {
          return allTranslations[langCode];
        }
      }
    } catch (e) {
      debugPrint('网络加载失败: $e');
    }

    // 4. 降级处理：尝试从本地 asset 加载
    try {
      final localData = await rootBundle.loadString(
        'assets/translations/allTranslations.json',
      );
      final localTranslations = json.decode(localData);
      if (localTranslations.containsKey(langCode)) {
        return localTranslations[langCode];
      }
      return {}; // 返回空 Map
    } catch (e) {
      return {}; // 返回空 Map
    }
  }
}
