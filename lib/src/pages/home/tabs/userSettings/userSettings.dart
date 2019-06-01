import 'package:flutter/material.dart';
import '../../../../models/User.dart';

class UserTab extends StatefulWidget {
  UserTab({Key key}) : super(key: key);

  @override
  _UserTabState createState() => new _UserTabState();
}

class _UserTabState extends State<UserTab> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  User _user = new User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(45.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: CircleAvatar(
                    radius: 75.0,
                    backgroundImage: NetworkImage(
                        'https://ncatregister.com/wp-content/uploads/2018/11/stanlee.jpg'),
                    backgroundColor: Colors.transparent,
                  ),
                  )
                ],
              ),
            )
            ,Container(
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
                ],
              ),
            ),
          )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          key: Key("fab_save_profile"),
        backgroundColor: Colors.purple,
        child: Icon(Icons.save),
        ));
}}