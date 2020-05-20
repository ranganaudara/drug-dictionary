import 'package:flutter/material.dart';

import 'src/screens/dashboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drug Dctionary',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        accentColor: Colors.blueAccent,
        disabledColor: Colors.grey,
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(
            fontSize: 22.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          subtitle: TextStyle(
            fontSize: 18.0,
            fontStyle: FontStyle.normal,
            color: Colors.black54,
          ),
          body1: TextStyle(
            fontSize: 14.0,
            fontFamily: 'Hind',
          ),
          body2: TextStyle(
            fontSize: 18,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
              color: Colors.black87
          )
        ),
        buttonTheme: ButtonThemeData(
          minWidth: 0,
        ),
      ),
      home: DashBoard(),
    );
  }
}
