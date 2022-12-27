import 'package:colab/theme/text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final bool? enabled;
  final TextEditingController? controller;

  const CustomTextField({Key? key, 
     this.label,
     this.hintText,
     this.enabled,
     this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled,
      controller: controller,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
      filled: true,
      fillColor: Colors.grey[200],
      hintStyle: const TextStyle(color: Colors.black,),
      enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
            width: 1, color:Colors.grey[300]!), 
              ),
      focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
            width: 1, color:Colors.grey[300]!),
              ),
      errorBorder: InputBorder.none,
      disabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
            width: 1, color:Colors.grey[300]!), 
      ),
      ),
       maxLines: null,
       style: textStyleHeadline2.copyWith(fontWeight: FontWeight.w400,fontSize: 16,),
    );
  }
}

class CustomTextField2 extends StatelessWidget {
  final String? label;
  final String? hintText;
  final bool? enabled;
  final TextEditingController? controller;

  const CustomTextField2({Key? key, 
     this.label,
     this.hintText,
     this.enabled,
     this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled,
      controller: controller,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
      filled: true,
      hintText: hintText,
      fillColor: Colors.grey[200],
      hintStyle: const TextStyle(color: Colors.grey,),
      enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
            width: 1, color:Colors.grey[300]!), 
              ),
      focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
            width: 1, color:Colors.grey[300]!),
              ),
      errorBorder: InputBorder.none,
      disabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
            width: 1, color:Colors.grey[300]!), 
      ),
      ),
       maxLines: null,
       style: textStyleHeadline2.copyWith(fontWeight: FontWeight.w400,fontSize: 16,),
    );
  }
}
