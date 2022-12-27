
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;

  const CustomContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
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






