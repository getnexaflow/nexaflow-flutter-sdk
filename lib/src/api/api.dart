import 'dart:convert';
import 'dart:developer' as developer;

import 'package:http/http.dart' as http;

import '../models/page.dart';
import '../models/website.dart';
import 'exceptions.dart';

/// Enum for different methods for CORS Request
enum Method { get, post, put, delete }

class NexaflowSdk {
  NexaflowSdk({
    required this.apiKey,
    http.Client? client,
  }) : _client = client ?? http.Client();

  final String apiKey;
  final http.Client _client;

  final String baseUrl = 'https://api.nexaflow.xyz/api';

  Future<List<Website>> getAllWebsites() async {
    try {
      http.Response response = await _client.get(
        Uri.parse('$baseUrl/websites'),
        headers: {'accept': 'application/json', 'x-api-key': apiKey},
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return (body as List).map((e) => Website.fromJson(e)).toList();
      } else {
        throw NexaflowException(response.statusCode, body['message']);
      }
    } on Exception catch (e) {
      developer.log(e.toString());
      rethrow;
    }
  }

  Future<Website> getWebsiteById({required String websiteId}) async {
    try {
      http.Response response = await _client.get(
        Uri.parse('$baseUrl/website/$websiteId'),
        headers: {'accept': 'application/json', 'x-api-key': apiKey},
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return Website.fromJson(body);
      } else {
        throw NexaflowException(response.statusCode, body['message']);
      }
    } on Exception catch (e) {
      developer.log(e.toString());
      rethrow;
    }
  }

  Future<Page> getPageById({
    required String websiteId,
    required String pageId,
  }) async {
    try {
      http.Response response = await _client.get(
        Uri.parse('$baseUrl/page/$pageId?websiteId=$websiteId'),
        headers: {'accept': 'application/json', 'x-api-key': apiKey},
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return Page.fromJson(jsonDecode(response.body));
      } else {
        throw NexaflowException(response.statusCode, body['message']);
      }
    } on Exception catch (e) {
      developer.log(e.toString());
      rethrow;
    }
  }

  Future<String> submitForm({
    required String formId,
    required Map<String, String> formData,
  }) async {
    try {
      http.Response response = await _client.post(
        Uri.parse('$baseUrl/form/$formId'),
        headers: {
          'accept': 'application/json',
          'content-type': 'application/json',
          'x-api-key': apiKey
        },
        body: jsonEncode(formData),
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return body['message'];
      } else {
        throw NexaflowException(response.statusCode, body['message']);
      }
    } on Exception catch (e) {
      developer.log(e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>> submitCorsRequest({
    required String id,
    Method method = Method.get,
    required Map<String, String> data,
  }) async {
    try {
      http.Response response = await _client.post(
        Uri.parse('$baseUrl/cors/$id'),
        headers: {'content-type': 'application/json', 'x-api-key': apiKey},
        body: jsonEncode({'method': method.name, 'data': data}),
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return body;
      } else {
        throw NexaflowException(response.statusCode, body['message']);
      }
    } on Exception catch (e) {
      developer.log(e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>> verifyEmail({
    required String id,
    required String email,
  }) async {
    try {
      return await submitCorsRequest(
        id: id,
        method: Method.post,
        data: {'email': email},
      );
    } on Exception catch (e) {
      developer.log(e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>> verifyEmailWeb({
    required String id,
    required String email,
  }) async {
    try {
      http.Response response = await _client.post(
        Uri.parse('$baseUrl/email-verify/$id'),
        headers: {
          'accept': 'application/json',
          'content-type': 'application/json',
          'x-api-key': apiKey
        },
        body: jsonEncode({'email': email}),
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return body;
      } else {
        throw NexaflowException(response.statusCode, body['message']);
      }
    } on Exception catch (e) {
      developer.log(e.toString());
      rethrow;
    }
  }

  Future<List<List<String>>> getDataFromGoogleSheet({
    required String id,
  }) async {
    try {
      http.Response response = await _client.get(
        Uri.parse('$baseUrl/googleSheets/$id'),
        headers: {'accept': 'application/json', 'x-api-key': apiKey},
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return body;
      } else {
        throw NexaflowException(response.statusCode, body['message']);
      }
    } on Exception catch (e) {
      developer.log(e.toString());
      rethrow;
    }
  }

  Future<String> postDataToGoogleSheet({
    required String id,
    required List<List<String>> data,
  }) async {
    try {
      http.Response response = await _client.post(
        Uri.parse('$baseUrl/googleSheets/$id'),
        headers: {
          'accept': 'application/json',
          'content-type': 'application/json',
          'x-api-key': apiKey
        },
        body: jsonEncode({'data': data}),
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return body['message'];
      } else {
        throw NexaflowException(response.statusCode, body['message']);
      }
    } on Exception catch (e) {
      developer.log(e.toString());
      rethrow;
    }
  }
}
