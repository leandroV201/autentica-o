
import 'package:apra_auth/authetication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      Provider<AuthenticationService>(create: (_) => AuthenticationService(FirebaseAuth.instance),
      ),
      
      StreamProvider(create: (context) =>context.read<AuthenticationService>().authStateChanges, initialData: null)],
      child: MaterialApp(title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthenticationWrapper(),
      )


    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseuser = context.watch<User?>();


    if (firebaseuser != null) {
      return HomePage();
    }
    return SignInPage();
  }
}
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("HOME"),
      )
    );
  }
}
class SignInPage extends StatelessWidget {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: emailcontroller,
            decoration: InputDecoration(
              labelText: "Email"
            ),
          ),
          TextField(
            controller: passwordcontroller,
            decoration: InputDecoration(
                labelText: "Password"
            ),
          ),
          ElevatedButton(onPressed: (){
            context.read<AuthenticationService>().signIn(email: emailcontroller.text.trim(), password: passwordcontroller.text.trim());
          }, child: null)
        ],
      )
    );
  }
}



