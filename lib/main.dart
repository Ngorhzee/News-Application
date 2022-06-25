import 'package:flutter/material.dart';
import 'package:news_app/models/shared_pref.dart';
import 'package:news_app/views/splash_screen.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //StoreSearch storeSearch=StoreSearch();
  //await storeSearch.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
