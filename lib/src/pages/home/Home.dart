import 'package:flutter/material.dart';

import '../../models/User.dart';
import '../../utils/Constants.dart';
import '../../provider/UserService.dart';
import 'package:amazon_cognito_identity_dart/cognito.dart';
import './tabs/cars/CarsTab.dart';
import './tabs/orders/OrderTab.dart';
import './tabs/progression/ProgressionTab.dart';
import './tabs/userSettings/userSettings.dart';
import '../login/logUser.dart';
import '../../pages/benefits/Benefit.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _userService = new UserService(Constants.userPool);
  User _user = new User();
  bool _isAuthenticated = false;
  int _currentIndex = 0;

  List<Widget> _children = [CarsTab(), OrderTab(), BenefitPage(), UserTab()];

  Future<UserService> _getValues(BuildContext context) async {
    try {
      await _userService.init();
      _isAuthenticated = await _userService.checkAuthenticated();
      if (_isAuthenticated) {
        _user = await _userService.getCurrentUser();
      }
      return _userService;
    } on CognitoClientException catch (e) {
      if (e.code == 'NotAuthorizedException') {
        await _userService.signOut();
        Navigator.pop(context);
      }
      throw e;
    }
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future: _getValues(context),
        builder: (context, AsyncSnapshot<UserService> snapshot) {
          if (snapshot.hasData) {
            if (!_isAuthenticated) {
              return new LoginScreen();
            }
            return new WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                    resizeToAvoidBottomPadding: false,
                    backgroundColor: Colors.white,
                    body: _children[_currentIndex],
                    bottomNavigationBar: BottomNavigationBar(
                      onTap: onTabTapped,
                      currentIndex: _currentIndex,
                      type: BottomNavigationBarType.shifting,
                      items: [
                        BottomNavigationBarItem(
                            icon: new Icon(
                              Icons.directions_car,
                              color: Colors.purple,
                            ),
                            title: Text(
                              'Mis Carros',
                              style: new TextStyle(
                                  color: Colors.purple[700],
                                  fontWeight: FontWeight.w700),
                            )),
                        BottomNavigationBarItem(
                            icon: new Icon(
                              Icons.list,
                              color: Colors.purple,
                            ),
                            title: Text(
                              'Ordenes',
                              style: new TextStyle(
                                  color: Colors.purple[700],
                                  fontWeight: FontWeight.w700),
                            )),
                        BottomNavigationBarItem(
                            icon: new Icon(
                              Icons.book,
                              color: Colors.purple,
                            ),
                            title: Text(
                              'Premios',
                              style: new TextStyle(
                                  color: Colors.purple[700],
                                  fontWeight: FontWeight.w700),
                            )),
                        BottomNavigationBarItem(
                            icon: new Icon(
                              Icons.person,
                              color: Colors.purple,
                            ),
                            title: Text(
                              'Cuenta',
                              style: new TextStyle(
                                  color: Colors.purple[700],
                                  fontWeight: FontWeight.w700),
                            ))
                      ],
                    )));
          }
          return new Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ) 
              );
        });
  }
}
