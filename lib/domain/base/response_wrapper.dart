class ResponseWrapper<T> {
  late final ResponseStatus status;
  final T? data;
  final String? message;
  final int? statusCode;

  ResponseWrapper({
    required this.status,
    this.data,
    this.message,
    this.statusCode,
  });

  factory ResponseWrapper.success({
    required T data,
    String? message,
  }) =>
      ResponseWrapper(
        status: ResponseStatus.success,
        data: data,
        message: message,
      );

  factory ResponseWrapper.error({
    String? message,
    int? statusCode,
    T? data,
  }) =>
      ResponseWrapper(
        status: ResponseStatus.error,
        data: data,
        message: message,
        statusCode: statusCode,
      );
}

enum ResponseStatus {
  success,
  error,
  loading,
}
