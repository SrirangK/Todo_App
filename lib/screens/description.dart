import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class Description extends StatelessWidget {

  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  final String title,description,time;
  Description({Key? key, required this.title, required this.description, required this.time}) : super(key: key);
  complete()async{
    FirebaseAuth auth=FirebaseAuth.instance;
    final User user=await auth.currentUser!;
    String uid=user.uid;
    var Time=DateTime.now();
    await FirebaseFirestore.instance
        .collection('completed_tasks')
        .doc(uid)
        .collection('my_completed_task')
        .doc(Time.toString())
        .set({'title':title,'description':description,'time':Time.toString(),'timestamp':Time});
    Fluttertoast.showToast(msg: 'Task Completed');
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(uid)
        .collection('mytask')
        .doc(time.toString())
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("To Do",style: GoogleFonts.roboto(fontSize: 28),),
        centerTitle: true,
        backgroundColor: Colors.yellow,
        toolbarHeight: 75,
      ),
      body: Container(
        // padding: EdgeInsets.only(top: 60,left: 20),
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60.0,bottom: 30),
                child: Container(child: Text(title,style:GoogleFonts.roboto(fontSize: 35,fontWeight: FontWeight.bold))),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:  EdgeInsets.only(left:0),
                child: Container(
                  height: MediaQuery.of(context).size.height/2,
                  width: MediaQuery.of(context).size.width/1.4,
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey,width: 3)
                  ),
                    child: Text(" "+description,style:GoogleFonts.roboto(fontSize: 25,))),
              ),

            ],
          ),

        ],
      )),
       floatingActionButton: FloatingActionButton.extended(
            icon:Icon(Icons.check_circle,color: Colors.white,),
            label: Text('Mark as complete'),
            onPressed: complete,
            backgroundColor: Colors.green,
            ),
    );
  }
}
