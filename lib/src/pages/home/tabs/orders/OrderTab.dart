import 'package:flutter/material.dart';
import './DialogCrearOrder.dart';

class OrderTab extends StatefulWidget {
  OrderTab({Key key}) : super(key: key);

  @override
  _OrderTabState createState() => new _OrderTabState();
}

class _OrderTabState extends State<OrderTab> {
  String _placa = 'ZZZ-666';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
itemCount: 5,
itemBuilder: (BuildContext context, int index) {
              return _buildItem(index);
            },
        ),
        floatingActionButton: FloatingActionButton(onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) {
                return DialogCrearOrder();
              },
              fullscreenDialog: true));
        },
        backgroundColor: Colors.purple,
        child: Icon(Icons.add),));
  }

  Widget _buildItem( int index) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Card(
        color: index==0?Colors.lightGreen:Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: EdgeInsets.all(7),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          semanticContainer: true,
          elevation: 6,
      child:  Padding(
        padding: EdgeInsets.all(8),
        child: new Row(children: <Widget>[
    new Padding(
      padding: EdgeInsets.all(8),
      child: Icon(
      Icons.directions_car,
      size: 56,
      color: Colors.purple,
    ),
    ),
    new Expanded(child: new Padding(padding: new EdgeInsets.only(left: 8.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text('Carro sin API', style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
          new Row(children: <Widget>[
            new Icon(Icons.star, color: Colors.purple,),
            new Icon(Icons.star, color: Colors.purple,),
            new Icon(Icons.star, color: Colors.purple,),
            new Icon(Icons.star_half, color: Colors.purple,),
            new Icon(Icons.star_border, color: Colors.purple,),
          ],),
          new Wrap(spacing: 6.0,children: <Widget>[
            new Chip(label: new Text('G95')),
            new Chip(label: new Text('Audi')),
          ],)
        ],),))
  ],),
      ),),
      
    );
  }


}