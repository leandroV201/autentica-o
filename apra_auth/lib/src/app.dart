import 'package:apra_auth/src/google_signIn.dart';
import 'package:flutter/material.dart';
import 'package:apra_auth/src/screens/login.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>ChangeNotifierProvider(
    create: (context) =>GoogleSignInProvider(),
    child:
    MaterialApp(
      title: 'Login App',
      theme: ThemeData(accentColor: Colors.purple, primarySwatch: Colors.blue),
      home: LoginScreen(),
    ));

    
}
