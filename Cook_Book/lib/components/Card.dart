// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../Theme/Colors.dart';
import '../Theme/Spacing.dart';

class MainCard extends StatelessWidget {
  const MainCard({Key? key, required this.img, required this.data})
      : super(key: key);

  final Widget img;
  final Widget data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical:Spacing.md),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(14.0) , color: Color.iconColor),
        child: Row( 
          
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox( height: 150 ,width: 150 ,child: img),
            ),
            Padding(
              padding: const EdgeInsets.only(top:20.0),
              child: data,
            )
          ],
         )
      ),
    );
  }
}
