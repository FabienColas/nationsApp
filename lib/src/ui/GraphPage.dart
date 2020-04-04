import 'package:flutter/material.dart';
import 'package:nationsApp/src/nation/NationsClass.dart';
import 'package:sortedmap/sortedmap.dart';
import 'package:charts_flutter/flutter.dart' as charts;

// Class that will contains information about one Country in order to print it
class PopulationData {
  final String nation;
  final int population;
  charts.Color barColor = charts.ColorUtil.fromDartColor(Colors.blue);

  PopulationData(this.nation, this.population);

  getName() {
    return nation;
  }

  getPopulation() {
    return population;
  }

  getColor() {
    return barColor;
  }
}

class GraphPage extends StatelessWidget {

  Nations nations;
  List<String> _nationsName = [];
  List<int>    _nationsPop = [];
  Map<String, int> _graphDataTmp = {};
  Map<String, int> _graphData = {};
  List<PopulationData> _popList = [];

  // Graph constructor
  GraphPage(Nations other) {
    this.nations = Nations.fromNations(other);
    _graphDataTmp = this.nations.getGraphData();
    _graphData = SortedMap(Ordering.byValue());
    _graphData.addAll(_graphDataTmp);
  }

  // Fill lists with data by spliting the Nations's Map and sort them
  _initGraphData() {
    int i = 0;
    _graphData.forEach((k, v) {
      _nationsName.add(k);
      _nationsPop.add(v);
    });

    i =_nationsPop.length - 1;
    while (i > 0) {
      _popList.add(new PopulationData(_nationsName[i], _nationsPop[i]));
      i--;
    }
  }

  @override
  Widget build(BuildContext context) {

    _initGraphData();

    List<charts.Series<PopulationData, String>> graphData = [
      charts.Series(
        id: "Population Desc",
        data: _popList,
        domainFn: (PopulationData popData, _) => popData.getName(),
        measureFn: (PopulationData popData, _) => popData.getPopulation(),
        colorFn: (PopulationData popData, _) => popData.getColor(),
      )
    ];
    if (_popList.length > 0) {
      return
        Scaffold(
            appBar: AppBar(
              title: Text("Population Graph"),
            ),
            body: SafeArea(
                top: true,
                bottom: true,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height,
                        width: 30000,
                        child: charts.BarChart(
                          graphData,
                          animate: true,
                        )
                    )
                )
            )
        );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Population Graph"),
        ),
        body: Center(
          child: Text("Something went wrong: no data")
        )
      );
    }
  }
}