class ErrorModel {
  final int? statusCode;
  final String? message;
  final String? status;

  ErrorModel({this.statusCode, this.message, this.status});

  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    final error = jsonData['error'] ?? {};
    return ErrorModel(
      statusCode: error['code'],
      message: error['message'],
      status: error['status'],
    );
  }
}
