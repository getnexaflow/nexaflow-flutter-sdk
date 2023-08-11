class NexaflowException implements Exception {
  NexaflowException(this.statusCode, this.error);

  final int statusCode;
  final String? error;

  @override
  String toString() {
    return 'Exception\nStatus Code: $statusCode\nError: $error';
  }
}
