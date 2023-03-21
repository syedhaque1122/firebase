import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:untitled11/firebase_services/add_firestore_data.dart';
import 'package:untitled11/ui/auth/login_screen.dart';

import 'package:untitled11/utils/utils.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({Key? key}) : super(key: key);

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  final auth= FirebaseAuth.instance;


  final editController=TextEditingController();
  final fireStore=FirebaseFirestore.instance.collection('users').snapshots();
  CollectionReference ref= FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("FireStore Screen"),
        backgroundColor: Colors.purple,
        centerTitle: true,
        actions: [
          IconButton(onPressed: ()

          async{

            auth.signOut().then((value)
            {

              Navigator.push(context, MaterialPageRoute(builder: (context )=> LogInScreen()));


            }).onError((error, stackTrace)
            {
              Utils().toastMessage(error.toString());


            });



          },
              icon: Icon(Icons.logout)),
          SizedBox(width: 10,),
        ],
      ),


      body: Column(
        children: [
          SizedBox(height: 10,),
          StreamBuilder<QuerySnapshot>(
            stream: fireStore,
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>  snapshot)
              {

                if(snapshot.connectionState == ConnectionState.waiting)
                  return CircularProgressIndicator();
                if(snapshot.hasError)
                  return Text('Some Error');




          return  Expanded(
                    child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context,index)
                {

                  return ListTile(
                    onTap: ()
                    {
                ref.doc(snapshot.data!.docs[index]['id'].toString()).update(
                    {
                    'title' : 'Sabbir Haque UnSubscribe'

                    }).then((value) {

                  Utils().toastMessage('Updated');
                }).onError((error, stackTrace)
                {
                  Utils().toastMessage(error.toString());

                });
                ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();

                    },
                    title: Text(snapshot.data!.docs[index]['title'].toString()),
                    subtitle: Text(snapshot.data!.docs[index]['id'].toString()),
                  );
                },

                ),
          );

              }







          ),



        ],
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: ()
        {
          Navigator.push(context, MaterialPageRoute(builder: (context )=> AddFirestoreDataScreen()));

        },
        child: Icon(Icons.add),
      ),
    );
  }
  Future<void> showMyDialog(String title, String id)async
  {
    editController.text=title;

    return showDialog(
      context: context,
      builder: (BuildContext context)
      {
        return  AlertDialog(
          title: Text('Update'),
          content: Container(
            child: TextField(
              controller: editController,
              decoration: InputDecoration(
                  hintText: "Edit Here"
              ),

            ),
          ),
          actions: [

            TextButton(onPressed: ()
            {
              Navigator.pop(context);


            },

              child: Text('Cancel'),



            ),
            TextButton(onPressed: ()
            {



            },

              child: Text('Update'),



            )


          ],

        );
      },

    );


  }
}




/*





Expanded(child: StreamBuilder(
            stream: ref.onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot)
            {

             if(!snapshot.hasData)
             {

               return CircularProgressIndicator();

             }
             else
             {
               Map<dynamic, dynamic> map= snapshot.data!.snapshot.value as dynamic;
               List<dynamic> list =[];
               list.clear();
               list=map.values.toList();
               return ListView.builder(

                   itemCount: snapshot.data!.snapshot.children.length,
                   itemBuilder: (context,index)
                   {
                     return ListTile(

                       title: Text(list[index]['title'].toString()),
                       subtitle: Text(list[index]['id'].toString()),
                     );

                   });

             }


            },

          )),
 */