import 'package:nexaflow_flutter_sdk/nexaflow_flutter_sdk.dart';

void main() async {
  // Create an instance of Nexaflow SDK
  NexaflowSdk sdk = NexaflowSdk(apiKey: 'API_KEY');

  try {
    // Post data using the postDataToGoogleSheet()
    String result = await sdk.postDataToGoogleSheet(
      id: 'GOOGLE_SHEET_ID',
      data: [
        ['Serial No.', 'Value'],
        ['1', 'one'],
        ['2', 'two'],
        ['3', 'three'],
        ['4', 'four'],
      ],
    );

    // Print the result
    print(result);
  } catch (e) {
    print(e);
  }
}
