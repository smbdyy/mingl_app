class ApiException implements Exception {
  final int statusCode;
  final String? message;

  ApiException(this.statusCode, [this.message]);

  @override
  String toString() => 'ApiException($statusCode): $message';
}

class UnauthorizedException extends ApiException {
  UnauthorizedException([String? message]) : super(401, message);
}