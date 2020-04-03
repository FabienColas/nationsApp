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
  Nations _nations;
  GlobalKey<RefreshIndicatorState> _refreshey;
  int _selectedIndex = 0;

  @override
  void initState() {
    _allNations = fetchNations();
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
                )
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
  
  Widget buildHomePage(Nations _nationsData) {
    _nations = _nationsData;
    return Scaffold(
      body: SafeArea(
        //Set to true to avoid rendering issues with different devices
        bottom: true,
        top: true,
        child: RefreshIndicator(
          key: _refreshey,
          onRefresh: () {
            setState(() {

            });
            return _allNations = fetchNations();
        },
        child: Column(
          children: <Widget>[
            Expanded(
                child: Container(
                    margin: EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
                    child: ListView.builder(
                      itemCount: _nations.getNationsNumber(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext ctxt, int index) {
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
              return buildHomePage(snapshot.data);
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
              MaterialPageRoute(builder: (context) => GraphPage(nations: this._nations)),
            );
          },
    )
    );
  }
}