import 'dart:convert';
import 'package:colab/services/container.dart';
import 'package:colab/services/container2.dart';
import 'package:colab/services/textfield.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';
import '../constants/colors.dart';

// ignore: must_be_immutable
class AreaOfConcernDetail extends StatefulWidget {
  AreaOfConcernDetail({Key? key, this.from, this.concernModel }) : super(key: key);

 // ignore: prefer_typing_uninitialized_variables
 final from;
 dynamic concernModel;
  @override
  State<AreaOfConcernDetail> createState() => _AreaOfConcernState();
}

class _AreaOfConcernState extends State<AreaOfConcernDetail> {

  final locationController = TextEditingController();
  final subLocationController = TextEditingController();
  final subSubLocationController = TextEditingController();
  final activityController = TextEditingController();
  final activityHeadController = TextEditingController();
  final otherLocationController = TextEditingController();
  final descriptionController=TextEditingController();
  final assignedToController=TextEditingController();
  final statusController = TextEditingController();

  @override
  void initState() {
    super.initState(); 
    statusController.text=widget.concernModel?.status??"";
    locationController.text=widget.concernModel?.locationName??"";
    subLocationController.text=widget.concernModel?.subLocationName??"";
    subSubLocationController.text=widget.concernModel?.subSubLocationName??"";
    activityController.text=widget.concernModel?.activity??"";
    activityHeadController.text=widget.concernModel?.activityHead??"";
    otherLocationController.text=widget.concernModel?.otherLocation??"";
    descriptionController.text=widget.concernModel?.description??"";
    assignedToController.text=widget.concernModel?.assigneeName??"";
  }
   

  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor:AppColors.primary,
      title: Text("Area of concern",style: textStyleHeadline3.copyWith(color: Colors.black,fontWeight: FontWeight.w400),),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          CustomContainer(
            child: 
            Row(children: [
             Text("Status: ${statusController.text}",style: textStyleBodyText1,),
            ])
          ),
          CustomContainer(child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Center(child: Text(locationController.text.isEmpty?"Location":locationController.text,style: textStyleBodyText1,),),
              const Icon(Icons.arrow_drop_down_circle_outlined,color: Colors.grey,)
            ])
          ),
            CustomContainer(child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Center(child: Text(subLocationController.text.isEmpty?"Sub Location / Sub Sub Locations":'${subLocationController.text} / ${subSubLocationController.text}',style: textStyleBodyText1,),),
             const Icon(Icons.arrow_drop_down_circle_outlined,color: Colors.grey,)
            ])
          ),
          CustomContainer(child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
             Center(child: Text(activityHeadController.text.isEmpty?"Activity Head / Activity":'${activityHeadController.text} / ${activityController.text}',style: textStyleBodyText1,),),
            const Icon(Icons.arrow_drop_down_circle_outlined,color: Colors.grey,)
            ])
          ),
          const SizedBox(height: 20,),
            CustomContainer2(
            child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                Text("Other Location",style: textStyleBodyText1,),
              ],),),
               const SizedBox(height: 10,),
               CustomTextField3(enabled: false,controller: otherLocationController,)
          ])
            ),
             CustomContainer2(child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("DESCRIPTION",style: textStyleBodyText1,),
                Text("*",style: textStyleBodyText1.copyWith(color: AppColors.tertiary),),
              ],),),
               const SizedBox(height: 10,),
               CustomTextField3(enabled: false,controller: descriptionController,)
          ])
            ),
            CustomContainer2(child:
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("ASSIGNED TO",style: textStyleBodyText1,),
              ],),),
               CustomContainer(child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Center(child: Text(assignedToController.text.isEmpty?"--":assignedToController.text,style: textStyleBodyText1,),),
              const Icon(Icons.arrow_drop_down_circle_outlined,color: Colors.grey,)
            ])
          ),
          ])
            ),
            if(widget.concernModel?.status=="Pending")
            const SizedBox(height: 20,),
            if(widget.concernModel?.status=="Pending")
            Container(
            height: 45,
            width: MediaQuery.of(context).size.width,
            margin:const EdgeInsets.only(left: 20,right: 20),
              child: 
             ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                splashFactory: NoSplash.splashFactory,
                backgroundColor: AppColors.green),
              onPressed: () async{
                // if(locationController.text.isEmpty && otherLocationController.text.isEmpty){
                //   EasyLoading.showToast("Please select location & specify other location",toastPosition: EasyLoadingToastPosition.bottom);
                // }
                // else if(locationController.text.isEmpty){
                //     EasyLoading.showToast("Please select location",toastPosition: EasyLoadingToastPosition.bottom);
                // }
                //  else if(subLocationId.text.isEmpty){
                //   EasyLoading.showToast("Please Select SubLocation",toastPosition: EasyLoadingToastPosition.bottom);
                // }
                //   else if(subSubLocationController.text.isEmpty){
                //   EasyLoading.showToast("Please Select Activity Head",toastPosition: EasyLoadingToastPosition.bottom);
                // }
                // else if(otherLocationController.text.isEmpty){
                //   EasyLoading.showToast("Please specify other location",toastPosition: EasyLoadingToastPosition.bottom);
                // }
                //  else if(descriptionController.text.isEmpty){
                //    EasyLoading.showToast("Please add Description",toastPosition: EasyLoadingToastPosition.bottom);
                // }
                // else{
                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                var token=sharedPreferences.getString('token');
                var id=sharedPreferences.getString('id');
                var projectID=sharedPreferences.getString('projectIdd');
                var clientID=sharedPreferences.getString('client_id');
                FormData formData=FormData(); 
                var dio = Dio();
                    try {
                // formData.files.add(MapEntry("issueFile", await MultipartFile.fromFile(_selectedImage!.path, filename: "issueFile_image")));
                } catch (e) {
                  formData.fields.add(const MapEntry('issueFile', ''));
                }
                formData.fields.add(MapEntry('issueData', jsonEncode(
                  [
                    {
                        // "id": int.parse(clientID!),
                        // "client_id": int.parse(clientID),
                        // "project_id": int.parse(projectID!),
                        // "issuer_id": int.parse(id!),
                        // "issue_date": DateTime.now().toString(),
                        // "location_id":int.parse(locationId.text),
                        // "sub_location_id": int.parse(subLocationId.text),
                        // "sub_sub_location_id": int.parse(subSubLocationId.text),
                        // "activity_id": int.parse(activityId.text),
                        // "linking_activity_id": int.parse(linking_activity_id.text),
                        // "other_location": otherLocationController.text,
                        // "description": descriptionController.text,
                        // "status": "Read",
                        // "remark": "",
                    }
                ]
                   )
                   )
                   );
                    if (kDebugMode) {
                      print(formData.fields);
                    }
                  try {
                  var res= await dio.post(
                  "${Config.addAreaOfConcernApi}${DateFormat('yyyy-MM-dd').format(DateTime.now())}",
                  data: formData,
                  options: Options(
                    followRedirects: false,
                    validateStatus: (status) {
                      return status! < 500;
                    },
                    headers: {
                      "authorization": "Bearer ${token!}",
                      "Content-type": "application/json",
                    },
                  ),
                    );
                    print(res);
                    EasyLoading.showToast("Concern resolved",toastPosition: EasyLoadingToastPosition.bottom);
                }catch(e){
                  EasyLoading.showToast("Something went wrong",toastPosition: EasyLoadingToastPosition.bottom);
                  print(e);
                }
              }, 
               child: Text("Resolved",style: textStyleBodyText1.copyWith(color: AppColors.black),))
           ),
          ]
        ),
      )
    );
  }
}
