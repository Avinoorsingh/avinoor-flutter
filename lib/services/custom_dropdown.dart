
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomDropdown extends StatelessWidget {
  String hint;
  List<DropdownMenuItem<String>> items;
  var onChanged;
  CustomDropdown({Key? key, required this.hint,required this.items,this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
              height:60,
              margin: const EdgeInsets.only(top: 20),
              child: DropdownButtonFormField(
              hint:Text(hint),
              // value: subLocationList[0],
              icon: const Padding( 
              padding: EdgeInsets.only(left:20),
              child:Icon(Icons.arrow_drop_down_circle_outlined)
             ), 
             iconEnabledColor: Colors.grey,
             style: const TextStyle(
              color: Colors.black,
              fontSize: 14
            ), 
            dropdownColor: AppColors.white,
            decoration: const InputDecoration(enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
            ),
            isExpanded: true,
            items: items,
            onChanged:onChanged
                ),
              );
  }
}




