import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

final String baseUrl = 'https://api.example.com';

class ApiServiceDio {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  // 统一拦截器配置，需在启动时手动调用一次
  static void init() {
    _dio.interceptors.clear();
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        debugPrint('请求: \\${options.method} \\${options.uri}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        debugPrint('响应: \\${response.statusCode} \\${response.data}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        debugPrint('Dio错误: \\${e.message}');
        return handler.next(e);
      },
    ));
  }

  /// GET 请求
  static Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: params,
        options: Options(headers: headers),
      );
      return response.data is Map<String, dynamic>
          ? response.data
          : {'data': response.data};
    } catch (e) {
      debugPrint('Dio GET 错误: $e');
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
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );
      return response.data is Map<String, dynamic>
          ? response.data
          : {'data': response.data};
    } catch (e) {
      debugPrint('Dio POST 错误: $e');
      return {
        'error': true,
        'message': e.toString(),
      };
    }
  }

  /// PUT 请求
  static Future<Map<String, dynamic>> put(
    String endpoint,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );
      return response.data is Map<String, dynamic>
          ? response.data
          : {'data': response.data};
    } catch (e) {
      debugPrint('Dio PUT 错误: $e');
      return {
        'error': true,
        'message': e.toString(),
      };
    }
  }

  /// DELETE 请求
  static Future<Map<String, dynamic>> delete(
    String endpoint, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        queryParameters: params,
        options: Options(headers: headers),
      );
      return response.data is Map<String, dynamic>
          ? response.data
          : {'data': response.data};
    } catch (e) {
      debugPrint('Dio DELETE 错误: $e');
      return {
        'error': true,
        'message': e.toString(),
      };
    }
  }

  /// PATCH 请求
  static Future<Map<String, dynamic>> patch(
    String endpoint,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.patch(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );
      return response.data is Map<String, dynamic>
          ? response.data
          : {'data': response.data};
    } catch (e) {
      debugPrint('Dio PATCH 错误: $e');
      return {
        'error': true,
        'message': e.toString(),
      };
    }
  }
}
