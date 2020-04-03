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
  final String subregion;

  const Nation(
      this.name,
      this.flag,
      this.nbPop,
      this.pop,
      this.language,
      this.currency,
      this.region,
      this.subregion
      );
  @override
  _NationState createState() => new _NationState();
}

class _NationState extends State<Nation> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 8.0),
        child: Card(
            child: Container(
                height: 120,
                margin: EdgeInsets.only(left: 10.0, right: 5.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: SvgPicture.network( widget.flag,height: 30, width: 30,) //"https://images-na.ssl-images-amazon.com/images/I/21I0GgEY57L._AC_SX425_.jpg", height: 50, width: 50,),
                      ),
                      Container(
                          constraints: BoxConstraints(maxWidth: 280),
                          margin: EdgeInsets.only(left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                  child: Text(widget.name, style: TextStyle(fontWeight:FontWeight.bold, fontSize: 18), maxLines: 2,)
                              ),
                              Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 100,
                                        child: Text(widget.currency, maxLines: 2,),
                                      ),
                                      Container(
                                        child: Text(widget.language),
                                      ),
                                      Container(
                                        child: Text(NumberFormat.compact().format(widget.nbPop)),
                                      )
                                    ],
                                  )
                              ),
                            ],
                          )
                      )
                    ]
                ))
        ));
  }
}