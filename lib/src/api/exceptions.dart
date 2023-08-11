import 'package:nexaflow_flutter_sdk/nexaflow_flutter_sdk.dart';

/// Exception thrown when an API call in [NexaflowSdk] fails.
///
/// This exception provides information about the error that occurred
/// during communication with the Nexaflow backend.
class NexaflowException implements Exception {
  /// Creates a [NexaflowException] with the given status code and error message.
  NexaflowException(this.statusCode, this.error);

  /// The HTTP status code returned by the API indicating the failure.
  final int statusCode;

  /// The error message received from the Nexaflow backend.
  final String? error;

  @override
  String toString() {
    return 'NexaflowException\nStatus Code: $statusCode\nError: $error';
  }
}
