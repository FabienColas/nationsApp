import 'package:flutter/material.dart';
import 'package:nationsApp/src/nation/NationsClass.dart';


class GraphPage extends StatelessWidget {

  Nations nations;

  GraphPage({this.nations});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Nations Graph')),
        body: Container(
          child: Center(
            child: Text("GRAPH PAGE")
          ),
        )
      );
  }

}