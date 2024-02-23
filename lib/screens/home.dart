import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/Widgets/Drawer.dart';
import 'package:todo_app/screens/add_task.dart';
import 'package:todo_app/screens/description.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String uid='';
  @override
  void initState() {
    getuid();
    super.initState();
  }
  getuid() async {
    FirebaseAuth auth=FirebaseAuth.instance;
    final User? user=await auth.currentUser;
    setState(() {
      uid=user!.uid;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      title: Text('ToDo',style: TextStyle(fontSize: 30),),
      centerTitle: true,
      backgroundColor: Colors.yellow,

      ),
      drawer:Navbar(),
      body: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(stream: FirebaseFirestore.instance.collection('tasks').doc(uid).collection('mytask').snapshots(),
        builder: (context,snapshots){
          if(snapshots.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(color: Colors.black,)
            );
          }
          else{
            final docs=snapshots.data!.docs;
            return ListView.builder(itemCount:docs.length ,
            itemBuilder: (context,index){
              var time=(docs[index]['timestamp'] as Timestamp).toDate();

              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Description(
                    title: docs[index]['title'], description: docs[index]['description'], time:docs[index]['time'] ,)),);
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 10,right: 10,left: 10),
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                            margin: EdgeInsets.only(left: 20,),
                              child: Text(docs[index]['title'],style: GoogleFonts.roboto(fontSize: 23),)),
                          SizedBox(height: 5,),
                          Container(
                            margin: EdgeInsets.only(left: 20,),
                            child: Text(DateFormat.Md().add_jm().format(time)),
                          )
                        ],
                      ),

                      Container(
                        child: IconButton(icon: Icon(Icons.delete,color: Colors.red,),onPressed: ()async{
                          FirebaseFirestore.instance.collection('tasks').doc(uid).collection('mytask').doc(docs[index]['time']).delete();
                          FirebaseFirestore.instance.collection('completed_tasks').doc(uid).collection('my_completed_task').doc(docs[index]['time']).delete();
                        },),
                      )
                    ],
                  ),

                ),
              );
            },);
          }
        },
        ),

      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,color: Colors.white,),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTask()));
        },
        backgroundColor: Colors.lime,

      ),
    );
  }
}
