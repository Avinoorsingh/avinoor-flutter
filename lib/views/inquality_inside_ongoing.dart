import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:colab/config.dart';
import 'package:colab/constants/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/signInController.dart';
import '../network/progress_network.dart';
import '../theme/text_styles.dart';

class InQualityInsideOnGoing extends StatefulWidget {
  const InQualityInsideOnGoing({Key? key,}) : super(key: key);

  @override
  State<InQualityInsideOnGoing> createState() => _OnProgressState();
}

bool show=false;
late var tapped;
var update;

class _OnProgressState extends State<InQualityInsideOnGoing> {
  List<String?> locationName=[];
  List<int?> locationDraft=[];
  List<int?> locationCount=[];
  List<String?> subLocationName=[];
  List<int?> subLocationCount=[];
  List<int?> subLocationID=[];
  List<int?> subLocationDraft=[];
  List<String?> subSubLocationName=[];
  List<int?> subSubLocationCount=[];
  List<int?> subSubLocationDraft=[];
  List<String?> dueDates=[];
  List<String?> createdDates=[];
  List<int?> locationID=[];
  List<String?> remark=[];
  List snagData=[];
  List dateDifference=[];
  TextEditingController locationIDController=TextEditingController();
 
 @override
 void initState(){
  super.initState();
 }

  @override
  Widget build(BuildContext context) {
    return 
    GetBuilder<GetOnGoingSiteProgress>(builder: (_){
      final signInController=Get.find<SignInController>();
     if(signInController.getOnGoingProcessData!.data!.isNotEmpty && locationName.isEmpty){
      for(int i=0;i<signInController.getOnGoingProcessData!.data!.length;i++){
       locationName.add(signInController.getOnGoingProcessData!.data![i].locationName!);
       locationDraft.add(signInController.getOnGoingProcessData!.data![i].draftCount??0);
       locationID.add(signInController.getOnGoingProcessData!.data![i].locationId!);
       locationCount.add(signInController.getOnGoingProcessData!.data![i].count??0);
     }
     }
    EasyLoading.dismiss();
    return 
     Scaffold(
    body: 
    Container(margin: const EdgeInsets.only(top: 90),
    child:
    ListView(
      children: [],
      )
      )
      );
      }
      );
      }
}