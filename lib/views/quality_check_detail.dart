import 'dart:async';
import 'dart:io';
import 'package:colab/services/container.dart';
import 'package:colab/services/container2.dart';
import 'package:colab/services/textfield.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/colors.dart';
import '../network/client_project.dart';
import '../network/photos_network.dart';

// ignore: must_be_immutable
class QualityCheckDetail extends StatefulWidget {
  QualityCheckDetail({Key? key, this.from, this.qualityModel }) : super(key: key);

 // ignore: prefer_typing_uninitialized_variables
 final from;
 dynamic qualityModel;
  @override
  State<QualityCheckDetail> createState() => _SnagState();
}

class _SnagState extends State<QualityCheckDetail> {
  final getSnag = Get.find<GetNewSnag>();
  final getDeSnag=Get.find<GetNewDeSnag>();
  final getOpenedSnag = Get.find<GetOpenedSnag>();
  final locationController = TextEditingController();
  final dueDateController = TextEditingController();
  final subLocationController = TextEditingController();
  final subSubLocationController = TextEditingController();
  final activityController = TextEditingController();
  final activityHeadController = TextEditingController();
  final remarkController = TextEditingController();
  final deSnagRemarkController=TextEditingController();
  final closingRemarkController=TextEditingController();
  final markController=TextEditingController();
  final debitToController=TextEditingController();
  final debitAmountController=TextEditingController();
  final qualityCheckCreatedBy=TextEditingController();
  final snagAssignedToController=TextEditingController();
  final priorityController=TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController contractorInput = TextEditingController(text: "No Contractor");
 
    @override
  void initState() {
    super.initState(); 
    locationController.text=widget.qualityModel?.locationName??"";
    subLocationController.text=widget.qualityModel?.subLocationName??"";
    subSubLocationController.text=widget.qualityModel?.subSubLocationName??"";'';
    activityController.text=widget.qualityModel?.activity??"";
    activityHeadController.text=widget.qualityModel?.activityHead??'';
    contractorInput.text=widget.qualityModel?.contractorName??"";
    remarkController.text=widget.qualityModel?.remarks??"";
    dueDateController.text=widget.qualityModel?.dueDate??"";
    debitToController.text="";
    qualityCheckCreatedBy.text=widget.qualityModel?.createdByName??"";
    dateInput.text =getFormatedDate(DateTime.now().toString());
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
  }
    final f = DateFormat('yyyy-MM-dd hh:mm a');
   getFormatedDate(date) {
      var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
      var inputDate = inputFormat.parse(date);
      var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(inputDate);
    }

  bool iconPressed=false;
  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor:AppColors.primary,
      title: Text("Inspection Quality",style: textStyleHeadline3.copyWith(color: Colors.black,fontWeight: FontWeight.w400),),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          CustomContainer(child:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Center(child: Text('${locationController.text} / ${subLocationController.text} / ${subSubLocationController.text}' ,style: textStyleBodyText1,),),
            ])
          ),
            CustomContainer(child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Center(child: Text('${activityController.text} / ${activityHeadController.text}',style: textStyleBodyText1,),),
            ])
          ),
          CustomContainer(child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Center(child: Text(contractorInput.text,style: textStyleBodyText1,),),
            ])
          ),
            CustomContainer2(child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("CREATED BY",style: textStyleBodyText1,),
              ],),),
               const SizedBox(height: 10,),
              CustomTextField(enabled: false,controller: qualityCheckCreatedBy,)
          ])
            ),
      ]
    )
   )
  );
}
}

Widget imageDialog(text, path, context) {
return Dialog(
  backgroundColor: Colors.transparent,
  elevation: 0,
  child: Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop('dialog');
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text("CANCEL",style: TextStyle(color: AppColors.white),),
          ),
        ],
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height/1.2,
        child: Image.network(
          '$path',
          fit: BoxFit.contain,
        ),
      ),
    ],
  ),
);}
