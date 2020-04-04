import 'package:nationsApp/src/nation/NationWidget.dart';


// Nation Class declaration and implementation
class Nations {
  Map<String, int> _graphData = {};
  List<int>    _population = [];
  List<String> _countries = [];
  List<Nation> _nation = [];
  List<Nation> _searchedNation = [];

  // Nations main constructor with the API request
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

  // Method to copy an instance of Nations to an other
  Nations.fromNations(Nations main) {
    _graphData = main._graphData;
    _population = main._population;
    _countries = main._countries;
    _nation = main._nation;
  }

  void setNation(List<Nation> nationList) {
    this._nation = nationList;
  }

  // Method that will return all Nation object that contain the search string in there name
  List<Nation> getSearchingField(String search) {
    int i = 0;
    String nationName;
    _searchedNation = [];
    while (i < _nation.length) {
      nationName = _nation[i].name.toLowerCase();
      if (nationName.contains(search.toLowerCase())) {
        _searchedNation.add(_nation[i]);
      }
      i++;
    }
    return _searchedNation;
  }

  // Method that add a new Nation object to the List _nations
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