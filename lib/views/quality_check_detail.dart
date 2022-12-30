import 'dart:convert';
import 'dart:io';
import 'package:colab/services/container.dart';
import 'package:colab/services/container2.dart';
import 'package:colab/services/custom_dropdown.dart';
import 'package:colab/services/textfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/colors.dart';
import '../controller/signInController.dart';
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
  final locationController = TextEditingController();
  final dueDateController = TextEditingController();
  final subLocationController = TextEditingController();
  final subSubLocationController = TextEditingController();
  final activityController = TextEditingController();
  final activityHeadController = TextEditingController();
  final remarkController = TextEditingController();
  final closingRemarkController=TextEditingController();
  final debitAmountController=TextEditingController(text: "0");
  final qualityCheckCreatedBy=TextEditingController();
  final qualityCheckClosedBy=TextEditingController();
  final closedDebitAmountController=TextEditingController();
  final closedDebitToController=TextEditingController();
  final qualityCheckRescheduledBy=TextEditingController();
  final debitToController=TextEditingController();
  ////////////////////////////////////////////////
  final checkListIDController=TextEditingController();
  final checkListIDSessionController=TextEditingController();
  final lineCommentController=TextEditingController();
  final lineActivityIDController=TextEditingController();
  final image=TextEditingController(text: "");
  final debetContractor=TextEditingController(text: "0");
  final dueDate=TextEditingController(text: "0");
  final closedDate=TextEditingController(text: "0");
  final status=TextEditingController();
  final checkNewCode=TextEditingController();
  final userIDController=TextEditingController();
  final editIDController=TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController dateInput2 = TextEditingController();
  TextEditingController contractorInput = TextEditingController(text: "No Contractor");
  var sections = {};
  var combinedList=[];
  List sectionImages=[];
  List toggleButtons=[];
  List remarks=[];
  List imageRequiredList=[];
  List images=[];
  List edits=[];
  List checkIDs=[];
  List names=[];
  List questions=[];
  List cLSessionIDs=[];
  List comments=[];
  List uploads=[];

  final getNewQualityDataController=Get.find<GetNewCheckList>();
  final getOpenedQualityDataController=Get.find<GetOpenedCheckList>();
  final getClosedQualityDataController=Get.find<GetClosedCheckList>();
  List<List<Map<String, dynamic>>> sublists = [];
  Map<int, List<Map<String, dynamic>>> group = {};

  List<List<Map<String, dynamic>>> checkedStatus = [];
  Map<int, List<Map<String, dynamic>>> groupCheckedStatus = {};

  List<List<Map<String, dynamic>>> lineComment = [];
  Map<int, List<Map<String, dynamic>>> groupLineComment = {};

  
  List<List<Map<String, dynamic>>> imageRequired = [];
  Map<int, List<Map<String, dynamic>>> groupImageRequired = {};

  List<List<Map<String, dynamic>>> uploadedImageRequired = [];
  Map<int, List<Map<String, dynamic>>> groupUploadedImageRequired = {};

  List<List<Map<String, dynamic>>> commentRequired = [];
  Map<int, List<Map<String, dynamic>>> groupCommentRequired = {};

  List<List<Map<String, dynamic>>> editID = [];
  Map<int, List<Map<String, dynamic>>> groupEditID = {};

  List<List<Map<String, dynamic>>> checkListID=[];
  Map<int, List<Map<String, dynamic>>> groupCheckListID = {};

  List<List<Map<String, dynamic>>> sectionNames=[];
  Map<int, List<Map<String, dynamic>>> groupSectionNames = {};

  List<List<Map<String, dynamic>>> sectionQuestions=[];
  Map<int, List<Map<String, dynamic>>> groupSectionQuestions = {};

  List<List<Map<String, dynamic>>> checkListQuestionIDs=[];
  Map<int, List<Map<String, dynamic>>> groupSessionIDs = {};

  List requiredCommentsForSubmission=[];

  bool toggleButton=false;
  final debitTo = ["Select Debit to", "Person 1", "Person 2", "Person 3", "Person 4"];
  String dropdownvalueDebitTo = 'Select Debit to';  

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
    qualityCheckClosedBy.text=widget.qualityModel?.updatedByName??"";
    qualityCheckRescheduledBy.text=widget.qualityModel?.updatedByName??"";
    closedDate.text=widget.qualityModel?.closeDate??"";
    closedDebitAmountController.text=widget.qualityModel?.debitAmount.toString()=='null'?"--":widget.qualityModel?.debitAmount;
    closedDebitToController.text="--";
    dateInput.text =getFormatedDate(DateTime.now().toString());
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
  }
    final f = DateFormat('yyyy-MM-dd hh:mm a');
   getFormatedDate(date) {
      var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
      var inputDate = inputFormat.parse(date);
      var outputFormat = DateFormat('dd-MM-yyyy');
    return outputFormat.format(inputDate);
    }

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

          ////////////////controllers//////////////////
          checkListIDController.text=signInController.getSectionData!.data![0].cId.toString();
          checkListIDSessionController.text=signInController.getSectionData!.data![0].cSId.toString();
          lineCommentController.text=signInController.getSectionData!.data![0].lineComment.toString();
          lineActivityIDController.text=signInController.getSectionData!.data![0].linkActivityId.toString().toString();
          image.text=signInController.getSectionData!.data![0].image.toString();
          debetContractor.text=signInController.getSectionData!.data![0].debetContactor.toString();
          dueDate.text=signInController.getSectionData!.data![0].dueDate.toString();
          status.text=signInController.getSectionData!.data![0].status.toString();
          checkNewCode.text=signInController.getSectionData!.data![0].newCheckCode.toString();
          userIDController.text="";
          editIDController.text=signInController.getSectionData!.data![0].editId.toString();
          ////////////////sectionImages/////////////////////////
          for(int i=0;i<combinedList.length;i++){
            for(int j=0;j<combinedList[i].length;j++){
            sectionImages.add({'index':i,'image':[]});
            }
          }
          for (Map<String, dynamic> map in sectionImages) {
            int index = map['index'];
            if (!group.containsKey(index)) {
              group[index] = [];
            }
            group[index]?.add(map);
          }
          for (List<Map<String, dynamic>> sublist in group.values) {
            sublists.add(sublist);
          }
          //////////////////////Toggle-Buttons////////////////////////////////////
          for(int i=0;i<combinedList.length;i++){
            for(int j=0;j<combinedList[i].length;j++){
            toggleButtons.add({'index':i,'buttonValue':combinedList[i][j].checkedStatus??false});
            }
          }
          for (Map<String, dynamic> map in toggleButtons) {
            int index = map['index'];
            if (!groupCheckedStatus.containsKey(index)) {
              groupCheckedStatus[index] = [];
            }
            groupCheckedStatus[index]?.add(map);
          }
          for (List<Map<String, dynamic>> sublist in groupCheckedStatus.values) {
            checkedStatus.add(sublist);
          }

          /////////////////////////Remarks-requried///////////////////////////////////////////
            for(int i=0;i<combinedList.length;i++){
            for(int j=0;j<combinedList[i].length;j++){
            remarks.add({'index':i,'remarks':combinedList[i][j].lineComment??""});
            }
          }
          for (Map<String, dynamic> map in remarks) {
            int index = map['index'];
            if (!groupLineComment.containsKey(index)) {
              groupLineComment[index] = [];
            }
            groupLineComment[index]?.add(map);
          }
          for (List<Map<String, dynamic>> sublist in groupLineComment.values) {
            lineComment.add(sublist);
          }

          ///////////////////////Image required//////////////////////
           for(int i=0;i<combinedList.length;i++){
            for(int j=0;j<combinedList[i].length;j++){
            imageRequiredList.add({'index':i,'imageRequired':combinedList[i][j].imageRequired??""});
            }
          }
          for (Map<String, dynamic> map in imageRequiredList) {
            int index = map['index'];
            if (!groupImageRequired.containsKey(index)) {
              groupImageRequired[index] = [];
            }
            groupImageRequired[index]?.add(map);
          }
          for (List<Map<String, dynamic>> sublist in groupImageRequired.values) {
            imageRequired.add(sublist);
          }
          ////////////////////uploaded-Images////////////////////
           for(int i=0;i<combinedList.length;i++){
            for(int j=0;j<combinedList[i].length;j++){
            uploads.add({'index':i,'uploaded':combinedList[i][j].image??""});
            }
          }
          for (Map<String, dynamic> map in uploads) {
            int index = map['index'];
            if (!groupUploadedImageRequired.containsKey(index)) {
              groupUploadedImageRequired[index] = [];
            }
            groupUploadedImageRequired[index]?.add(map);
          }
          for (List<Map<String, dynamic>> sublist in groupUploadedImageRequired.values) {
            uploadedImageRequired.add(sublist);
          }
          ///////////////////CommentRequired//////////////
             for(int i=0;i<combinedList.length;i++){
            for(int j=0;j<combinedList[i].length;j++){
            comments.add({'index':i,'commentRequired':combinedList[i][j].lineCommentRequired??""});
            }
          }
          for (Map<String, dynamic> map in comments) {
            int index = map['index'];
            if (!groupCommentRequired.containsKey(index)) {
              groupCommentRequired[index] = [];
            }
            groupCommentRequired[index]?.add(map);
          }
          for (List<Map<String, dynamic>> sublist in groupCommentRequired.values) {
            commentRequired.add(sublist);
          }
          //////////////////Edit_ID/////////////////////////
            for(int i=0;i<combinedList.length;i++){
            for(int j=0;j<combinedList[i].length;j++){
            edits.add({'index':i,'editID':combinedList[i][j].editId.toString()});
            }
          }
          for (Map<String, dynamic> map in edits) {
            int index = map['index'];
            if (!groupEditID.containsKey(index)) {
              groupEditID[index] = [];
            }
            groupEditID[index]?.add(map);
          }
          for (List<Map<String, dynamic>> sublist in groupEditID.values) {
            editID.add(sublist);
          }
          ////////////checklist_section_linking_id///////////
            for(int i=0;i<combinedList.length;i++){
            for(int j=0;j<combinedList[i].length;j++){
            checkIDs.add({'index':i,'checkID':combinedList[i][j].checklistSectionLinkingId.toString()});
            }
          }
          for (Map<String, dynamic> map in checkIDs) {
            int index = map['index'];
            if (!groupCheckListID.containsKey(index)) {
              groupCheckListID[index] = [];
            }
            groupCheckListID[index]?.add(map);
          }
          for (List<Map<String, dynamic>> sublist in groupCheckListID.values) {
            checkListID.add(sublist);
          }
           ///////////////////////////////sectionName///////////////////////////////
            for(int i=0;i<combinedList.length;i++){
            for(int j=0;j<combinedList[i].length;j++){
            names.add({'index':i,'sectionName':combinedList[i][j].sectionName.toString()});
            }
          }
          for (Map<String, dynamic> map in names) {
            int index = map['index'];
            if (!groupSectionNames.containsKey(index)) {
              groupSectionNames[index] = [];
            }
            groupSectionNames[index]?.add(map);
          }
          for (List<Map<String, dynamic>> sublist in groupSectionNames.values) {
            sectionNames.add(sublist);
          }
          /////////////////////SectionQuestions////////////////
           for(int i=0;i<combinedList.length;i++){
            for(int j=0;j<combinedList[i].length;j++){
            questions.add({'index':i,'sectionQuestions':combinedList[i][j].sectionQuestion.toString()});
            }
          }
          for (Map<String, dynamic> map in questions) {
            int index = map['index'];
            if (!groupSectionQuestions.containsKey(index)) {
              groupSectionQuestions[index] = [];
            }
            groupSectionQuestions[index]?.add(map);
          }
          for (List<Map<String, dynamic>> sublist in groupSectionQuestions.values) {
            sectionQuestions.add(sublist);
          }
           /////////////////////CheckListSessionId////////////////
           for(int i=0;i<combinedList.length;i++){
            for(int j=0;j<combinedList[i].length;j++){
            cLSessionIDs.add({'index':i,'cSID':combinedList[i][j].cSId.toString()});
            }
          }
          for (Map<String, dynamic> map in cLSessionIDs) {
            int index = map['index'];
            if (!groupSessionIDs.containsKey(index)) {
              groupSessionIDs[index] = [];
            }
            groupSessionIDs[index]?.add(map);
          }
          for (List<Map<String, dynamic>> sublist in groupSessionIDs.values) {
           checkListQuestionIDs.add(sublist);
          }
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
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    color:  const Color.fromRGBO(60, 70, 80,1),
                    child: Text(" ${combinedList[outerIndex][0].sectionName}",style: textStyleBodyText1.copyWith(color: AppColors.white,))
                  ),
                  const SizedBox(height: 15,),
                  ListView.builder(
                    physics:const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:combinedList[outerIndex].length,
                    itemBuilder: (context, innerIndex){
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
                      value: (checkedStatus[outerIndex][innerIndex]['buttonValue']==1||checkedStatus[outerIndex][innerIndex]['buttonValue']==true)?true:false,
                       // Initial value of the toggle button
                      onChanged: widget.from!="closed"?(bool value) {
                        setState(() {
                          checkedStatus[outerIndex][innerIndex]['buttonValue']=value;
                          if (checkedStatus.every((sublist) => sublist.every((item) => item['buttonValue'] == true ||item['buttonValue'] == 1))) {
                            toggleButton=true;
                          }
                          else{
                            toggleButton=false;
                          }
                        });
                      }:null,
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
                  CustomTextField2(
                   onChanged: (String newValue) {
                    setState(() {
                      lineComment[outerIndex][innerIndex]['remarks']=newValue;
                    });
                  },
                   enabled: widget.from!="closed"?true:false,
                   hintText: lineComment[outerIndex][innerIndex]['remarks'],
                   label: "Remark",
                   )
                   ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin:const EdgeInsets.only(right: 40),
                        child: 
                      Text(widget.from!="closed"?(combinedList[outerIndex][innerIndex].imageRequired==1?"Image Required *":""):"",
                      textAlign: TextAlign.start,
                      style: textStyleBodyText2.copyWith(fontSize: 14),),
                      )
                  ],),
                  if(widget.from=="closed")...{
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    uploadedImageRequired[outerIndex][innerIndex]['uploaded'].isNotEmpty?
                    Image.network('https://nodejs.hackerkernel.com/colab${uploadedImageRequired[outerIndex][innerIndex]['uploaded']}',height: 100,width: 100,):
                    sublists[outerIndex][innerIndex]['image'].isEmpty?
                    Image.asset('assets/images/no_image_icon.png',height: 100,width: 100,):
                    FittedBox(
                           child:
                           Container(
                            margin: const EdgeInsets.only(top:10),
                            height: 150,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              image:DecorationImage(
                                image:FileImage(File(sublists[outerIndex][innerIndex]['image'][0].path)),
                              fit: BoxFit.cover,
                              ),
                            )
                          )
                        ),
                ]),
                  },
                  if(widget.from!="closed")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    uploadedImageRequired[outerIndex][innerIndex]['uploaded'].isNotEmpty?
                    Image.network('https://nodejs.hackerkernel.com/colab${uploadedImageRequired[outerIndex][innerIndex]['uploaded']}',height: 80,width: 80,):
                    sublists[outerIndex][innerIndex]['image'].isEmpty?
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
                                image:FileImage(File(sublists[outerIndex][innerIndex]['image'][0].path)),
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
                              sublists[outerIndex][innerIndex]['image'].add(imagefile);
                            });
                        if (kDebugMode) {
                           print(sublists);
                        }
                  },
                  child: 
                  Column(children: const [
                  Center(
                    child:
                    Text(
                      'Upload Image',
                      style: TextStyle(
                        fontSize: 14,
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
     if(widget.from=="opened")...{
     CustomContainer2(child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                const Text("Due Date:",),
                SizedBox(width:100),
                Container(
                  height: 10,
                  width: MediaQuery.of(context).size.width/2.5,
                  child: 
                TextField(
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(top: 35),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      ),
                      readOnly: true,
                      controller: dateInput,
                      onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                              primaryColor: AppColors.primary,
                              buttonTheme: const ButtonThemeData(
                              textTheme: ButtonTextTheme.primary),
                              colorScheme: const ColorScheme.light(primary:AppColors.primary,).copyWith(secondary: const Color(0xFF8CE7F1)),
                          ),
                     child: child!,
                    );
                     }, 
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100)
                  );
                if (pickedDate != null) {
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  setState(() {
                    dateInput.text =formattedDate;
                    dateInput2.text=pickedDate.toString();
                  });
                } else {}
              },
              style:const TextStyle(fontSize: 16,fontWeight: FontWeight.normal),
            ),
                ),
                const Text(""),
              ],),),
          ])
            ),
     CustomContainer2(child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("RESCHEDULED BY",style: textStyleBodyText1,),
              ],),),
               const SizedBox(height: 10,),
              CustomTextField(enabled: false,controller: qualityCheckRescheduledBy,)
          ])
            ),
     },
     if(widget.from=="closed")...{
        CustomContainer2(child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("DEBIT TO",style: textStyleBodyText1,),
              ],),),
               const SizedBox(height: 10,),
              CustomTextField(enabled: false,controller: closedDebitToController,)
          ])
            ),
             CustomContainer2(child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("DEBIT AMOUNT",style: textStyleBodyText1,),
              ],),),
               const SizedBox(height: 10,),
              CustomTextField(enabled: false,controller: closedDebitAmountController,)
          ])
            ),
             CustomContainer2(child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                const Text("Closed Date:",),
                Text(closedDate.text),
                const Text(""),
              ],),),
          ])
            ),
     },
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
            if(widget.from=="closed")...{
                CustomContainer2(child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("CLOSED BY",style: textStyleBodyText1,),
              ],),),
               const SizedBox(height: 10,),
              CustomTextField(enabled: false,controller: qualityCheckClosedBy,)
          ])
            ),
            },
            if(widget.from!="closed")...{
        // ignore: unrelated_type_equality_checks
        if (toggleButton==true)...{
          Container(
            margin:const EdgeInsets.only(left: 20,right: 20),
            child:
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(MediaQuery.of(context).size.width,40),
            backgroundColor: AppColors.secondary),
          onPressed: () async {
            // Handle button press
            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                      var token=sharedPreferences.getString('token');
                      var userId=sharedPreferences.getString('id');
                      FormData formData=FormData(); 
                      var dio = Dio();
                      List checkDetails=[];
                      List uploadFiles=[];
                  
                      if(sublists.isNotEmpty){
                          for(int i=0;i<combinedList.length;i++){
                        for(int j=0;j<combinedList[i].length;j++){
                          if(sublists[i][j]['image'].isNotEmpty && checkListID[i][j]['checkID']!='null'){
                            formData.files.add(
                              MapEntry("file${checkListID[i][j]['checkID'].toString()}", await MultipartFile.fromFile(sublists[i][j]['image'][0].toString().split(':')[1].replaceAll('\'', '').replaceAll('\'', '').trim(),filename: "sectionImage")
                            ));
                          }
                        }}
                      }
                     
                      for(int i=0;i<combinedList.length;i++){
                        for(int j=0;j<combinedList[i].length;j++){
                           var map = {
                            "editId":int.parse(editID[i][j]["editID"].toString()),
                            "c_id":int.parse(checkListIDController.text.toString()),
                            "checklist_section_linking_id":int.parse(checkListID[i][j]['checkID'].toString()),
                            "section_name":sectionNames[i][j]['sectionName'].toString(),
                            "section_question":sectionQuestions[i][j]['sectionQuestions'].toString(),
                            "checkList_question_id":int.parse(checkListID[i][j]['checkID'].toString()),
                            "checklist_session_id":int.parse(checkListQuestionIDs[i][j]['cSID'].toString()),
                            "cm_status":null,//to be handled correctlt
                            "new_check_code":checkNewCode.text,
                            "status":null,
                            "checked_status":checkedStatus[i][j]['buttonValue']==true?1:null,
                            "line_comment_required":int.parse(commentRequired[i][j]['commentRequired'].toString()),
                            "image_required":int.parse(imageRequired[i][j]["imageRequired"].toString()),
                            "line_comment":lineComment[i][j]["remarks"].toString(),
                            "image":uploadedImageRequired[i][j]['uploaded'].toString(),
                          };
                          checkDetails.add(map);
                        }
                      }
                      formData.fields.add(MapEntry('addcheckListInfo', jsonEncode({
                      "checklist_id":"",
                      "checklist_session_id": "",
                      "line_comment":"",
                      "link_activity_id":int.parse(lineActivityIDController.text),
                      "image": "",
                      "debet_contactor": null,
                      // int.parse(debetContractor.text!='null'?debetContractor.text:"0").toString(),
                      "debit_amount": null,
                      "due_date": dateInput.text,
                      "status":"",
                      "check_new_code":checkNewCode.text,
                      'remarks':remarkController.text,
                      "closing_remark": closingRemarkController.text,
                      "user_id": userId.toString(),
                      "checkListDetails":checkDetails,
                   })
                   )
                   );
                     for(int i=0;i<combinedList.length;i++){
                        for(int j=0;j<combinedList[i].length;j++){
                           var map = {
                            "c_id":int.parse(checkListID[i][j]['checkID'].toString()),
                            "checklist_session_id":int.parse(checkListQuestionIDs[i][j]['cSID'].toString()),
                            "status":null,
                            "close_type":"Closed",
                            "checked_status":checkedStatus[i][j]['buttonValue']==true?1:null,
                            "line_comment":lineComment[i][j]["remarks"].toString(),
                            "reject_count":0,
                            "checklist_section_linking_id":int.parse(checkListID[i][j]['checkID'].toString()),
                            "id":int.parse(editID[i][j]['editID']),//to be handled
                            "new_check_code":checkNewCode.text,
                            "image":uploadedImageRequired[i][j]['uploaded'].toString(),
                          };
                          uploadFiles.add(map);
                        }
                      }

                   formData.fields.add(MapEntry('uploadFiles', jsonEncode(uploadFiles)));
                   formData.fields.add(MapEntry('editId', jsonEncode(int.parse(editIDController.text))));
                   formData.fields.add(MapEntry('due_date', jsonEncode(dateInput.text)));
                   formData.fields.add(MapEntry('status', jsonEncode(null)));
                   formData.files.add(MapEntry("file", MultipartFile.fromString("", filename: "image_name")));
                   formData.files.add(MapEntry("check_image", MultipartFile.fromString("", filename: "image_name")));
                    if (kDebugMode) {}
                  try {
                    bool shouldMakeRequest = true;
                    bool shouldMakeRequestAfterImages = true;
                    for(int i=0;i<combinedList.length;i++){
                        for(int j=0;j<combinedList[i].length;j++){
                          if(int.parse(commentRequired[i][j]['commentRequired'].toString())==1 
                          && lineComment[i][j]["remarks"].isEmpty){
                            shouldMakeRequest =false;
                            break;
                          }
                        }
                    }
                     for(int i=0;i<combinedList.length;i++){
                        for(int j=0;j<combinedList[i].length;j++){
                          if(int.parse(imageRequired[i][j]["imageRequired"].toString())==1 
                          && sublists[i][j]['image'].isEmpty && uploadedImageRequired[i][j].isEmpty){
                            shouldMakeRequestAfterImages =false;
                            break;
                          }
                        }
                    }
                    if (shouldMakeRequest==true && shouldMakeRequestAfterImages==true) {
                      // Make the request here
                 await dio.post(
                  "http://nodejs.hackerkernel.com/colab/api/addCheckList",
                  data: formData,
                  options: Options(
                    followRedirects: false,
                    validateStatus: (status){
                      return status! < 500;
                    },
                    headers: {
                      "authorization": "Bearer ${token!}",
                      "Content-type": "application/json",
                    },
                  ),
                    );
                    EasyLoading.showToast("Closed successfully",toastPosition: EasyLoadingToastPosition.bottom);
                    // ignore: use_build_context_synchronously
                      await getNewQualityDataController.getCheckListData(context: context);
                      await getOpenedQualityDataController.getCheckListData(context: context);
                      await getClosedQualityDataController.getCheckListData(context: context);
                    // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    }
                    else if(shouldMakeRequest==false){
                        EasyLoading.showToast("Remark required",toastPosition: EasyLoadingToastPosition.bottom);
                    }
                    else if(shouldMakeRequestAfterImages==false){
                        EasyLoading.showToast("Image required",toastPosition: EasyLoadingToastPosition.bottom);
                    }
                  }
                  catch(e){
                    if (kDebugMode) {
                         EasyLoading.showToast("Error Occured",toastPosition: EasyLoadingToastPosition.bottom);
                      print(e);
                    }
                  }
          },
          child:const Text('Close',style: TextStyle(color: AppColors.black),),
        )
          )
      },
      if (toggleButton==false)...{
        Container(
          margin:const EdgeInsets.only(left: 20,right: 20),
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width/2.5,40),
              backgroundColor: AppColors.white),
               onPressed: () {
              // Handle button press
                   showDialog(
              useSafeArea: true,
              context: context,
              builder: (context1) {
                return 
                SingleChildScrollView(
                  child: 
                AlertDialog(
                  insetPadding: const EdgeInsets.only(left: 10,right: 10,top: 150,bottom: 150),
                  actionsPadding: const EdgeInsets.only(left: 10,right: 10),
                  contentPadding: const EdgeInsets.only(top: 10,),
                  title:
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  SizedBox(width: MediaQuery.of(context1).size.width/6,),
                  Text('Please Confirm',style:textStyleBodyText3.copyWith(fontSize: 26,fontWeight: FontWeight.normal),),
                  SizedBox(width: MediaQuery.of(context1).size.width/6,),
                ]),
                  shape: const RoundedRectangleBorder(
                  borderRadius:
              BorderRadius.all(
              Radius.circular(10.0))),
              content:Column(children: [
                CustomContainerBlackBorder(child: 
                Container(
                  height: 15,
                  decoration: BoxDecoration(
                     color: Colors.grey[250],
                  ),
                  margin: const EdgeInsets.only(top: 10,left: 10,bottom: 10),
                  child: 
                  TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 10,bottom: 10),
                    suffixIcon:IconButton(
                      color: AppColors.primary,
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.only(bottom:30),
                      icon: const Icon(Icons.edit_calendar,),
                      onPressed: () => (){},
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      ),
                      readOnly: true,
                      controller: dateInput,
                      onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                              primaryColor: AppColors.primary,
                              buttonTheme: const ButtonThemeData(
                              textTheme: ButtonTextTheme.primary),
                              colorScheme: const ColorScheme.light(primary:AppColors.primary,).copyWith(secondary: const Color(0xFF8CE7F1)),
                          ),
                     child: child!,
                    );
                     }, 
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100)
                  );
                if (pickedDate != null) {
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  setState(() {
                    dateInput.text =formattedDate;
                    dateInput2.text=pickedDate.toString();
                  });
                } else {}
              },
              style:const TextStyle(fontSize: 16,),
            )
                ),
                ),
            CustomContainerBlackBorder(
            child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("Remark",style: textStyleBodyText1,),
              ],
            ),
          ),
              const SizedBox(height: 10,),
              CustomTextField(controller: remarkController,enabled: true,hintText: "Type here",),
          ])
            ),
            const SizedBox(height: 20,),
                 Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomGradientContainer1(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100),),),
                    backgroundColor: Colors.white,disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12),shadowColor: Colors.transparent,
                  ),
                  onPressed: ()async{
                    setState(() {
                      Navigator.pop(context1);
                    });
                  },
                  child: const Center(
                    child: Text('CANCEL',style: TextStyle(fontSize: 16,color: AppColors.black,letterSpacing: -0.3858822937011719,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
             CustomGradientContainer2(child: 
             ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100)),),
                    backgroundColor: Colors.transparent,disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12),shadowColor: Colors.transparent,
                  ),
                  onPressed: ()async{
                     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                      var token=sharedPreferences.getString('token');
                      var userId=sharedPreferences.getString('id');
                      FormData formData=FormData(); 
                      var dio = Dio();
                      List checkDetails=[];
                      List uploadFiles=[];

                      if(sublists.isNotEmpty){
                          for(int i=0;i<combinedList.length;i++){
                        for(int j=0;j<combinedList[i].length;j++){
                          if(sublists[i][j]['image'].isNotEmpty && checkListID[i][j]['checkID']!='null'){
                            formData.files.add(
                              MapEntry("file${checkListID[i][j]['checkID'].toString()}", await MultipartFile.fromFile(sublists[i][j]['image'][0].toString().split(':')[1].replaceAll('\'', '').replaceAll('\'', '').trim(),filename: "sectionImage")
                            ));
                          }
                        }}
                      }
                      for(int i=0;i<combinedList.length;i++){
                        for(int j=0;j<combinedList[i].length;j++){
                           var map = {
                            "editId":int.parse(editID[i][j]["editID"].toString()),
                            "c_id":int.parse(checkListIDController.text.toString()),
                            "checklist_section_linking_id":int.parse(checkListID[i][j]['checkID'].toString()),
                            "section_name":sectionNames[i][j]['sectionName'].toString(),
                            "section_question":sectionQuestions[i][j]['sectionQuestions'].toString(),
                            "checkList_question_id":int.parse(checkListID[i][j]['checkID'].toString()),
                            "checklist_session_id":int.parse(checkListQuestionIDs[i][j]['cSID'].toString()),
                            "cm_status":null,//to be handled correctlt
                            "new_check_code":checkNewCode.text,
                            "status":null,
                            "checked_status":checkedStatus[i][j]['buttonValue']==true?1:null,
                            "line_comment_required":int.parse(commentRequired[i][j]['commentRequired'].toString()),
                            "image_required":int.parse(imageRequired[i][j]["imageRequired"].toString()),
                            "line_comment":lineComment[i][j]["remarks"].toString(),
                            "image":uploadedImageRequired[i][j]['uploaded'].toString(),
                          };
                          checkDetails.add(map);
                        }
                      }
                      formData.fields.add(MapEntry('addcheckListInfo', jsonEncode({
                      "checklist_id":"",
                      "checklist_session_id": "",
                      "line_comment":"",
                      "link_activity_id":int.parse(lineActivityIDController.text),
                      "image": "",
                      "debet_contactor": null,
                      // int.parse(debetContractor.text!='null'?debetContractor.text:"0").toString(),
                      "debit_amount": null,
                      "due_date": dateInput.text,
                      "status":"",
                      "check_new_code":checkNewCode.text,
                      'remarks':remarkController.text,
                      "closing_remark": closingRemarkController.text,
                      "user_id": userId.toString(),
                      "checkListDetails":checkDetails,
                   })
                   )
                   );
                     for(int i=0;i<combinedList.length;i++){
                        for(int j=0;j<combinedList[i].length;j++){
                           var map = {
                            "c_id":int.parse(checkListID[i][j]['checkID'].toString()),
                            "checklist_session_id":int.parse(checkListQuestionIDs[i][j]['cSID'].toString()),
                            "status":null,
                            "close_type":"Rescheduled",
                            "checked_status":checkedStatus[i][j]['buttonValue']==true?1:null,
                            "line_comment":lineComment[i][j]["remarks"].toString(),
                            "reject_count":0,
                            "checklist_section_linking_id":int.parse(checkListID[i][j]['checkID'].toString()),
                            "id":int.parse(editID[i][j]['editID']),//to be handled
                            "new_check_code":checkNewCode.text,
                            "image":uploadedImageRequired[i][j]['uploaded'].toString(),
                          };
                          uploadFiles.add(map);
                        }
                      }

                   formData.fields.add(MapEntry('uploadFiles', jsonEncode(uploadFiles)));
                   formData.fields.add(MapEntry('editId', jsonEncode(int.parse(editIDController.text))));
                   formData.fields.add(MapEntry('due_date', jsonEncode(dateInput.text)));
                   formData.fields.add(MapEntry('status', jsonEncode(0)));
                   formData.files.add(MapEntry("file", MultipartFile.fromString("", filename: "image_name")));
                   formData.files.add(MapEntry("check_image", MultipartFile.fromString("", filename: "image_name")));
                    if (kDebugMode) {}
                  try {
                      bool shouldMakeRequest = true;
                    bool shouldMakeRequestAfterImages = true;
                    for(int i=0;i<combinedList.length;i++){
                        for(int j=0;j<combinedList[i].length;j++){
                          if(int.parse(commentRequired[i][j]['commentRequired'].toString())==1 
                          && lineComment[i][j]["remarks"].isEmpty){
                            shouldMakeRequest =false;
                            break;
                          }
                        }
                    }
                     for(int i=0;i<combinedList.length;i++){
                        for(int j=0;j<combinedList[i].length;j++){
                          if(int.parse(imageRequired[i][j]["imageRequired"].toString())==1 
                          && sublists[i][j]['image'].isEmpty && uploadedImageRequired[i][j].isEmpty){
                            shouldMakeRequestAfterImages =false;
                            break;
                          }
                        }
                    }
                    if (shouldMakeRequest==true && shouldMakeRequestAfterImages==true && remarkController.text.isNotEmpty) {
                 await dio.post(
                  "http://nodejs.hackerkernel.com/colab/api/addCheckList",
                  data: formData,
                  options: Options(
                    followRedirects: false,
                    validateStatus: (status){
                      return status! < 500;
                    },
                    headers: {
                      "authorization": "Bearer ${token!}",
                      "Content-type": "application/json",
                    },
                  ),
                    );
                    EasyLoading.showToast("Rescheduled successfully",toastPosition: EasyLoadingToastPosition.bottom);
                    // ignore: use_build_context_synchronously
                      await getNewQualityDataController.getCheckListData(context: context);
                      await getOpenedQualityDataController.getCheckListData(context: context);
                      await getClosedQualityDataController.getCheckListData(context: context);
                    // ignore: use_build_context_synchronously
                      Navigator.pop(context1);
                    // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                  }
                    else if(shouldMakeRequest==false){
                        EasyLoading.showToast("Remark required",toastPosition: EasyLoadingToastPosition.bottom);
                    }
                    else if(shouldMakeRequestAfterImages==false){
                        EasyLoading.showToast("Image required",toastPosition: EasyLoadingToastPosition.bottom);
                    }
                    else if(remarkController.text.isEmpty){
                        EasyLoading.showToast("Remark required",toastPosition: EasyLoadingToastPosition.bottom);
                    }
                  }
                  catch(e){
                    if (kDebugMode) {
                      print(e);
                        EasyLoading.showToast("Error Occured",toastPosition: EasyLoadingToastPosition.bottom);
                    }
                  }
                  },
                  child: const Center(
                    child: Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xffffffff),
                        letterSpacing: -0.3858822937011719,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              ],
            ),
             const SizedBox(height: 20,),
                ],)
                )
              );
            }
          );
            },
            child:const Text('Reschedule',style: TextStyle(color: AppColors.black),),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width/2.5,40),
              backgroundColor: AppColors.secondary),
            onPressed: () {
              showDialog(
              useSafeArea: true,
              context: context,
              builder: (context1){
                return 
                SingleChildScrollView(
                  child: 
                AlertDialog(
                  insetPadding: const EdgeInsets.only(left: 10,right: 10,top: 150,bottom: 150),
                  actionsPadding: const EdgeInsets.only(left: 10,right: 10),
                  contentPadding: const EdgeInsets.only(top: 10,),
                  title:
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  SizedBox(width: MediaQuery.of(context1).size.width/6,),
                  Text('Please Confirm',style:textStyleBodyText3.copyWith(fontSize: 26,fontWeight: FontWeight.normal),),
                  SizedBox(width: MediaQuery.of(context1).size.width/6,),
                ]),
              shape: const RoundedRectangleBorder(
              borderRadius:
              BorderRadius.all(
              Radius.circular(10.0))),
              content:Column(children: [
                  CustomContainerBlackBorder(child: 
                  Column(children: [
                    Center(child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Text("DEBIT TO",style: textStyleBodyText1,),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                DropdownButtonFormField(
                  value: dropdownvalueDebitTo,
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
                 items: debitTo.map((String items){
                   return DropdownMenuItem(
                     value: items,
                     child: Text(items),
                   );
                 }).toList(),
                 onChanged: (String? newValue){
                   setState(() {
                     dropdownvalueDebitTo = newValue!;
                     debitToController.text=newValue;
                   });
                 },
               ),
              ])
            ),
            CustomContainerBlackBorder(
            child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("DEBIT AMOUNT",style: textStyleBodyText1,),
              ],),),
               const SizedBox(height: 10,),
               CustomTextFieldForNumber(controller: debitAmountController,enabled: true,hintText: "Enter Amount",),
              ])
            ),
            CustomContainerBlackBorder(
            child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("Closing Remark",style: textStyleBodyText1,),
              ],),),
               const SizedBox(height: 10,),
               CustomTextField(controller: closingRemarkController,enabled: true,hintText: "Type here",),
          ])
            ),
            const SizedBox(height: 20,),
                 Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomGradientContainer1(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100),),),
                    backgroundColor: Colors.white,disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12),shadowColor: Colors.transparent,
                  ),
                  onPressed: ()async{
                    setState(() {
                      Navigator.pop(context1);
                    });
                  },
                  child: const Center(
                    child: Text('CANCEL',style: TextStyle(fontSize: 16,color: AppColors.black,letterSpacing: -0.3858822937011719,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
             CustomGradientContainer2(child: 
             ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100)),),
                    backgroundColor: Colors.transparent,disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12),shadowColor: Colors.transparent,
                  ),
                  onPressed: ()async{
                      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                      var token=sharedPreferences.getString('token');
                      var userId=sharedPreferences.getString('id');
                      FormData formData=FormData(); 
                      var dio = Dio();
                      List checkDetails=[];
                      List uploadFiles=[];

                      if(sublists.isNotEmpty){
                          for(int i=0;i<combinedList.length;i++){
                        for(int j=0;j<combinedList[i].length;j++){
                          if(sublists[i][j]['image'].isNotEmpty && checkListID[i][j]['checkID']!='null'){
                            formData.files.add(
                              MapEntry("file${checkListID[i][j]['checkID'].toString()}", await MultipartFile.fromFile(sublists[i][j]['image'][0].toString().split(':')[1].replaceAll('\'', '').replaceAll('\'', '').trim(),filename: "sectionImage")
                            ));
                          }
                        }}
                      }
                      for(int i=0;i<combinedList.length;i++){
                        for(int j=0;j<combinedList[i].length;j++){
                           var map = {
                            "editId":int.parse(editID[i][j]["editID"].toString()),
                            "c_id":int.parse(checkListIDController.text.toString()),
                            "checklist_section_linking_id":int.parse(checkListID[i][j]['checkID'].toString()),
                            "section_name":sectionNames[i][j]['sectionName'].toString(),
                            "section_question":sectionQuestions[i][j]['sectionQuestions'].toString(),
                            "checkList_question_id":int.parse(checkListID[i][j]['checkID'].toString()),
                            "checklist_session_id":int.parse(checkListQuestionIDs[i][j]['cSID'].toString()),
                            "cm_status":null,//to be handled correctlt
                            "new_check_code":checkNewCode.text,
                            "status":null,
                            "checked_status":checkedStatus[i][j]['buttonValue']==true?1:null,
                            "line_comment_required":int.parse(commentRequired[i][j]['commentRequired'].toString()),
                            "image_required":int.parse(imageRequired[i][j]["imageRequired"].toString()),
                            "line_comment":lineComment[i][j]["remarks"].toString(),
                            "image":uploadedImageRequired[i][j]['uploaded'].toString(),
                          };
                          checkDetails.add(map);
                        }
                      }
                      formData.fields.add(MapEntry('addcheckListInfo', jsonEncode({
                      "checklist_id":"",
                      "checklist_session_id": "",
                      "line_comment":"",
                      "link_activity_id":int.parse(lineActivityIDController.text),
                      "image": "",
                      "debet_contactor": null,
                      // int.parse(debetContractor.text!='null'?debetContractor.text:"0").toString(),
                      "debit_amount": null,
                      "due_date": dateInput.text,
                      "status":"",
                      "check_new_code":checkNewCode.text,
                      'remarks':remarkController.text,
                      "closing_remark": closingRemarkController.text,
                      "user_id": userId.toString(),
                      "checkListDetails":checkDetails,
                   })
                   )
                   );
                     for(int i=0;i<combinedList.length;i++){
                        for(int j=0;j<combinedList[i].length;j++){
                           var map = {
                            "c_id":int.parse(checkListID[i][j]['checkID'].toString()),
                            "checklist_session_id":int.parse(checkListQuestionIDs[i][j]['cSID'].toString()),
                            "status":null,
                            "close_type":"Force-Closed",
                            "checked_status":checkedStatus[i][j]['buttonValue']==true?1:null,
                            "line_comment":lineComment[i][j]["remarks"].toString(),
                            "reject_count":0,
                            "checklist_section_linking_id":int.parse(checkListID[i][j]['checkID'].toString()),
                            "id":int.parse(editID[i][j]['editID']),//to be handled
                            "new_check_code":checkNewCode.text,
                            "image":uploadedImageRequired[i][j]['uploaded'].toString(),
                          };
                          uploadFiles.add(map);
                        }
                      }

                   formData.fields.add(MapEntry('uploadFiles', jsonEncode(uploadFiles)));
                   formData.fields.add(MapEntry('editId', jsonEncode(int.parse(editIDController.text))));
                   formData.fields.add(MapEntry('due_date', jsonEncode(dateInput.text)));
                   formData.fields.add(MapEntry('status', jsonEncode(1)));
                   formData.files.add(MapEntry("file", MultipartFile.fromString("", filename: "image_name")));
                   formData.files.add(MapEntry("check_image", MultipartFile.fromString("", filename: "image_name")));
                    if (kDebugMode) {}
                  try {
                      bool shouldMakeRequest = true;
                    bool shouldMakeRequestAfterImages = true;
                    for(int i=0;i<combinedList.length;i++){
                        for(int j=0;j<combinedList[i].length;j++){
                          if(int.parse(commentRequired[i][j]['commentRequired'].toString())==1 
                          && lineComment[i][j]["remarks"].isEmpty){
                            shouldMakeRequest =false;
                            break;
                          }
                        }
                    }
                     for(int i=0;i<combinedList.length;i++){
                        for(int j=0;j<combinedList[i].length;j++){
                          if(int.parse(imageRequired[i][j]["imageRequired"].toString())==1 
                          && sublists[i][j]['image'].isEmpty && uploadedImageRequired[i][j].isEmpty){
                            shouldMakeRequestAfterImages =false;
                            break;
                          }
                        }
                    }
                if (shouldMakeRequest==true && shouldMakeRequestAfterImages==true && closingRemarkController.text.isNotEmpty) {
                 await dio.post(
                  "http://nodejs.hackerkernel.com/colab/api/addCheckList",
                  data: formData,
                  options: Options(
                    followRedirects: false,
                    validateStatus: (status){
                      return status! < 500;
                    },
                    headers: {
                      "authorization": "Bearer ${token!}",
                      "Content-type": "application/json",
                    },
                  ),
                    );
                     EasyLoading.showToast("Force-Closed successfully",toastPosition: EasyLoadingToastPosition.bottom);
                    // ignore: use_build_context_synchronously
                      await getNewQualityDataController.getCheckListData(context: context);
                      await getOpenedQualityDataController.getCheckListData(context: context);
                      await getClosedQualityDataController.getCheckListData(context: context);
                    // ignore: use_build_context_synchronously
                      Navigator.pop(context1);
                    // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    }
                    else if(shouldMakeRequest==false){
                        EasyLoading.showToast("Remark required",toastPosition: EasyLoadingToastPosition.bottom);
                    }
                    else if(shouldMakeRequestAfterImages==false){
                        EasyLoading.showToast("Image required",toastPosition: EasyLoadingToastPosition.bottom);
                    }
                    else if(closingRemarkController.text.isEmpty){
                        EasyLoading.showToast("Closing remark required",toastPosition: EasyLoadingToastPosition.bottom);
                    }
                  }
                  catch(e){
                    if (kDebugMode) {
                      EasyLoading.showToast("Error Occured",toastPosition: EasyLoadingToastPosition.bottom);
                      print(e);
                    }
                  }
                  },
                  child: const Center(
                    child: Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xffffffff),
                        letterSpacing: -0.3858822937011719,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              ],
            ),
             const SizedBox(height: 20,),
                ],)
                )
              );
            }
          );
            },
            child:const Text('Force Close',style: TextStyle(color: AppColors.black),),
          )
          ])
        )}
            }
        ]
        )
      )
    );
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
