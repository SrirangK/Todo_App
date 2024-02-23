import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../auth/authscreen.dart';
import '../screens/completed_task.dart';
import '../screens/home.dart';

class Navbar extends StatelessWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: ListView(
        children: [
          SizedBox(height:20),
          ListTile(
            leading: Icon(Icons.incomplete_circle,color: Colors.red,),
            title: const Text('TO DO!'),
            onTap: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home())),
          ),
          ListTile(
            leading: Icon(Icons.download_done_sharp,color: Colors.green,),
            title: const Text('Completed Task'),
            onTap: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Completedtask())),
          ),
          ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sign Out'),
              onTap: () async{
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AuthScreen()));
              }
          ),
        ],
      ),
    );
  }
}
