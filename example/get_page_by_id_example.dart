import 'package:nexaflow_flutter_sdk/nexaflow_flutter_sdk.dart';

void main() async {
  // Create an instance of Nexaflow SDK
  NexaflowSdk sdk = NexaflowSdk(apiKey: 'API_KEY');

  try {
    // Get Page using the getPageById()
    Page page =
        await sdk.getPageById(pageId: 'PAGE_ID', websiteId: 'WEBSITE_ID');

    // Print the result
    print(page.id);
  } catch (e) {
    print(e);
  }
}
