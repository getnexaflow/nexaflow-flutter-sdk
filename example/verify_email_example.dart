import 'package:nexaflow_flutter_sdk/nexaflow_flutter_sdk.dart';

void main() async {
  // Create an instance of Nexaflow SDK
  NexaflowSdk sdk = NexaflowSdk(apiKey: 'API_KEY');

  try {
    // Verify Email using the verifyEmail()
    Map<String, dynamic> result = await sdk.verifyEmail(
      id: 'EMAIL_CORS_ID',
      email: 'EMAIL',
    );

    // Print the result
    print(result);
  } catch (e) {
    print(e);
  }
}
