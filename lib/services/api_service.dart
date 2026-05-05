import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/data.dart';

class ApiService {
  ApiService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;
  static const Duration _requestTimeout = Duration(seconds: 5);
  static const Duration _aiRequestTimeout = Duration(seconds: 30);
  static const String _nvidiaApiUrl =
      'https://integrate.api.nvidia.com/v1/chat/completions';
  static const String _nvidiaModel = 'google/gemma-4-31b-it';
  static const String _nvidiaApiKey = String.fromEnvironment(
    'NVIDIA_API_KEY',
    defaultValue:
        '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',
  );

  static String get baseUrl {
    const configuredUrl = String.fromEnvironment('API_BASE_URL');
    if (configuredUrl.isNotEmpty) {
      return configuredUrl;
    }

    if (kIsWeb) {
      return 'http://127.0.0.1:8000/api';
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:8000/api';
    }

    return 'http://127.0.0.1:8000/api';
  }

  Future<FactStoreData> fetchInitialData() async {
    final categoriesJson = await _getJson('/categories');
    final factsJson = await _getJson('/facts');

    final facts = (factsJson['data'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .map(FactItem.fromJson)
        .toList();

    final factStore = groupFactsByCategory(facts);

    final categories = (categoriesJson['data'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .map(
          (category) => buildCategory(
            (category['id'] ?? '').toString(),
            name: (category['name'] ?? '').toString(),
          ),
        )
        .where((category) => category.id.isNotEmpty)
        .toList();

    return FactStoreData(
      categories: categories
          .where((category) => factStore.containsKey(category.id))
          .toList(),
      factDataStore: factStore,
    );
  }

  Future<Map<String, dynamic>> _getJson(String path) async {
    final response = await _client
        .get(Uri.parse('$baseUrl$path'))
        .timeout(_requestTimeout);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        'Request failed with status ${response.statusCode} for $path',
      );
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Unexpected API response format.');
    }

    return decoded;
  }

  Future<String> streamAiResponse({
    required String prompt,
    required void Function(String content) onDelta,
  }) async {
    final request = http.Request('POST', Uri.parse(_nvidiaApiUrl));
    request.headers.addAll({
      'Authorization': 'Bearer $_nvidiaApiKey',
      'Content-Type': 'application/json',
      'Accept': 'text/event-stream',
    });
    request.body = jsonEncode({
      'model': _nvidiaModel,
      'messages': [
        {'role': 'user', 'content': prompt},
      ],
      'max_tokens': 16384,
      'temperature': 1.0,
      'top_p': 0.95,
      'stream': true,
      'chat_template_kwargs': {'enable_thinking': true},
    });

    final response = await _client.send(request).timeout(_aiRequestTimeout);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      final errorBody = await response.stream.bytesToString();
      throw Exception(
        'AI request failed with status ${response.statusCode}: $errorBody',
      );
    }

    final content = StringBuffer();
    final contentType = response.headers['content-type'] ?? '';

    if (!contentType.contains('text/event-stream')) {
      final body = await response.stream.bytesToString();
      final decoded = jsonDecode(body);
      if (decoded is! Map<String, dynamic>) {
        throw const FormatException('Unexpected AI response format.');
      }

      final choices = decoded['choices'];
      if (choices is! List || choices.isEmpty || choices.first is! Map<String, dynamic>) {
        throw const FormatException('AI response did not include any choices.');
      }

      final firstChoice = choices.first as Map<String, dynamic>;
      final message = firstChoice['message'];
      final fullContent = message is Map<String, dynamic>
          ? (message['content'] ?? '').toString().trim()
          : '';

      if (fullContent.isEmpty) {
        throw const FormatException('AI response was empty.');
      }

      onDelta(fullContent);
      return fullContent;
    }

    await for (final line
        in response.stream.transform(utf8.decoder).transform(const LineSplitter())) {
      final trimmed = line.trim();
      if (!trimmed.startsWith('data:')) {
        continue;
      }

      final payload = trimmed.substring(5).trim();
      if (payload.isEmpty || payload == '[DONE]') {
        continue;
      }

      final decoded = jsonDecode(payload);
      if (decoded is! Map<String, dynamic>) {
        continue;
      }

      final choices = decoded['choices'];
      if (choices is! List || choices.isEmpty) {
        continue;
      }

      if (choices.first is! Map<String, dynamic>) {
        continue;
      }

      final choice = choices.first as Map<String, dynamic>;
      final delta = choice['delta'];
      final message = choice['message'];
      final nextToken = delta is Map<String, dynamic>
          ? (delta['content'] ?? '').toString()
          : message is Map<String, dynamic>
              ? (message['content'] ?? '').toString()
              : '';
      if (nextToken.isEmpty) {
        continue;
      }

      content.write(nextToken);
      onDelta(content.toString());
    }

    if (content.isEmpty) {
      throw const FormatException('AI response finished without any text.');
    }

    return content.toString();
  }
}
