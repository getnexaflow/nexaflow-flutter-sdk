import 'package:nexaflow_flutter_sdk/nexaflow_flutter_sdk.dart';

void main() async {
  // Create an instance of Nexaflow SDK
  NexaflowSdk sdk = NexaflowSdk(apiKey: 'API_KEY');

  try {
    // Submit form using the submitForm()
    String result = await sdk.submitForm(
      formId: 'FORM_ID',
      formData: {
        'name': 'name',
        'email': 'email',
      },
    );

    // Print the result
    print(result);
  } catch (e) {
    print(e);
  }
}
