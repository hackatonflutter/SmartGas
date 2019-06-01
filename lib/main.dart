import 'dart:io';

import 'package:flutter/cupertino.dart';
//import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'src/app.dart';

void main() async {
/*
  // Pass all uncaught errors to Crashlytics.
  FlutterError.onError = (FlutterErrorDetails details) {
    Crashlytics.instance.onError(details);
  };
  */
  runApp(App());
}