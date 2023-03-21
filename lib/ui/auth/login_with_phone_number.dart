import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled11/ui/auth/verity_code.dart';
import 'package:untitled11/utils/utils.dart';
import 'package:untitled11/widgets/round_button.dart';

class LogInWithPhoneNumber extends StatefulWidget {
  const LogInWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<LogInWithPhoneNumber> createState() => _LogInWithPhoneNumberState();
}

class _LogInWithPhoneNumberState extends State<LogInWithPhoneNumber> {
 bool loading=false;
 final phoneNumberController =TextEditingController();
 final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '+880'

              ),

            ),
            SizedBox(
              height: 80,

            ),
            RoundButton(title: 'LogIn',loading: loading, onTap: ()
            {
              setState(() {
                loading=true;
              });
              auth.verifyPhoneNumber(
                phoneNumber: phoneNumberController.text,
                  verificationCompleted: (_)
                  {
                    setState(() {
                      loading=false;
                    });

                  },
                  verificationFailed: (e)
                  {
                    setState(() {
                      loading=false;
                    });
                    Utils().toastMessage(e.toString());

                  },
                  codeSent: (String verificationId, int? token)
                  {

                    Navigator.push(context, MaterialPageRoute(builder: (context) =>VerifyCodeScreen(verificationId: verificationId,)));
                    setState(() {
                      loading=false;
                    });
                  },
                  codeAutoRetrievalTimeout: (e)
                  {
                    setState(() {
                      loading=false;
                    });
                     Utils().toastMessage(e.toString());
                  });
            }
            ),


          ],
        ),
      ),


    );
  }
}

