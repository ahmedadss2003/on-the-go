abstract class ApiException implements Exception {
  final String message;
  ApiException(this.message);
}

class NetworkException extends ApiException {
  NetworkException() : super('No internet connection');
}

class ServerException extends ApiException {
  ServerException(String message) : super(message);
}

class NotFoundException extends ApiException {
  NotFoundException() : super('Resource not found');
}

class UnauthorizedException extends ApiException {
  UnauthorizedException() : super('Unauthorized request');
}