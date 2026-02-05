import 'package:second_chat_bot/core/services/api/end_points.dart';

class ErrorModel {
  final int? stutsCode;
  final String? message;

  ErrorModel({required this.stutsCode, required this.message});

  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    return ErrorModel(
      stutsCode: jsonData[Apikeys.stauscode],
      message: jsonData[Apikeys.message],
    );
  }
}
