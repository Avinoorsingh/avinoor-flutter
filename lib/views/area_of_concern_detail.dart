import 'package:colab/services/container.dart';
import 'package:colab/services/container2.dart';
import 'package:colab/services/textfield.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
          ]
        ),
      )
    );
  }
}
