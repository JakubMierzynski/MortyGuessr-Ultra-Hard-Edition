import 'package:http/http.dart' as http;

Future<bool> hasInternet() async {
  try {
    final response = await http.get(Uri.parse('https://clients3.google.com/generate_204'))
        .timeout(const Duration(seconds: 5));
    return response.statusCode == 204;
  } catch (_) {
    return false;
  }
}