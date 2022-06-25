import 'dart:io';

import 'package:flutter/material.dart';
import 'package:news_app/utilities/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MoreNews extends StatefulWidget {
  const MoreNews({ Key? key,required this.link }) : super(key: key);
  final String link;

  @override
  State<MoreNews> createState() => _MoreNewsState();
}

class _MoreNewsState extends State<MoreNews> {
   late WebViewController controller;
  double progress = 0;
    @override
  void initState() {

    super.initState();
    if(Platform.isAndroid){
      WebView.platform==AndroidWebView();
    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:()async {
        if(await controller.canGoBack()){
          controller.goBack();
          return false;
        }
        else{
          return false;
          
        }
        
      } ,
      child:SafeArea(
        child: Scaffold(
          body:Column(
            children: [
              Text('More News',style: kHealineStyle,),
              LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.white,
                    color: kBackgroundColor2,
                  ),
              Expanded(
                child: WebView(
                initialUrl: widget.link,
                javascriptMode: JavascriptMode.unrestricted,
                onProgress: (progress){
                  setState(() {
                    this.progress=progress/100;
                  });
                },
                          ),
              ),
            ]
          )
         
        ),
      )
    );
  }
}