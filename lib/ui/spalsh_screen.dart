import 'package:flutter/material.dart';
import 'package:untitled11/firebase_services/splsah_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices splashScreen =SplashServices();
  @override
  void initState() {
    splashScreen.isLogin(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(

        child: Text("Splash Screen",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,

        ),),
      ),
    );
  }
}
