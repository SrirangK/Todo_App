import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/auth/authscreen.dart';
import 'package:todo_app/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app/firebase_options.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(new MyApp());}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, usersnapshot) {
        if(usersnapshot.hasData){
          return Home();
        }
        else{
          return AuthScreen();
        }
        },),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light,primaryColor: Colors.blueAccent,
                       appBarTheme: AppBarTheme(color: Colors.yellow)),

    );
  }
}
