import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/screens/description.dart';
import '../Widgets/Drawer.dart';
class Completedtask extends StatefulWidget {
  const Completedtask({Key? key}) : super(key: key);

  @override
  State<Completedtask> createState() => _Completedtask();
}

class _Completedtask extends State<Completedtask> {
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
        title: Text('Task Completed'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      drawer: Navbar(),
      body: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(stream: FirebaseFirestore.instance.collection('completed_tasks').doc(uid).collection('my_completed_task').snapshots(),
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
    );
  }
}
