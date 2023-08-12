# Nexaflow SDK Flutter

A flutter package for connecting Flutter apps with [NexaFlow](https://nexaflow.xyz) platform.

## Features

- Custom Models for Website, Pages & Block Library
- Access Nexaflow api's directly

## Getting started

#### 1. Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  nexaflow_flutter_sdk: ^0.0.1
```

#### 2. Import `nexaflow_flutter_sdk`
```dart
import 'package:nexaflow_flutter_sdk/nexaflow_flutter_sdk.dart';
```

## Usage

Sample code demonstrating usage of the NexaFlow SDK for CMS (Content management system).

```dart
import 'package:nexaflow_flutter_sdk/nexaflow_flutter_sdk.dart';

void main() async {
  NexaflowSdk sdk = NexaflowSdk(apiKey: 'API_KEY');

  try {
    // Get List<Website> using the getAllWebsites()
    List<Website> websites = await sdk.getAllWebsites();
    print(websites.length);

    // Get Website using the getWebsiteById()
    Website website = await sdk.getWebsiteById(websiteId: websites.first.id);
    print(website.id);

    // Get Page using the getPageById()
    Page page = await sdk.getPageById(pageId: 'ID', websiteId: 'WEBSITE_ID');
    print(page.id);

    // Submit form using the submitForm()
    String form = await sdk.submitForm(formId: 'ID', formData: {'a': 'b'});
    print(form);

    // Submit CORS request using submitCorsRequest()
    final cors = await sdk.submitCorsRequest(id: 'CORS_ID');
    print(cors);

    // Verify Email using the verifyEmail()
    final verify = await sdk.verifyEmail(id: 'EMAIL_CORS_ID', email: 'EMAIL');
    print(verify);

    // Get data using the getDataFromGoogleSheet()
    final data = await sdk.getDataFromGoogleSheet(id: 'GOOGLE_SHEET_ID');
    print(data);

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
    print(result);
  } catch (e) {
    print(e);
  }
}
```