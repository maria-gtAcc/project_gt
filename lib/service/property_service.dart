import 'package:project_gt/models/properties.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PropertyService {
  Future<List<PropertyInfo>> getAllAvailableProperties() async {
    try {
      var response = await http.get(Uri.parse(
          "http://192.168.88.10:31535/otonomus/inventory/api/v1/spaces/available_spaces"));
      var decodedResponse = jsonDecode(response.body);
      var result = decodedResponse["data"] as List;
      final finalResponse =
          result.map((map) => PropertyInfo.fromJson(map)).toList();
      return finalResponse;
    } catch (e) {
      print('Error getting properties: $e');
      return [];
    }
  }
}
