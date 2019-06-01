import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogCrearCarro extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _DialogCrearCarroPageState();
}

class _DialogCrearCarroPageState extends State<DialogCrearCarro> {
  DateTime selectedDate = DateTime.now();
  String _marca = '';
  bool _checkCombustible = true;
  int _radioCombustible = 0;
  String _result = '';
  @override
  Widget build(BuildContext mainContext) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Crear automóvil'),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          children: <Widget>[
            _crearMarca(),
            Divider(),
            _crearModelo(),
            Divider(),
            _crearPlaca(),
            Divider(),
            Divider(),
            _crearTipoCombustible(),
     
            _crearBoton()
          ],
        ),
      ),
    );
  }

  Widget _crearMarca() {
    return TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.sentences,

      decoration: InputDecoration(
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
        labelStyle: TextStyle(color: Colors.purple),
        border: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.purple, style: BorderStyle.solid)),
        hintText: 'Marca del auto',
        labelText: 'Marca',
        helperText: 'Ingrese la marca del auto',
        fillColor: Colors.purple,
      ),
      onChanged: (valor) {
        setState(() {
          _marca = valor;
        });
      },
    );
  }

  Widget _crearModelo() {
    return TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.sentences,

      decoration: InputDecoration(
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
        labelStyle: TextStyle(color: Colors.purple),
        border: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.purple, style: BorderStyle.solid)),
        hintText: 'Modelo del auto',
        labelText: 'Modelo',
        helperText: 'Ingrese el modelo del auto',
        fillColor: Colors.purple,
      ),
      onChanged: (valor) {
        setState(() {
          _marca = valor;
        });
      },
    );
  }

  Widget _crearPlaca() {
    return TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.sentences,

      decoration: InputDecoration(
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
        labelStyle: TextStyle(color: Colors.purple),
        border: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.purple, style: BorderStyle.solid)),
        hintText: 'Placa del auto',
        labelText: 'Placa',
        helperText: 'Ingrese la placa del auto',
        fillColor: Colors.purple,
      ),
      onChanged: (valor) {
        setState(() {
          _marca = valor;
        });
      },
    );
  }

  Widget _crearTipoCombustible() {
    return Column(
      children: <Widget>[
        Container(
            child: Text(
          'Elija el combustible de su vehículo',
          style: TextStyle(fontSize: 18),
        )),
        Divider(),
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Radio(
              value: 1,
              groupValue: _radioCombustible,
              onChanged: _handleRadioValueChange,
            ),
            new Text(
              'G95',
              style: new TextStyle(fontSize: 16.0),
            ),
            new Radio(
              value: 2,
              groupValue: _radioCombustible,
              onChanged: _handleRadioValueChange,
            ),
            new Text(
              'G90',
              style: new TextStyle(
                fontSize: 16.0,
              ),
            ),
            new Radio(
              value: 3,
              groupValue: _radioCombustible,
              onChanged: _handleRadioValueChange,
            ),
            new Text(
              'G84',
              style: new TextStyle(fontSize: 16.0),
            ),
            new Radio(
              value: 4,
              groupValue: _radioCombustible,
              onChanged: _handleRadioValueChange,
            ),
            new Text(
              'Diesel',
              style: new TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ],
    );
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioCombustible = value;

      switch (_radioCombustible) {
        case 1:
          _result = 'G95';
          break;
        case 2:
          _result = 'G90';
          break;
        case 3:
          _result = 'G84';
          break;
        case 4:
          _result = 'Diesel';
          break;
      }
    });
  }

  Widget _crearBoton() {
    return Container(
      padding:EdgeInsets.all(50.0),
      child: FlatButton(
        
        shape: StadiumBorder(side: BorderSide()),
        color: Colors.purple,
        
        textColor: Colors.white,
        child: Text('Guardar Cambios'),
        onPressed: () {
          
        },
      ),
    );
  }
}
