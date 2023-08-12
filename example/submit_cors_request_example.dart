import 'package:nexaflow_flutter_sdk/nexaflow_flutter_sdk.dart';

void main() async {
  // Create an instance of Nexaflow SDK
  NexaflowSdk sdk = NexaflowSdk(apiKey: 'API_KEY');

  try {
    // Submit CORS request using submitCorsRequest()
    Map<String, dynamic> result = await sdk.submitCorsRequest(
      id: 'CORS_ID',
      method: Method.post,
      data: {'key': 'value'},
    );

    // Print the result
    print(result);
  } catch (e) {
    print(e);
  }
}
