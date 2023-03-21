import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled11/ui/auth/login_screen.dart';
import 'package:untitled11/utils/utils.dart';
import 'package:untitled11/widgets/round_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool loading=false;
  final _formKey =GlobalKey<FormState>();
  final emailController =TextEditingController();
  final passwordController =TextEditingController();

  FirebaseAuth _auth =FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  void login()
  {
    {
      setState(() {
        loading=true;
      });
      _auth.createUserWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString()).then((value)
      {
        {
          setState(() {
            loading=false;
          });


        }}).onError((error, stackTrace)
      {
        Utils().toastMessage(error.toString());
        {
          setState(() {
            loading=false;
          });

        }});

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        automaticallyImplyLeading: true,

        title: Text("SignUp Screen",
        ),

        centerTitle: true,
        backgroundColor: Colors.deepPurple,

      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Form(

              key: _formKey,
              child: Column(
                children: [

                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration:const InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email)
                    ),
                    validator: (value)
                    {
                      if(value!.isEmpty)
                      {

                        return 'Enter email';

                      }
                      return null;


                    },
                  ),

                  const SizedBox(height: 15,),

                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',

                      prefixIcon: Icon(Icons.lock),

                    ),
                    validator: (value)
                    {
                      if(value!.isEmpty)
                      {

                        return 'Enter Password';

                      }
                      return null;


                    },

                  ),


                  const SizedBox(height: 50,),



                ],
              ),),


            RoundButton(title: 'Sign Up',
              loading:  loading,

              onTap: ()
              {

                if(_formKey.currentState!.validate()){

                   login();


              }
              },
            ),
            const SizedBox(height: 30,),

            Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                Text("Already have an account?"),
                TextButton(onPressed: ()
                {

                  Navigator.push(context, MaterialPageRoute(builder: (context) =>LogInScreen()));

                },

                    child: Text("Log In")),
              ],),

          ],
        ),
      ),
    );
  }
}
