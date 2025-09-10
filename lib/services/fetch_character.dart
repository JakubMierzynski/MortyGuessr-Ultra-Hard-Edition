import 'dart:convert';
import 'dart:math';
import 'package:morty_guessr/constants/base_url.dart';
import 'package:morty_guessr/models/character.dart';
import 'package:http/http.dart' as http;

class FetchCharacterService {
  Future<Character> getRandomCharacter() async {
    int randomId = Random().nextInt(826) + 1;
    final response = await http.get(Uri.parse('$baseUrl$randomId'));

    if (response.statusCode == 200) {
      return Character.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Nie udało się pobrać bohatera");
    }
  }

  Future<List<String>> getAllCharacters(input) async {
    final response = await http.get(Uri.parse('$characterNameUrl$input'));

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final List results = await decoded["results"];

      return results.map((e) => e["name"].toString()).toSet().toList();
    } else if (response.statusCode == 404) {
      // zwróci no items found!
      return <String>[];
    } else {
      throw Exception("Error while fetching");
    }
  }
}
