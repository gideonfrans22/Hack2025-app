/// Application configuration
///
/// Store your API keys and configuration here.
/// IMPORTANT: Never commit this file with real API keys to version control!
/// Add this file to .gitignore in production.
class AppConfig {
  // Backend API configuration
  static const String apiBaseUrl = 'http://localhost:8000/api';

  // Kakao OAuth configuration
  // Get your Kakao app keys from https://developers.kakao.com/
  static const String kakaoNativeAppKey = 'YOUR_KAKAO_NATIVE_APP_KEY';
  static const String kakaoJavascriptKey = 'YOUR_KAKAO_JAVASCRIPT_KEY';

  // Naver OAuth configuration
  // Get your Naver app credentials from https://developers.naver.com/
  static const String naverClientId = 'YOUR_NAVER_CLIENT_ID';
  static const String naverClientSecret = 'YOUR_NAVER_CLIENT_SECRET';
  static const String naverClientName = 'YOUR_APP_NAME';

  // App configuration
  static const String appName = 'Readable';
  static const String appVersion = '1.0.0';
}
