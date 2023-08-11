import 'dart:convert';
import 'dart:developer' as developer;

import 'package:http/http.dart' as http;

import '../models/page.dart';
import '../models/website.dart';
import 'exceptions.dart';

/// Enum for different HTTP methods for CORS Request
enum Method {
  get,
  post,
  put,
  delete,
}

/// SDK for interacting with the [Nexaflow API's](https://nexaflow.gitbook.io/nexaflow/developer-apis).
class NexaflowSdk {
  /// Creates an instance of [NexaflowSdk].
  ///
  /// Requires an [apiKey] to interact with api's
  NexaflowSdk({
    required this.apiKey,
    http.Client? client,
  }) : _client = client ?? http.Client();

  final String apiKey;
  final http.Client _client;

  final String baseUrl = 'https://api.nexaflow.xyz/api';

  /// Fetches a list of all websites available in the Nexaflow Panel.
  ///
  /// Returns a list of [Website] objects representing the fetched websites.
  ///
  /// Throws a [NexaflowException] if there's an error during the API call.
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

  /// Fetches a website by its [websiteId].
  ///
  /// Returns a [Website] object containing the retrieved website's data.
  ///
  /// Throws a [NexaflowException] if there's an error during the API call.
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

  /// Fetches the page with the specified [pageId] belonging to the website
  /// identified by [websiteId].
  ///
  /// Returns a [Page] object containing the retrieved page's data.
  ///
  /// Throws a [NexaflowException] if there's an error during the API call.
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

  /// Submits a form using its [formId].
  ///
  /// This method sends a POST request to submit a form with the provided [formId]
  /// to the Nexaflow Panel. The [formData] parameter contains the data to be submitted
  /// as a map of key-value pairs.
  ///
  /// Returns a message indicating the result of the form submission.
  ///
  /// Throws a [NexaflowException] if there's an error during the API call.
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

  ///  Sends a Cross-Origin Resource Sharing (CORS) request to the Nexaflow Panel.
  ///
  /// This method sends a POST request with the provided [data] to the Nexaflow Panel,
  /// using the specified [id] as the CORS id. The [method] parameter defines the HTTP method
  /// to be used in the request (default is [Method.get]). The [data] parameter contains
  /// the payload to be sent with the request.
  ///
  /// Returns a map containing the response data from the CORS request.
  ///
  /// Throws a [NexaflowException] if there's an error during the API call.
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

  /// Sends a Cross-Origin Resource Sharing (CORS) request to verify an email address.
  ///
  /// This method is used to send an email verification request to the Nexaflow Panel.
  ///
  /// To initiate email verification, a CORS request with the specified [id] should be added,
  /// and the [id] corresponds to the CORS id of the request for email verification.
  /// The [email] parameter is the email address that needs to be verified.
  ///
  /// Returns a map containing the response data from the verification request.
  ///
  /// Throws a [NexaflowException] if there's an error during the verification process.
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

  /// Sends an email verification request for the Web platform.
  ///
  /// This method sends an email verification request to the Nexaflow Panel
  /// for the Web platform. The [id] parameter corresponds to the id from the email verification.
  /// The [email] parameter is the email address that needs to be verified.
  ///
  /// Returns a map containing the response data from the verification request.
  ///
  /// Throws a [NexaflowException] if there's an error during the verification process.
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

  /// Fetches data from a Google Sheet identified by [id].
  ///
  /// This method retrieves the data from the Google Sheet specified by its unique [id].
  /// The returned data is a list of rows, where each row is represented as a list of strings.
  ///
  /// Throws a [NexaflowException] if there's an error during the API call.
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

  /// Posts data to a Google Sheet identified by [id].
  ///
  /// This method sends the provided [data] to the Google Sheet specified by its unique [id].
  /// The [data] should be a list of rows, where each row is represented as a list of strings.
  ///
  /// Returns a message indicating the success of the operation.
  ///
  /// Throws a [NexaflowException] if there's an error during the API call.
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
