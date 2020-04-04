import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nationsApp/src/nation/NationWidget.dart';
import 'package:nationsApp/src/nation/NationsClass.dart';
import 'package:nationsApp/src/network/fetchData.dart';
import 'package:nationsApp/src/ui/GraphPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Nations> _allNations;

  Nations _mainNations;
  Nations _nations;
  Nations _searchNations;

  List<Nation> _searchNationList;

  GlobalKey<RefreshIndicatorState> _refreshKey;

  bool isInit = false;

  TextEditingController _searchString = TextEditingController();

  @override
  void initState() {
    // Send request to the API and build our Main Object
    _allNations = fetchNations();
    super.initState();
  }

  // function that will find countries that contains the searchable String
  void _searchInNations() {
    if (_searchString.text == "") {
      _nations = Nations.fromNations(_mainNations);
      setState(() {});
      return;
    }
    _searchNationList = _mainNations.getSearchingField(_searchString.text);
    _nations.setNation(_searchNationList);
    _searchNations = Nations.fromNations(_nations);
    setState(() {});
  }

  // function that will pick the right Nations, depending if we are searching or not
  void _pickRightList() {
    String searchString = _searchString.text;

    if (searchString == "") {
      _nations = Nations.fromNations(_mainNations);
    } else {
      _nations = Nations.fromNations(_searchNations);
    }
  }

  //Dialog that pops up on listview item click to print additional content about a specific country
  Future<void> _nationDialog(BuildContext context, Nation nation) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(nation.name),
          content: Container(
            height: 100,
            child:Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: SvgPicture.network(nation.flag, height: 50, width: 50,)
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 10),
                        child: Text("Region:", style: TextStyle(fontWeight: FontWeight.bold),)
                    ),
                    Container(
                      child: Text(nation.region),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Text("Subregion:", style: TextStyle(fontWeight: FontWeight.bold))
                    ),
                    Container(
                        child: Text(nation.subregion),
                    )
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  
  Widget buildHomePage() {

    _pickRightList();

    return Scaffold(
      body: SafeArea(
        //Set to true to avoid rendering issues with different devices
        bottom: true,
        top: true,
        child: RefreshIndicator(
          key: _refreshKey,
          onRefresh: () {
            setState(() {});
            return _allNations = fetchNations();
        },
        child: Column(
          children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                          child :TextField(
                            controller: _searchString,
                            decoration: InputDecoration(
                                labelText: "Any particular Country ?",
                                prefixIcon: Icon(Icons.textsms),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                          )
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: FloatingActionButton(
                        heroTag: "search",
                        onPressed: () {
                          _searchInNations();
                        },
                        child: Icon(Icons.search,),
                        backgroundColor: Colors.blue,
                      ),
                    )
              ]
            ),
            Expanded(
                child: Container(
                    margin: EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
                    child: ListView.builder(
                      itemCount: _nations.getNationsNumber(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {
                              _nationDialog(context, _nations.getNation(index));
                            },
                            child: _nations.getNation(index)
                        );
                      },
                    )
                  )
              )
            ],
          ),
       )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: _allNations,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (!isInit) {
                _mainNations = Nations.fromNations(snapshot.data);
                isInit = false;
              }
              return buildHomePage();
            } else {
              return Center(
                  child: CircularProgressIndicator()
              );
          }
        },
      ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.trending_down),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GraphPage(nations: this._mainNations)),
            );
          },
    )
    );
  }
}