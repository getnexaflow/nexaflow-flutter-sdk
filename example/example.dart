import 'package:nexaflow_flutter_sdk/nexaflow_flutter_sdk.dart';

void main() async {
  NexaflowSdk sdk = NexaflowSdk(apiKey: 'API_KEY');

  try {
    List<Website> websites = await sdk.getAllWebsites();
    Website website = await sdk.getWebsiteById(websiteId: websites.first.id);

    print(website.id);
    print(website.pages.length);
  } catch (e) {
    print(e);
  }
}
