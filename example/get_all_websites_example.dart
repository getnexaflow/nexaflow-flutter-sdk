import 'package:nexaflow_flutter_sdk/nexaflow_flutter_sdk.dart';

void main() async {
  // Create an instance of Nexaflow SDK
  NexaflowSdk sdk = NexaflowSdk(apiKey: 'API_KEY');

  try {
    // Get List<Website> using the getAllWebsites()
    List<Website> websites = await sdk.getAllWebsites();

    // Print the result
    print(websites.length);
  } catch (e) {
    print(e);
  }
}
