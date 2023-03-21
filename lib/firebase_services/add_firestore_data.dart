import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled11/utils/utils.dart';


import 'package:untitled11/widgets/round_button.dart';

class AddFirestoreDataScreen extends StatefulWidget {
  const AddFirestoreDataScreen({Key? key}) : super(key: key);

  @override
  State<AddFirestoreDataScreen> createState() => _AddFirestoreDataScreenState();
}

class _AddFirestoreDataScreenState extends State<AddFirestoreDataScreen> {
  final postController =TextEditingController();
  bool loading = false;
  final fireStore=FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add FireStore Data'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: postController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Whats in your mind',
                border: OutlineInputBorder(),
              ),

            ),
            SizedBox(
              height: 30,
            ),
            RoundButton(title: 'Add',
                loading: loading,

                onTap: ()
                {
                  setState(() {
                    loading=true;
                  });
                  String id=DateTime.now().millisecondsSinceEpoch.toString();
                  fireStore.doc(id).set(
                      {

                        'title':postController.text.toString(),
                        'id':id



                      }).then((value)
                  {
                    setState(() {
                      loading=false;
                    });

                    Utils().toastMessage('Post Added');


                  }).onError((error, stackTrace)
                  {
                    setState(() {
                      loading=false;
                    });

                    Utils().toastMessage(error.toString());


                  });

                }
            ),

          ],
        ),
      ),
    );

  }



}
