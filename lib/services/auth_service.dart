import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'api_service.dart';

class AuthService {
  // Kakao Login
  static Future<Map<String, dynamic>> loginWithKakao() async {
    try {
      // Check if Kakao Talk is available
      bool kakaoTalkAvailable = await isKakaoTalkInstalled();

      OAuthToken token;
      if (kakaoTalkAvailable) {
        // Login with Kakao Talk
        token = await UserApi.instance.loginWithKakaoTalk();
      } else {
        // Login with Kakao Account (web)
        token = await UserApi.instance.loginWithKakaoAccount();
      }

      // Get user information
      User user = await UserApi.instance.me();

      // Send to backend
      final result = await ApiService.kakaoLogin(
        accessToken: token.accessToken,
        kakaoId: user.id.toString(),
        email: user.kakaoAccount?.email ?? '',
        nickname: user.kakaoAccount?.profile?.nickname,
        profileImage: user.kakaoAccount?.profile?.profileImageUrl,
      );

      return result;
    } catch (e) {
      debugPrint('Kakao login error: $e');
      return {
        'success': false,
        'error': 'Kakao login failed: $e',
      };
    }
  }

  // Kakao Logout
  static Future<void> logoutKakao() async {
    try {
      await UserApi.instance.logout();
      await ApiService.logout();
    } catch (e) {
      debugPrint('Kakao logout error: $e');
    }
  }

  // Naver Login
  static Future<Map<String, dynamic>> loginWithNaver() async {
    try {
      final NaverLoginResult result = await FlutterNaverLogin.logIn();

      if (result.status == NaverLoginStatus.loggedIn) {
        final NaverAccountResult account =
            await FlutterNaverLogin.currentAccount();

        // Send to backend
        final apiResult = await ApiService.naverLogin(
          accessToken: result.accessToken.accessToken,
          naverId: account.id,
          email: account.email,
          nickname: account.nickname,
          profileImage: account.profileImage,
        );

        return apiResult;
      } else {
        return {
          'success': false,
          'error': 'Naver login cancelled or failed',
        };
      }
    } catch (e) {
      debugPrint('Naver login error: $e');
      return {
        'success': false,
        'error': 'Naver login failed: $e',
      };
    }
  }

  // Naver Logout
  static Future<void> logoutNaver() async {
    try {
      await FlutterNaverLogin.logOut();
      await ApiService.logout();
    } catch (e) {
      debugPrint('Naver logout error: $e');
    }
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final token = await ApiService.getToken();
    return token != null;
  }

  // Get current user info
  static Future<Map<String, dynamic>?> getCurrentUser() async {
    return await ApiService.getUserInfo();
  }
}
