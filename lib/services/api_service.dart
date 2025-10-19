import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hack2025_mobile_app/config/app_config.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = AppConfig.apiBaseUrl;

  static const _storage = FlutterSecureStorage();

  // Save user token
  static Future<void> saveToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }

  // Get saved token
  static Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  // Delete token (logout)
  static Future<void> deleteToken() async {
    await _storage.delete(key: 'auth_token');
  }

  // Save user info
  static Future<void> saveUserInfo(Map<String, dynamic> userInfo) async {
    await _storage.write(key: 'user_info', value: jsonEncode(userInfo));
  }

  // Get user info
  static Future<Map<String, dynamic>?> getUserInfo() async {
    final userInfoStr = await _storage.read(key: 'user_info');
    if (userInfoStr != null) {
      return jsonDecode(userInfoStr);
    }
    return null;
  }

  // Kakao Login API
  static Future<Map<String, dynamic>> kakaoLogin({
    required String accessToken,
    required String kakaoId,
    required String email,
    String? nickname,
    String? profileImage,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/kakao/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'access_token': accessToken,
          'kakao_id': kakaoId,
          'email': email,
          'nickname': nickname,
          'profile_image': profileImage,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        // Save token and user info
        if (data['access_token'] != null) {
          await saveToken(data['access_token']);
        }
        if (data['user'] != null) {
          await saveUserInfo(data['user']);
        }

        return {
          'success': true,
          'data': data,
        };
      } else {
        return {
          'success': false,
          'error': 'Login failed: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Network error: $e',
      };
    }
  }

  // Naver Login API
  static Future<Map<String, dynamic>> naverLogin({
    required String accessToken,
    required String naverId,
    required String email,
    String? nickname,
    String? profileImage,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/naver/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'access_token': accessToken,
          'naver_id': naverId,
          'email': email,
          'nickname': nickname,
          'profile_image': profileImage,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        // Save token and user info
        if (data['access_token'] != null) {
          await saveToken(data['access_token']);
        }
        if (data['user'] != null) {
          await saveUserInfo(data['user']);
        }

        return {
          'success': true,
          'data': data,
        };
      } else {
        return {
          'success': false,
          'error': 'Login failed: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Network error: $e',
      };
    }
  }

  // Update user profile
  static Future<Map<String, dynamic>> updateUserProfile({
    required Map<String, dynamic> userData,
  }) async {
    try {
      final token = await getToken();
      if (token == null) {
        return {
          'success': false,
          'error': 'No authentication token found',
        };
      }

      final response = await http.put(
        Uri.parse('$baseUrl/user/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Update stored user info
        if (data['user'] != null) {
          await saveUserInfo(data['user']);
        }

        return {
          'success': true,
          'data': data,
        };
      } else {
        return {
          'success': false,
          'error': 'Update failed: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Network error: $e',
      };
    }
  }

  // Email Login API
  static Future<Map<String, dynamic>> emailLogin({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Save token
        if (data['access_token'] != null) {
          await saveToken(data['access_token']);
        }

        // Save user info
        if (data['user'] != null) {
          await saveUserInfo(data['user']);
        }

        return {
          'success': true,
          'data': data,
        };
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'error': error['detail'] ?? 'Login failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Network error: $e',
      };
    }
  }

  // Email Signup API
  static Future<Map<String, dynamic>> emailSignup({
    required String name,
    required int age,
    required String gender,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'age': age,
          'gender': gender,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        // Save token if provided
        if (data['access_token'] != null) {
          await saveToken(data['access_token']);
        }

        // Save user info if provided
        if (data['user'] != null) {
          await saveUserInfo(data['user']);
        }

        return {
          'success': true,
          'data': data,
        };
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'error': error['detail'] ?? 'Signup failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Network error: $e',
      };
    }
  }

  // Logout
  static Future<void> logout() async {
    await deleteToken();
    await _storage.delete(key: 'user_info');
  }
}
