import 'package:flutter/material.dart';
import 'package:mediabooster/Splash_Screen.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     debugShowCheckedModeBanner: false,
     home: SplashScreen(),
   );
  }

}