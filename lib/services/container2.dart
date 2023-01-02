
import 'package:colab/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomContainer2 extends StatelessWidget {
  final Widget child;

  const CustomContainer2({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 20,right: 20,top: 10),
           padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: child);
  }
}

class CustomContainer3 extends StatelessWidget {
  final Widget child;

  const CustomContainer3({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
            width: double.infinity,
            height: 50,
            margin: const EdgeInsets.only(left: 15,right: 15,top: 10),
           padding: const EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 10),
            decoration: BoxDecoration(
                color: AppColors.extraLightBlue,
              // border: Border.all(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: child);
  }
}



