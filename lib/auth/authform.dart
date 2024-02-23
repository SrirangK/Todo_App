import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/home.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey=GlobalKey<FormState>();
  var _email="";
  var _password="";
  var _username="";
  bool isloginpage=false;

  startauthentication(){
    final validity=_formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(validity){
      _formkey.currentState?.save();
      submitform(_email, _password, _username);
    }
  }

  submitform(String email,String password,String username)async{
    final auth=FirebaseAuth.instance;
    UserCredential authResult;
    try{
      if(isloginpage){
        authResult=await auth.signInWithEmailAndPassword(email: email, password: password);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Home()));
      }
      else{
        authResult=await auth.createUserWithEmailAndPassword(email: email, password: password);
        String uid=authResult.user!.uid;
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'username':username,
          'email':email,
        },
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Home()));
      }

    }catch(err){
      print(err);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          Container(
            height: 200,
            margin: EdgeInsets.all(30),
            child: Image.asset("assets/todo.png"),
          ),
          Container(
            padding: EdgeInsets.only(top: 10,right: 10,left: 10),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(!isloginpage)
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('username'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Incorrect username';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _username = value!;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: new BorderSide(),
                            borderRadius: new BorderRadius.circular(8),
                          ),
                          labelText: "Enter Username",
                          labelStyle: GoogleFonts.roboto()
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('email'),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Incorrect email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: new BorderSide(),
                            borderRadius: new BorderRadius.circular(8),
                          ),
                          labelText: "Enter Email",
                          labelStyle: GoogleFonts.roboto()
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('password'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Incorrect password';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value!;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: new BorderSide(),
                            borderRadius: new BorderRadius.circular(8),
                          ),
                          labelText: "Enter Password",
                          labelStyle: GoogleFonts.roboto()
                      ),
                    ),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.all(10),
                      height:70,
                      width:double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: ElevatedButton(
                        onPressed: () {startauthentication();  },
                        child: isloginpage?Text("Login",style:GoogleFonts.roboto(fontSize: 16),):Text("SignUp",style: GoogleFonts.roboto(fontSize: 16),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white38,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                          ))
                      )
                  ),
                  SizedBox(height: 10,),
                  Container(
                    child: TextButton(onPressed: () {
                      setState(() {
                        isloginpage=!isloginpage;
                      });
                    }, child: isloginpage?Text('Not registerd?'):Text('Already registered?'),
                      
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
