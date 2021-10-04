import 'package:apra_auth/src/screens/login.dart';
import 'package:apra_auth/src/screens/verify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late String _email, _password, _confirmPassword;
  final auth = FirebaseAuth.instance;
  bool isHiddenPassword =true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Registrar'),
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: 'Email'),
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              enableInteractiveSelection: false,
              obscureText: isHiddenPassword,
              decoration: InputDecoration(hintText: 'Password'),
              onChanged: (value) {
                setState(() {
                  _password = value.trim();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              enableInteractiveSelection: false,
              obscureText: isHiddenPassword,
              decoration: InputDecoration(hintText: 'Re-enter Password'),
              onChanged: (value) {
                setState(() {
                  _confirmPassword = value.trim();
                });
              },
            ),
          ),
          MaterialButton(
            onPressed: () {
              if (_password == _confirmPassword) {
                auth
                    .createUserWithEmailAndPassword(
                        email: _email, password: _password)
                    .then((_) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => VerifyScreen()));
                });
              }
            },
            height: 60,
            minWidth: double.infinity,
            color: Colors.purpleAccent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Text('Registrar'),
          ),
          Row(
            children: [
              Text("possui uma conta ?"),
              SizedBox(
                width: 10,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text('Login'))
            ],
          )
        ]));
  }
}
