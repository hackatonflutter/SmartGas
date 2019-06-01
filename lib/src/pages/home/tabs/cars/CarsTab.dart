import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CrearCarro.dart';

class CarsTab extends StatefulWidget {
  _CarsTabState createState() => _CarsTabState();
}

class _CarsTabState extends State<CarsTab> {
  String _placa = 'ZZZ-666';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            ClipPath(
              clipper: ArcClipper(10.0),
              child: Container(
                color: Colors.purple,
                height: 200.0,
                padding: EdgeInsets.only(bottom: 40),
                child: Center(
                  child: Text(
                    'Mis automóviles',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: "Roboto"),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 120),
              child: GridView.builder(
                padding: EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 8.0,
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0),
                itemCount: 2,
                itemBuilder: _buildItem,
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) {
                return DialogCrearCarro();
              },
              fullscreenDialog: true));
        },
        backgroundColor: Colors.purple,
        child: Icon(Icons.add),));
  }

  Widget _buildItem(BuildContext context, int index) {
    return Card(
      elevation: 5.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(Icons.directions_car, size: 62.0, color: Colors.purple),
          Text('Prueba - G95',
              style: TextStyle(
                  color: Colors.black, fontSize: 20, fontFamily: "Roboto")),
          Text('$_placa ',
              style: TextStyle(color: Colors.grey, fontFamily: "Roboto"))
        ],
      ),
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  ArcClipper(this.height);

  ///The height of the arc
  final double height;

  @override
  Path getClip(Size size) => _getBottomPath(size);

  Path _getBottomPath(Size size) {
    return Path()
      ..lineTo(0.0, size.height - height)
      //Adds a quadratic bezier segment that curves from the current point
      //to the given point (x2,y2), using the control point (x1,y1).
      ..quadraticBezierTo(
          size.width / 4, size.height, size.width / 2, size.height)
      ..quadraticBezierTo(
          size.width * 3 / 4, size.height, size.width, size.height - height)
      ..lineTo(size.width, 0.0)
      ..close();
  }

  @override
  bool shouldReclip(ArcClipper oldClipper) => height != oldClipper.height;
}
