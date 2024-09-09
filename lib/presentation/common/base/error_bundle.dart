class ErrorBundle {
  final Exception exception;
  final String errorMessage;

  ErrorBundle(this.exception, this.errorMessage);

  String get message {
    return exception.toString();
  }
}
