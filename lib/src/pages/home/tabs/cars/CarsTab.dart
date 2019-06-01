import 'package:flutter/material.dart';

class CarsTab extends StatefulWidget {
  CarsTab({Key key}) : super(key: key);

  @override
  _CarsTabState createState() => new _CarsTabState();
}

class _CarsTabState extends State<CarsTab> {
  @override
  Widget build(BuildContext context) {
    return Builder(
          builder: (context) => new Column(
            children: <Widget>[
Text("Cars")
            ],
             
          )
      );
  }

}