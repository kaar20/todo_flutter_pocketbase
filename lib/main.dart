import 'package:flutter/material.dart';
import 'package:todo/regLog/login.dart';
import 'package:todo/regLog/register.dart';

void main() {
  runApp(startUp());
}

class startUp extends StatelessWidget {
  const startUp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => sRegister(),
        '/login': (context) => Login(),
      },
    );
  }
}
