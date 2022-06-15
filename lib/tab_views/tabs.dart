// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Tabs extends StatelessWidget {
  Tabs({Key? key, required this.color, required this.text,this.icon}) : super(key: key);
  late String text;
  late Color color;
  final IconData ? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0,right: 15),
      child:Column(children: [
         Icon(icon,color: color,size: 5,),
         Center(
          child: Text(
        text,
        style: GoogleFonts.nunitoSans(fontSize: 20,fontWeight:FontWeight.w500,color: color),
      )),
      ],)
    );
  }
}

