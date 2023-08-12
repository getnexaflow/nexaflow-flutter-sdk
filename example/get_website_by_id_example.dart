import 'package:nexaflow_flutter_sdk/nexaflow_flutter_sdk.dart';

void main() async {
  // Create an instance of Nexaflow SDK
  NexaflowSdk sdk = NexaflowSdk(apiKey: 'API_KEY');

  try {
    // Get Website using the getWebsiteById()
    Website website = await sdk.getWebsiteById(websiteId: 'WEBSITE_ID');

    // Print the result
    print(website.id);
  } catch (e) {
    print(e);
  }
}
