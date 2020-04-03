
import 'dart:convert';
import 'package:nationsApp/src/nation/NationsClass.dart';
import 'package:http/http.dart' as http;

Future<Nations> fetchNations() async {
  final response = await http.get('https://restcountries.eu/rest/v2/all');

  // If the server did return a 200 OK response,
  if (response.statusCode == 200) {
    print("OK");
    // send it to Nation Class to parse the JSON.
    return Nations(json.decode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}