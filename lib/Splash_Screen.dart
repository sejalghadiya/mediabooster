import 'package:flutter/material.dart';
import 'package:mediabooster/Main_Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 3),(){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> tabbarscreen()));
    });
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.deepPurpleAccent
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
        child: Center(
          child: Column(
            children: [
               Container(margin: EdgeInsets.only(top: 330),
                   child: Text('GANA',style: TextStyle(fontSize: 100,fontFamily: 'gana',color: Colors.white),)),
            ],
          ),
        ),
      ),
    );
  }
}
