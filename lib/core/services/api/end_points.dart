abstract class EndPoint {
  static const String baseUrl = 'https://generativelanguage.googleapis.com/';

  static const String generateContent =
      'v1beta/models/gemini-3-flash-preview:generateContent';
}

abstract class Apikeys {
  static const String apikey = 'AIzaSyD4_zlg4Slflu1pkfErQqjcLU0Nbf57IPU';
  static const String stauscode = "statusCode";
  static const String message = "message";
  static const String data = "error";
}
