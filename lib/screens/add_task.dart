import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/screens/home.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  addtasktofirebase()async{
    FirebaseAuth auth=FirebaseAuth.instance;
    final User user=await auth.currentUser!;
    String uid=user.uid;
    var time=DateTime.now();
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(uid)
        .collection('mytask')
        .doc(time.toString())
        .set({'title':titleController.text,'description':descriptionController.text,'time':time.toString(),'timestamp':time});
    Fluttertoast.showToast(msg: 'Task added');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Task'),backgroundColor: Colors.yellow,),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Enter Task',
                  border: OutlineInputBorder(

                  )
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              child: TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                    labelText: 'Enter Description',
                    border: OutlineInputBorder(

                    )
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(20),
                height: 90,
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                    onPressed: (){addtasktofirebase();
                    FocusScope.of(context).unfocus();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Home()));
                    },
                    child:Text('Add Task',style:
                        TextStyle(fontSize: 18,color: Colors.white
                        )
                    ) )
            )
          ],
        ),
      ),
    );
  }
}
