import 'package:nexaflow_flutter_sdk/nexaflow_flutter_sdk.dart';

void main() async {
  // Create an instance of Nexaflow SDK
  NexaflowSdk sdk = NexaflowSdk(apiKey: 'API_KEY');

  try {
    // Get data using the getDataFromGoogleSheet()
    List<List<String>> data =
        await sdk.getDataFromGoogleSheet(id: 'GOOGLE_SHEET_ID');

    // Print the result
    print(data);
  } catch (e) {
    print(e);
  }
}
