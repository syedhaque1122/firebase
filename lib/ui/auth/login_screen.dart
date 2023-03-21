import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled11/ui/auth/login_with_phone_number.dart';
import 'package:untitled11/ui/auth/signup_screen.dart';
import 'package:untitled11/ui/forgot_password.dart';
import 'package:untitled11/ui/posts/post_screen.dart';
import 'package:untitled11/utils/utils.dart';
import 'package:untitled11/widgets/round_button.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool loading=false;
  final _formKey =GlobalKey<FormState>();
  final emailController =TextEditingController();
  final passwordController =TextEditingController();
  final _auth= FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login()
  {
    setState(() {
      loading =true;
    });

    _auth.signInWithEmailAndPassword(email: emailController.text.toString(), password: passwordController.text.toString()).then((value)
    {
      Utils().toastMessage(value.user!.email.toString());
      Navigator.push(context, MaterialPageRoute(builder: (context)=> PostScreen()));


      setState(() {
        loading =false;
      });

    }).onError((error, stackTrace)
    {
      debugPrint(error.toString());
     Utils().toastMessage(error.toString());
      setState(() {
        loading =false;
      });


    });
    
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{

        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(

          automaticallyImplyLeading: false,

          title: Text("LogIn Screen",
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


              RoundButton(title: 'Login',
              loading: loading,

              onTap: ()
              {

                if(_formKey.currentState!.validate())
                {

                     login();

                }



              },),
              const SizedBox(height: 30,),
              
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>ForgotPasswordScreen()));


                },

                    child: Text("Forgot paswword")
                ),
              ),
              const SizedBox(height: 30,),

              Row(

                mainAxisAlignment: MainAxisAlignment.center,
                children:
              [
                Text("Don't have an account?"),
               TextButton(onPressed: ()
               {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>SignUpScreen()));


               },

                   child: Text("Sign Up")),
              ],
              ),
              SizedBox(height: 30,),
              
              InkWell(
                onTap: (){

                  Navigator.push(context, MaterialPageRoute(builder: (context) =>LogInWithPhoneNumber()));
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.black,
                    )
                  ),
                  child: Center(
                    child:  Text('Login with Phone'),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
