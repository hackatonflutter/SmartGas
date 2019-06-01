import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_gas/src/models/Car.dart';
import 'package:smart_gas/src/provider/CarService.dart';

import 'CrearCarro.dart';

class CarsTab extends StatefulWidget {
  _CarsTabState createState() => _CarsTabState();
}

class _CarsTabState extends State<CarsTab> {
  String _placa = 'ZZZ-666';
  List<Car> listaCars = [];
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCards();
  }

  @override
  Widget build(BuildContext context) {
    if (!loading) {
      return Center(child: CircularProgressIndicator());
    } else {
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
                  itemCount: this.listaCars.length,
                  itemBuilder: _buildItem,
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return DialogCrearCarro();
                  },
                  fullscreenDialog: true)).then((response){
                    if(response == true){
                      setState(() {
                       getCards(); 
                       loading=false;
                      });
                    }
                  });
            },
            backgroundColor: Colors.purple,
            child: Icon(Icons.add),
          ));
    }
  }

  Widget _buildItem(BuildContext context, int index) {
    return Card(
      elevation: 5.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(Icons.directions_car, size: 62.0, color: Colors.purple),
          Text('${listaCars[index].marca} - ${listaCars[index].modelo}',
              style: TextStyle(
                  color: Colors.black, fontSize: 20, fontFamily: "Roboto")),
          Text('${listaCars[index].placa} ',
              style: TextStyle(color: Colors.grey, fontFamily: "Roboto")),
          Text('Combustible: ${listaCars[index].combustible} ',
              style: TextStyle(color: Colors.grey, fontFamily: "Roboto"))
        ],
      ),
    );
  }

  Future getCards() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.get('email');
    CarService carservice = new CarService();
    await carservice.getCars(email).then((data) {
      setState(() {
        this.listaCars = data;
        print(this.listaCars);
        loading = true;
      });
    });
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
