class ResponseModel {
  final bool success;
  final String message;
  final dynamic body;

  ResponseModel({
    required this.success,
    required this.message,
    this.body,
  });
}
