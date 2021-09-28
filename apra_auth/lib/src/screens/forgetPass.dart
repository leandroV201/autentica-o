
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:apra_auth/src/screens/login.dart';

class ForgetPW extends StatefulWidget {
  @override
  _ForgetPWState createState() => _ForgetPWState();
}

class _ForgetPWState extends State<ForgetPW> {
  late String _email;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Recuperar senha'),
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
          MaterialButton(
            onPressed: () {
              auth.sendPasswordResetEmail(email: _email);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            height: 60,
            minWidth: double.infinity,
            color: Colors.purpleAccent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Text('Verificar Email'),
          ),
        ]));
  }
}
