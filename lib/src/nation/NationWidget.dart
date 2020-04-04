import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class Nation extends StatefulWidget {
  final String name;
  final String flag;
  final int nbPop;
  final String pop;
  final String language;
  final String currency;
  final String region;
  final String subRegion;

  const Nation(
      this.name,
      this.flag,
      this.nbPop,
      this.pop,
      this.language,
      this.currency,
      this.region,
      this.subRegion
      );
  @override
  _NationState createState() => new _NationState();
}

class _NationState extends State<Nation> {
  @override
  Widget build(BuildContext context) {
    return (Card(
            child: Container(
                margin: EdgeInsets.only(left: 10, right: 5, bottom: 8),
                child: Wrap(
                    children: <Widget>[
                      //Draw Flag with Nation's name
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget> [
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: SvgPicture.network(widget.flag,height: 50, width: 50)
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(top: 10, bottom: 10, left: 15),
                              child: Text(widget.name, style: TextStyle(fontWeight:FontWeight.bold, fontSize: 18), maxLines: 2,)
                            )
                          ),
                        ]
                      ),
                      //Draw the Card content with Nation's data
                      Container(
                          constraints: BoxConstraints(maxWidth: 280),
                          margin: EdgeInsets.only(left: 20, top: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                               Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 70,
                                        child: Text(widget.currency, maxLines: 2,),
                                      ),
                                      Container(
                                        child: Text(widget.language),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10.0),
                                        child: Text(NumberFormat.compact().format(widget.nbPop)),
                                      )
                                    ],
                                  )
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 20, top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(widget.pop, overflow: TextOverflow.fade,),
                                      ),
                                    ],
                                  )
                              ),
                            ],
                          )
                      )
                    ]
                )
            )
        )
    );
  }
}