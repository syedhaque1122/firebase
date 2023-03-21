import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled11/ui/posts/post_screen.dart';
import 'package:untitled11/utils/utils.dart';
import 'package:untitled11/widgets/round_button.dart';

class VerifyCodeScreen extends StatefulWidget {

 final String verificationId;
  const VerifyCodeScreen({Key? key,required this.verificationId}) : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading=false;
  final verifyCodeController =TextEditingController();
  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,

            ),
            TextFormField(
              controller: verifyCodeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: '6 Digit code'

              ),

            ),
            SizedBox(
              height: 80,

            ),
            RoundButton(title: 'Verify',loading: loading, onTap: ()
            async{
              setState(() {
                loading =true;

              });
              final credential = PhoneAuthProvider.credential(
                  verificationId: widget.verificationId,
                  smsCode: verifyCodeController.text.toString());

              try
              {
                  await auth.signInWithCredential(credential);
                  Navigator.push(context, MaterialPageRoute(builder: (context )=> PostScreen()));
              }
              catch(e)
              {
                setState(() {
                  loading =false;

                });
                Utils().toastMessage(e.toString());

              }

            }
            ),


          ],
        ),
      ),


    );
  }
}

