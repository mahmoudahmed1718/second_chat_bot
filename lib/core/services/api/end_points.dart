abstract class EndPoint {
  static const String baseUrl = 'https://generativelanguage.googleapis.com/';

  static const String generateContent =
      'v1beta/models/gemini-3-flash-preview:generateContent';
  // static const String login = '/auth/login';
  // static const String register = '/auth/register';
  // static const String logout = '/auth/logout';
}

abstract class Apikeys {
  static const String apikey = 'AIzaSyBNN8e5XPI-VzFz9OwtNvEJSxlK_u7479c';
  static const String stauscode = "statusCode";
  static const String message = "message";
  static const String data = "error";
  static const String accessToken = "access_token";
  static const String refeshToken = "refresh_token";
  static const String id = "_id";
  static const String phone = "phone";
  static const String password = "password";
  static const String name = "displayName";
  static const String address = "address";
  static const String experience = "experienceYears";
  static const String level = "level";
}
