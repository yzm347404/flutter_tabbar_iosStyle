
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

final String baseUrl = 'api.example.com';

class ApiService {
  /// GET 请求
  static Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? params,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = Uri.https(baseUrl, endpoint, params);
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        debugPrint('HTTP错误: ${response.statusCode}, body: ${response.body}');
        return {
          'error': true,
          'statusCode': response.statusCode,
          'message': response.body,
        };
      }
    } catch (e) {
      debugPrint('请求异常: $e');
      return {
        'error': true,
        'message': e.toString(),
      };
    }
  }

  /// POST 请求
  static Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> data, {
    Map<String, String>? headers,
  }) async {
    try {
      final uri = Uri.https(baseUrl, endpoint);
      final mergedHeaders = {
        'Content-Type': 'application/json',
        if (headers != null) ...headers,
      };
      final response = await http.post(
        uri,
        headers: mergedHeaders,
        body: json.encode(data),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        debugPrint('HTTP错误: ${response.statusCode}, body: ${response.body}');
        return {
          'error': true,
          'statusCode': response.statusCode,
          'message': response.body,
        };
      }
    } catch (e) {
      debugPrint('网络错误: $e');
      return {
        'error': true,
        'message': e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> put(
    String endpoint,
    Map<String, dynamic> data, {
    Map<String, String>? headers,
  }) async {
    try {
      final uri = Uri.https(baseUrl, endpoint);
      final mergedHeaders = {
        'Content-Type': 'application/json',
        if (headers != null) ...headers,
      };
      final response = await http.put(
        uri,
        headers: mergedHeaders,
        body: json.encode(data),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        debugPrint('HTTP错误: ${response.statusCode}, body: ${response.body}');
        return {
          'error': true,
          'statusCode': response.statusCode,
          'message': response.body,
        };
      }
    } catch (e) {
      debugPrint('网络错误: $e');
      return {
        'error': true,
        'message': e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> delete(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    try {
      final uri = Uri.https(baseUrl, endpoint);
      final response = await http.delete(uri, headers: headers);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        debugPrint('HTTP错误: ${response.statusCode}, body: ${response.body}');
        return {
          'error': true,
          'statusCode': response.statusCode,
          'message': response.body,
        };
      }
    } catch (e) {
      debugPrint('网络错误: $e');
      return {
        'error': true,
        'message': e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> patch(
    String endpoint,
    Map<String, dynamic> data, {
    Map<String, String>? headers,
  }) async {
    try {
      final uri = Uri.https(baseUrl, endpoint);
      final mergedHeaders = {
        'Content-Type': 'application/json',
        if (headers != null) ...headers,
      };
      final response = await http.patch(
        uri,
        headers: mergedHeaders,
        body: json.encode(data),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        debugPrint('HTTP错误: ${response.statusCode}, body: ${response.body}');
        return {
          'error': true,
          'statusCode': response.statusCode,
          'message': response.body,
        };
      }
    } catch (e) {
      debugPrint('网络错误: $e');
      return {
        'error': true,
        'message': e.toString(),
      };
    }
  }
}
