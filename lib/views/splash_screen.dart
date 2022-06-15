// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:news_app/views/home_page.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3),()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage())));
  }
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffDCE8F8),
      body:  Center(
        child:  Image(image:  AssetImage("assets/news-logo.png"),)
      ),
    );
  }
}