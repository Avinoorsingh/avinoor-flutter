import 'dart:io';

import 'package:colab/services/container.dart';
import 'package:colab/services/container2.dart';
import 'package:colab/services/textfield.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../constants/colors.dart';
import '../controller/signInController.dart';
import '../network/client_project.dart';
import '../network/quality_network.dart';

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
  List _items = [];
  bool _toggleValue=false;
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
  var sections = {};
  var combinedList=[];
  List sectionImages=[];

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
    return GetBuilder<SignInController>(builder: (_){
      final signInController=Get.find<SignInController>();
      if(signInController.getSectionData!.data!=null && sections.isEmpty){
        var data=[];
        for (var map in (signInController.getSectionData!.data!=null?signInController.getSectionData!.data!:data)) {
            String age = map.sectionName;
            if (!sections.containsKey(age)) {
              sections[age] = [];
            }
            sections[age]?.add(map);
          }
          combinedList=sections.values.toList();
      }
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
            Center(child: Text(contractorInput.text.isEmpty?"No Contractor":contractorInput.text,style: textStyleBodyText1,),),
            ])
          ),
          const SizedBox(height: 15,),
          Center(child: Text("Remark",style: textStyleBodyText1.copyWith(fontSize: 18),),),
          CustomContainerWithoutMargin(child: 
          Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Center(child: Text(remarkController.text.isEmpty?"No remark":remarkController.text,style: textStyleBodyText1,),),
            ])
          ])
          ),
          CustomContainerWithoutUpperLowerMargin(child:
          Column(
          children: [
          Center(child: Text("Sections",style: textStyleBodyText1.copyWith(fontSize: 16,color: Colors.grey),),),
          ListView.builder(
            physics:const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: combinedList.length,
            itemBuilder: (context, outerIndex) {
              print(combinedList[outerIndex][0].sectionName);
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    color:  const Color.fromRGBO(60, 70, 80,1),
                    child: Text(" ${combinedList[outerIndex][outerIndex].sectionName}",style: textStyleBodyText1.copyWith(color: AppColors.white,))
                  ),
                  const SizedBox(height: 15,),
                  ListView.builder(
                    physics:const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:combinedList[outerIndex].length,
                    itemBuilder: (context, innerIndex){
                    var data=[];
                    sectionImages.add({'index':outerIndex.toString(),'image':[]});
                    return
                    Column(children: [
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20,right: 10),
                      child:
                    Text(combinedList[outerIndex][innerIndex].sectionQuestion,style: textStyleBodyText1,),
                    ),
                    Switch(
                      value: _toggleValue, // Initial value of the toggle button
                      onChanged: (bool value) {
                        setState(() {
                          _toggleValue = value;
                        });
                      },
                    ),
                  ],),
                  const SizedBox(height: 15,),
                  Row(children: [
                  Container(padding:const EdgeInsets.only(left: 15),child: 
                  Row(children: [
                   Text("Remark Required",textAlign: TextAlign.start,style: textStyleBodyText2.copyWith(fontSize: 14),),
                   Text(combinedList[outerIndex][innerIndex].lineCommentRequired==1?"*":"",textAlign: TextAlign.start,style: textStyleBodyText2.copyWith(fontSize: 14),),
                  ])
                   ),
                  ]),
                   Container(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: 
                   const CustomTextField2(
                   enabled: true,
                   hintText: "Remark",
                   label: "Remark",
                   )
                   ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin:const EdgeInsets.only(right: 20),
                        child: 
                      Text(combinedList[outerIndex][innerIndex].imageRequired==1?"Image Required *":"",textAlign: TextAlign.start,style: textStyleBodyText2.copyWith(fontSize: 14),),
                      )
                  ],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    sectionImages[innerIndex]['image'].isEmpty?
                    Image.asset('assets/images/no_image_icon.png',height: 80,width: 80,):
                    FittedBox(
                           child:
                           Container(
                            margin: const EdgeInsets.only(top:10),
                            height: 150,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              image:DecorationImage(
                                image:FileImage(File(sectionImages[outerIndex]['image'][innerIndex].path)),
                              fit: BoxFit.cover,
                              ),
                            )
                          )
                        ),
                  ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100)),),
                    backgroundColor: Colors.black,
                      disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
                      shadowColor: Colors.transparent,
                  ),
                  onPressed: () async{
                      final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
                      final File imagefile = File(image!.path);
                           setState(() {
                              sectionImages[outerIndex]['image'].add(imagefile);
                              print(sectionImages);
                            });
                        if (kDebugMode) {
                          // print(response1);
                        }
                  },
                  child: 
                  Column(children: const [
                  Center(
                    child:
                    Text(
                      'Upload Image',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xffffffff),
                        letterSpacing: -0.3858822937011719,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ])
                )
                ]),
                 const SizedBox(height: 20,),
                 const Divider(thickness: 0.5,color:Colors.grey,),
                 const SizedBox(height: 10,),
                ]
                );
              }
                )
          ]
        );
    }),
      ]
    )
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
  ])
  ));
}
  );}
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
