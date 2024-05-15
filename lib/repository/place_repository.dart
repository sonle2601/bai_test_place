import 'package:bai_test_map/models/place_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlaceRepository {
  final String apiKey = 'AJWGBzjk32iFuLo44W6sX54QxrFaXXtAKe42prLq8g8';

  Future<List<PlaceModel>> fetchSuggestions(String query) async {
    final url =
        'https://autosuggest.search.hereapi.com/v1/autosuggest?q=${Uri.encodeComponent(query)}&at=21.028511,105.804817&limit=10&apiKey=$apiKey';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final decodedResponse = utf8.decode(response.bodyBytes);
        final data = json.decode(decodedResponse);

        if (data is Map && data.containsKey('items')) {
          final List<dynamic> items = data['items'];
          final List<PlaceModel> suggestions =
          items.map((item) => PlaceModel.fromMap(item)).toList();
          return suggestions;
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
