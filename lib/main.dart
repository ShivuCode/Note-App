import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'homePage.dart';

void main() {
  const SystemUiOverlayStyle(statusBarColor: Colors.white,statusBarBrightness: Brightness.dark,systemNavigationBarColor: Colors.white,systemNavigationBarIconBrightness: Brightness.dark);
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return SizedBox(
      child: Text('${details.exception}', style: const TextStyle(fontSize: 10)),
    );
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void timer(){
    Timer(const Duration(seconds:5),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const HomePage()));
    });
  }
  @override
  void initState() {
    timer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/icon.png",width: 300,height: 300,),
            const SizedBox(height: 30,),
           const Text.rich(TextSpan(text: "Created by",children: [TextSpan(text: " Shivani bind",style: TextStyle(fontWeight: FontWeight.w600,letterSpacing: 0.8))]),)
          ],
        ),
      ),
    );
  }
}

