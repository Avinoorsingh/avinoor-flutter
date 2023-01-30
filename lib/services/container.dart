import 'package:colab/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;

  const CustomContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
      padding: const EdgeInsets.only(left: 10,right: 10,top: 2,bottom: 2),
      decoration: BoxDecoration(
              border: Border.all(width: 0.2, color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(5),
            ),
      child: child
      );
  }
}


class CustomContainerWithoutMargin extends StatelessWidget {
  final Widget child;

  const CustomContainerWithoutMargin({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 20,right: 20,),
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
      decoration: BoxDecoration(
              border: Border.all(width: 0.2, color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(5),
            ),
      child: child
      );
  }
}

class CustomContainerWithoutUpperLowerMargin extends StatelessWidget {
  final Widget child;

  const CustomContainerWithoutUpperLowerMargin({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width+400,
      margin: const EdgeInsets.only(top:10,bottom: 10,left: 20,right: 20),
      padding: const EdgeInsets.only(top:10,bottom: 10),
      decoration: BoxDecoration(
              border: Border.all(width: 0.2, color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(5),
            ),
      child: child
      );
  }
}

class CustomContainerBlackBorder extends StatelessWidget {
  final Widget child;

  const CustomContainerBlackBorder({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
      decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
      child: child
      );
  }
}

class CustomGradientContainer1 extends StatelessWidget {
  final Widget child;

  const CustomGradientContainer1({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/3,
      decoration: BoxDecoration(
        border: Border.all(color:const Color.fromARGB(174, 218, 108, 108),width: 0.5),
        borderRadius: BorderRadius.circular(100),
        gradient: const LinearGradient(
          begin: Alignment(-0.95, 0.0),
          end: Alignment(1.0, 0.0),
          colors: [AppColors.white,AppColors.white],
          stops: [0.0, 1.0],
          ),
          ),
          child:child);
          }
        }

class CustomGradientContainer2 extends StatelessWidget {
  final Widget child;

  const CustomGradientContainer2({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        gradient: const LinearGradient(
          begin: Alignment(-0.95, 0.0),
          end: Alignment(1.0, 0.0),
          colors: [Color.fromARGB(174, 218, 108, 108),Color.fromARGB(251, 236, 85, 85)],
          stops: [0.0, 1.0],
          ),
          ),
          child:child);
  }
}



