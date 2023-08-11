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

```dart
NexaflowSdk sdk = NexaflowSdk(apiKey: 'API_KEY');

try {
  List<Website> websites = await sdk.getAllWebsites();
  Website website = await sdk.getWebsiteById(websiteId: websites.first.id);
  print(website.id);
  print(website.pages.length);
} catch (e) {
  print(e);
}
```