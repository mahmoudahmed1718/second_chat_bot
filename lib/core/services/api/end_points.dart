abstract class EndPoint {
  static const String baseUrl = 'https://generativelanguage.googleapis.com/';

  static const String generateContent =
      'v1beta/models/gemini-3-flash-preview:generateContent';
}

abstract class Apikeys {
  static const String apikey = 'AIzaSyDCijtFbRF2CwmNpctVHookd0YrEflYN78';
  static const String stauscode = "statusCode";
  static const String message = "message";
  static const String data = "error";
}
