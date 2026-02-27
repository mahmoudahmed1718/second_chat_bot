class ErrorModel {
  final int? statusCode;
  final String? message;
  final String? status;

  ErrorModel({this.statusCode, this.message, this.status});

  /// Safe factory: handles null or invalid JSON
  factory ErrorModel.fromJson(Map<String, dynamic>? jsonData) {
    if (jsonData == null) {
      // Response is completely null
      return ErrorModel(
        statusCode: null,
        message: "No response from server",
        status: "NULL_RESPONSE",
      );
    }

    // Check if there is an 'error' object
    final error = jsonData['error'];
    if (error is Map<String, dynamic>) {
      return ErrorModel(
        statusCode: error['code'] as int?,
        message: error['message'] as String?,
        status: error['status'] as String?,
      );
    } else {
      // Response exists but no 'error' field; store raw JSON as message
      return ErrorModel(
        statusCode: null,
        message: jsonData.toString(),
        status: "INVALID_ERROR_FORMAT",
      );
    }
  }
}
