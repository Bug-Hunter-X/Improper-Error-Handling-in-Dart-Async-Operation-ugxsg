```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> fetchData() async {
  try {
    final response = await http.get(Uri.parse('https://api.example.com/data'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData['data'];
    } else {
      throw HttpException('HTTP request failed with status: ${response.statusCode}', response.statusCode);
    }
  } on FormatException catch (e) {
    throw Exception('Invalid JSON format: $e');
  } on SocketException catch (e) {
    throw Exception('Network error: $e');
  } on HttpException catch (e) {
    throw Exception('HTTP error: ${e.message} (Status code: ${e.statusCode})');
  } catch (e) {
    throw Exception('An unexpected error occurred: $e');
  }
}

class HttpException implements Exception {
  final String message;
  final int statusCode;

  HttpException(this.message, this.statusCode);
}
```