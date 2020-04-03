/*
 * Nation Class declaration and implementation
 *
 */
import 'package:nationsApp/src/nation/NationWidget.dart';

class Nations {
  Map<String, int> _graphData = {};
  List<int>    _population = [];
  List<String> _countries = [];
  List<Nation> _nation = [];
  String name;
  Nations(List<dynamic> json) {
    int i = 0;
    while (json.length > i) {
      if (json[i]["name"] != "") {
        _graphData[json[i]["name"]] = json[i]["population"];
        _countries.add(json[i]["name"]);
        _population.add(json[i]["population"]);
        addNation(json, i);
      }
      i++;
    }
  }

  void addNation(List<dynamic> json, index) {
    this._nation.add(Nation(
        json[index]["name"] as String,
        json[index]["flag"] as String,
        json[index]["population"] as int,
        json[index]["demonym"] as String,
        json[index]["languages"][0]["name"] as String,
        json[index]["currencies"][0]["name"] as String,
        json[index]["region"] as String,
        json[index]["subregion"] as String));
  }

  Nation getNation(int index) {
    return _nation[index];
  }

  int getNationsNumber() {
    return _nation.length;
  }

  Map<String, int> getGraphData() {
    return _graphData;
  }
}