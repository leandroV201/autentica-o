import 'dart:ffi';

import 'package:apra_auth/src/google_signIn.dart';
import 'package:apra_auth/src/screens/forgetPass.dart';
import 'package:apra_auth/src/screens/registrar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:apra_auth/src/screens/home.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  IconData icone = Icons.visibility;
  IconData iconeoff = Icons.visibility_off;
  bool isHiddenPassword = true;
  late String _email, _password;
  final auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
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
            child: TextFormField(
              enableInteractiveSelection: false,
              obscureText: isHiddenPassword,
              decoration: InputDecoration(
                  hintText: 'Password',
                  suffixIcon: IconButton(
                      icon: isHiddenPassword == true
                          ? Icon(
                              Icons.visibility_off,
                              color: Colors.grey,
                            )
                          : Icon(
                              Icons.visibility,
                              color: Colors.grey,
                            ),
                      onPressed: () {
                        setState(() {
                          isHiddenPassword = !isHiddenPassword;
                        });
                      })),
              onChanged: (value) {
                setState(() {
                  _password = value.trim();
                });
              },
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ForgetPW()));
              },
              child: Text('Esqueceu a senha?')),
          MaterialButton(
            onPressed: () {
              auth
                  .signInWithEmailAndPassword(
                      email: _email, password: _password)
                  .then((_) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              });
            },
            height: 60,
            minWidth: double.infinity,
            color: Colors.purpleAccent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Text('Login'),
          ),
          Row(
            children: [
              Text("Não possui uma conta ?"),
              SizedBox(
                width: 10,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                  },
                  child: Text('Registrar'))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton.icon(
              icon: FaIcon(
                FontAwesomeIcons.google,
              ),
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.googleLogin();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              label: Text('Conecte-se com Google'),
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  minimumSize: Size(double.infinity, 50)),
            ),
          )
        ]));
  }

  void _togglePasswordView() {
    setState(() {
      if (isHiddenPassword == true) {
        isHiddenPassword = false;
      } else {
        isHiddenPassword = true;
      }
    });
  }

  Future<void> useGoogleAuthentication() async {}
}
