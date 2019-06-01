import 'package:flutter/material.dart';
import 'package:smart_gas/src/models/User.dart';
import 'package:smart_gas/src/pages/login/logUser.dart';

import '../../models/User.dart';
import '../../utils/Constants.dart';
import '../../provider/UserService.dart';
import 'package:amazon_cognito_identity_dart/cognito.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _userService = new UserService(Constants.userPool);

  User _user = new User();
  bool _isAuthenticated = false;


  Future<UserService> _getValues(BuildContext context) async {
    try {

      await _userService.init();
      _isAuthenticated = await _userService.checkAuthenticated();
      if (_isAuthenticated) {
        // get user attributes from cognito
        _user = await _userService.getCurrentUser();

        // get session credentials
        /*
        final credentials = await _userService.getCredentials();
        _awsSigV4Client = new AwsSigV4Client(
            credentials.accessKeyId, credentials.secretAccessKey, Constants.endpoint,
            region: Constants.region, sessionToken: credentials.sessionToken);
*/

        // get previous count
        //_counterService = new CounterService(_awsSigV4Client);
        // _counter = await _counterService.getCounter();
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

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future: _getValues(context),
        builder: (context, AsyncSnapshot<UserService> snapshot) {
          if (snapshot.hasData) {
            if (!_isAuthenticated) {
              return new LoginScreen();
            }
            return new Scaffold(
              appBar: new AppBar(
                title: new Text('bicibici',style: 
                          TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),),
              ),
              body: Center(child: Text(
                "Yastaya"
              ),),
            );
          }
          return new Scaffold(
              appBar: new AppBar(title: new Text('Loading...')));
        });
  }
}