import 'package:flutter/material.dart';
import '../../models/User.dart';
import '../../utils/Constants.dart';
import '../../provider/UserService.dart';
import './ConfirmnationScreen.dart';

import 'package:amazon_cognito_identity_dart/cognito.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => new _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  User _user = new User();
  final userService = new UserService(Constants.userPool);

  void submit(BuildContext context) async {
    _formKey.currentState.save();

    String message;
    bool signUpSuccess = false;
    try {
      await userService.sendUserToApi(_user);
      _user = await userService.signUp(_user.email, _user.password, _user.name);
      signUpSuccess = true;
      message = 'Cuenta creada con exito!';

    } on CognitoClientException catch (e) {
      if (e.code == 'UsernameExistsException' ||
          e.code == 'InvalidParameterException' ||
          e.code == 'ResourceNotFoundException') {
        message = e.message;
      } else {
        message = 'Unknown client error occurred';
      }
    } catch (e) {
      message = 'Unknown error occurred';
    }

    final snackBar = new SnackBar(
      content: new Text(message),
      action: new SnackBarAction(
        label: 'OK',
        onPressed: () {
          if (signUpSuccess) {
            Navigator.pop(context);
            if (!_user.confirmed) {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                        new ConfirmationScreen(email: _user.email)),
              );
            }
          }
        },
      ),
      duration: new Duration(seconds: 30),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Sign Up'),
      ),
      body: new Builder(
        builder: (BuildContext context) {
          return new Container(
            child: new Form(
              key: _formKey,
              child: new ListView(
                children: <Widget>[
                  new ListTile(
                    leading: const Icon(Icons.email),
                    title: new TextFormField(
                      decoration: new InputDecoration(
                          hintText: 'example@inspire.my', labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (String email) {
                        _user.email = email;
                      },
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.lock),
                    title: new TextFormField(
                      decoration: new InputDecoration(
                        hintText: 'Password!',
                      ),
                      obscureText: true,
                      onSaved: (String password) {
                        _user.password = password;
                      },
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.phone),
                    title: new TextFormField(
                      keyboardType:   TextInputType.number,
                      decoration: new InputDecoration(
                        hintText: 'Telefono!',
                      ),
                      onSaved: (String telefono) {
                        _user.phoneNumber = int.parse(telefono);
                      },
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.accessibility),
                    title: new TextFormField(
                      decoration: new InputDecoration(
                        hintText: 'Nombre!',
                      ),
                      onSaved: (String nombre) {
                        _user.name = nombre;
                      },
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.card_giftcard),
                    title: new TextFormField(
                      decoration: new InputDecoration(
                        hintText: 'DNI!',
                      ),
                      onSaved: (String dni) {
                        _user.dni = dni;
                      },
                    ),
                  ),
                  new Container(
                    padding: new EdgeInsets.all(20.0),
                    width: screenSize.width,
                    child: new RaisedButton(
                      shape: StadiumBorder(),
                      child: new Text(
                        'Sign Up',
                        style: new TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        submit(context);
                      },
                      color: Colors.purple,
                    ),
                    margin: new EdgeInsets.only(
                      top: 10.0,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}