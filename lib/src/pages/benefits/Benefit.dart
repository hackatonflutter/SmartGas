import 'package:flutter/material.dart';

void main() => runApp(Benefits());

class Benefits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Benefits',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new BenefitPage(title: 'Benefits'));
  }
}

class BenefitPage extends StatefulWidget {
  BenefitPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _BenefitPageState createState() => _BenefitPageState();
}

class _BenefitPageState extends State<BenefitPage> {
  List _selectedBenefits = List();

  Map<String, dynamic> _benefits = {
    "responseCode": "1",
    "responseText": "Elija su beneficio",
    "responseBody": [
      {"benefit_id": "1", "benefit_name": "Lavado de auto"},
      {"benefit_id": "2", "benefit_name": "Carga de bateria"},
      {"benefit_id": "3", "benefit_name": "Pintado de auto"}
    ],
    "responseTotalResult":
        3 // Total result is 3 here becasue we have 3 categories in responseBody.
  };

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

    final Size screenSize = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: new Text('Benefits'),
      ),
      body: new Builder(
        builder: (BuildContext context) {
          return new Container(
            child: new ListView(
              children: <Widget>[
                new Container(
                    padding: new EdgeInsets.all(20.0),
                    width: screenSize.width,
                    child: new Text('Tu porcentaje de consumo:')),
                new Container(
                    padding: new EdgeInsets.all(20.0),
                    width: screenSize.width,
                    child: new Text('.....................................')),
                // Container(
                //   height: 50,
                //   child: new ListView.builder(
                //       itemCount: _benefits['responseTotalResult'],
                //       itemBuilder: (BuildContext context, int index) {
                //         new CheckboxListTile(
                //             value: _selectedBenefits.contains(
                //                 _benefits['responseBody'][index]['benefit_id']),
                //             onChanged: (bool selected) {
                //               _onBenefitSelected(
                //                   selected,
                //                   _benefits['responseBody'][index]
                //                       ['benefit_id']);
                //             },
                //             title: Text(_benefits['responseBody'][index]
                //                 ['benefit_id']));
                //       }),
                // ),
                new Container(
                  child: new RaisedButton(
                    shape: StadiumBorder(),
                    child: new Text(
                      'Aceptar',
                      style: new TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      //_submit(context);
                    },
                    color: Colors.purple,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _onBenefitSelected(bool selected, benefit_id) {
    if (selected == true) {
      setState(() {
        _selectedBenefits.add(benefit_id);
      });
    } else {
      setState(() {
        _selectedBenefits.remove(benefit_id);
      });
    }
  }
}
