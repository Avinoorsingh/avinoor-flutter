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

// ignore: must_be_immutable
class SnagDetail2 extends StatefulWidget {
  SnagDetail2({Key? key, this.from, this.snagModel }) : super(key: key);

 // ignore: prefer_typing_uninitialized_variables
 final from;
 dynamic snagModel;
  @override
  State<SnagDetail2> createState() => _SnagState2();
}

class _SnagState2 extends State<SnagDetail2> {
  final getSnag = Get.find<GetNewSnag>();
  final getDeSnag=Get.find<GetNewDeSnag>();
  final getOpenedSnag = Get.find<GetOpenedSnag>();
  late String subV="";
  late String subSubV="";
  final categoryController=TextEditingController();
  final locationController = TextEditingController();
  final subLocationController = TextEditingController();
  final subSubLocationController = TextEditingController();
  final remarkController = TextEditingController();
  final deSnagRemarkController=TextEditingController();
  final closingRemarkController=TextEditingController();
  final rejectedRemarkController=TextEditingController();
  final markController=TextEditingController();
  final debitToController=TextEditingController();
  final debitAmountController=TextEditingController();
  final snagAssignedByController=TextEditingController();
  final snagAssignedToController=TextEditingController();
  final priorityController=TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController contractorInput = TextEditingController(text: "No Contractor");
  final location = ["Select Location", "Tower 1", "Tower 2", "Tower 3", "Tower 4"];
  String dropdownvalue = 'Select Location';  
  final location2 = ["Select Sub Location", "Tower 1", "Tower 2", "Tower 3", "Tower 4"];
  String dropdownvalue2 = 'Select Sub Location';  
  final location3 = ["Select Sub Sub Location", "Tower 1", "Tower 2", "Tower 3", "Tower 4"];
  String dropdownvalue3 = 'Select Sub Sub Location';  
  final debitTo = ["Select Debit to", "Person 1", "Person 2", "Person 3", "Person 4"];
  String dropdownvalueDebitTo = 'Select Debit to';  
  final assignedTo=["Select Name","Name 1"];
  String dropdownvalueAssignedTo="Select Name";
  final ValueNotifier<String?> dropDownNotifier = ValueNotifier(null);
   Map<int, List<dynamic>> newGroupedDeSnagImages = {};
   Map<int, List<dynamic>> newGroupedDeImages = {};
   List<String> imageData=[];
 
   List<bool> isCardEnabled = [];
   List<bool> isCardEnabled2 = [];
   List<String> deSnagImages=[];

   List<String> priority=[
    "Critical",
    "Major",
    "Minor",
   ];
  List viewpoints=[];
  List deSnagImage=[];
  List viewpointID=[];

  File? image;
  CroppedFile? croppedFile;
  var groupedViewpoints = {};
  var groupedViewpointsID = {};
  var groupedDeSnagImages = {};
  var groupedOnlyDeSnag={};
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      croppedFile = await ImageCropper().cropImage(
        sourcePath: image!.path,
        aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
    ],
    uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Edit Image',
          toolbarColor: AppColors.white,
          toolbarWidgetColor:AppColors.primary,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      IOSUiSettings(
        title: 'Edit Image',
      ),
      WebUiSettings(
        context: context,
      ),
    ],
  );
  var imageTemp = File(croppedFile!.path);
  setState(() => this.image = imageTemp);
      } catch(e) {
        if (kDebugMode) {
          print('Failed to pick image: $e');
        }
      }
  }
    late List<bool> isSelected;
    final creationController = TextEditingController();
    final dueDateController=TextEditingController();
     List viewpoints2=[];
     var array2=[];
    @override
  void initState() {
    super.initState(); 
    creationController.text=widget.snagModel?.createdAt??"";
    dueDateController.text=widget.snagModel?.dueDate??"";
    categoryController.text=widget.snagModel?.category?.name??"";
    locationController.text=widget.snagModel?.location.locationName??"";
    subLocationController.text=widget.snagModel?.subLocation.subLocationName??"";
    subSubLocationController.text=widget.snagModel?.subSubLocation.subSubLocationName??"";
    if(widget.snagModel?.contractorInfo!=null){
    contractorInput.text=widget.snagModel?.contractorInfo?.ownerName??"";
    }
    markController.text=widget.snagModel?.markupFile??"";
    remarkController.text=widget.snagModel?.remark??"";
    deSnagRemarkController.text=widget.snagModel?.deSnagRemark??"Not any Remark";
    debitToController.text="";
    debitAmountController.text=widget.snagModel?.debitAmount.toString()??"";
    snagAssignedByController.text=widget.snagModel?.createdBy1?.name??"";
    snagAssignedToController.text=widget.snagModel?.employee?.name??"";
    priorityController.text=widget.snagModel?.snagPriority;
    if(widget.snagModel?.snagViewpoint?.length!=0 && widget.snagModel?.snagViewpoint!=null){
      for(int i=0;i<widget.snagModel?.snagViewpoint?.length;i++){
        viewpoints.add({'fileName': widget.snagModel.snagViewpoint[i].viewpointFileName,'image':[],'id':widget.snagModel.snagViewpoint[i].viewpointId,'deSnagImage':[],'viewID':widget.snagModel.snagViewpoint[i].id});
        deSnagImage.add({'deSnagImage':widget.snagModel.snagViewpoint[i].desnagsFileName,'image':[],'id':widget.snagModel.snagViewpoint[i].viewpointId,});
        if(!viewpointID.contains(widget.snagModel.snagViewpoint[i].viewpointId)){
        viewpointID.add(widget.snagModel.snagViewpoint[i].id);
        deSnagImages.add(widget.snagModel.snagViewpoint[i].desnagsFileName);
        }
      }
    }

    for (var map in viewpoints) {
    // Check if the viewpoints is already in the map
    if (groupedViewpoints.containsKey(map['id'])) {
      // If it is, add the name to the list of names for that viewpoint
      groupedViewpoints[map['id']]?.add(map['fileName']);
    } else {
      // If it isn't, create a new list of names for that viewpoint and add the name
      groupedViewpoints[map['id']] = [map['fileName']];
    }
  }
   for (var map in viewpoints) {
    // Check if the viewpoints is already in the map
    if (groupedViewpointsID.containsKey(map['id'])) {
      // If it is, add the name to the list of names for that viewpoint
      groupedViewpointsID[map['id']]?.add(map['viewID']);
    } else {
      // If it isn't, create a new list of names for that viewpoint and add the name
      groupedViewpointsID[map['id']] = [map['viewID']];
    }
  }
   for (var map in deSnagImage) {
    // Check if the viewpoints is already in the map
    if (groupedDeSnagImages.containsKey(map['id'])) {
      // If it is, add the name to the list of names for that viewpoint
      groupedDeSnagImages[map['id']]?.add(map['deSnagImage']);
    } else {
      // If it isn't, create a new list of names for that viewpoint and add the name
      groupedDeSnagImages[map['id']] = [map['deSnagImage']];
    }
  }
  if(newGroupedDeImages.isEmpty){
 groupedDeSnagImages.forEach((key, value) {
    var newValue = value.map((list) => list!=null ? [] : list).toList();
    newGroupedDeSnagImages[key] = newValue;
    newGroupedDeImages[key]=newValue;
  });
  }

  groupedDeSnagImages.forEach((key, value) {
  groupedOnlyDeSnag[key] = List.filled(value.length, 'null');
});
  
  print("}}}}}}}}}}}}}}}}}}}}}}}}}}}}{{{{{{{{{{");
  print(viewpointID);
  print(groupedViewpointsID);
   print("}}}}}}}}}}}}}}}}}}}}}}}}}}}}{{{{{{{{{{");
  // print(deSnagImage);
  // print(newGroupedDeSnagImages);
    // print("I am here, here is the viewpoint");
    // print(groupedViewpoints);
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
 
   void clearCache()async{
    EasyLoading.show();
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.clear();
       // ignore: use_build_context_synchronously
       context.pushNamed('LOGINPAGE');
      }

  bool iconPressed=false;
  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor:AppColors.primary,
      title: Text("De-Snag",style: textStyleHeadline3.copyWith(color: Colors.black,fontWeight: FontWeight.w400),),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          CustomContainer(
            child: 
            Row(children: [
            Container(
              margin:const EdgeInsets.only(top: 5,bottom: 5),
              child: 
             Text("Snag Creation Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(creationController.text))}",style: textStyleBodyText1.copyWith(fontSize: 14),),
            ),
            ])
          ),
          CustomContainer(child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Center(child: Text(categoryController.text.isEmpty?"Category":categoryController.text,style: textStyleBodyText1.copyWith(fontSize: 14),),),
              const Icon(Icons.arrow_drop_down_outlined,size: 30,color: Colors.grey,)
            ])
          ),
            CustomContainer(child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Center(child: Text(locationController.text.isEmpty?"Location":locationController.text,style: textStyleBodyText1.copyWith(fontSize: 14),),),
             const Icon(Icons.arrow_drop_down_outlined,size: 30,color: Colors.grey,)
            ])
          ),
          CustomContainer(child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Center(child: Text(subLocationController.text.isEmpty?"Sub Location":subLocationController.text,style: textStyleBodyText1.copyWith(fontSize: 14),),),
            const Icon(Icons.arrow_drop_down_outlined,size: 30,color: Colors.grey,)
            ])
          ),
          CustomContainer(child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Center(child: Text(subSubLocationController.text.isEmpty?"Sub Sub Location":subSubLocationController.text,style: textStyleBodyText1.copyWith(fontSize: 14),),),
            const Icon(Icons.arrow_drop_down_outlined,size: 30,color: Colors.grey,)
            ])
          ),
          CustomContainer(child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin:const EdgeInsets.only(top: 5,bottom: 5),
                  child: 
            Center(child: Text(contractorInput.text.isEmpty?"Contractor":contractorInput.text,style: textStyleBodyText1.copyWith(fontSize: 14),),),
                ),
            ])
          ),
          if(markController.text.isNotEmpty)
          CustomContainer(child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Center(child: Text("Mark Location",style: textStyleBodyText1.copyWith(fontSize: 14),),),
            Center(child:  Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child:
            GestureDetector(
            onTap: () async {
              await showDialog(
                useSafeArea: true,
                context: context,
                builder: (_) => imageDialog('My Image',markController.text.isEmpty?"assets/images/user_fill.png":'http://nodejs.hackerkernel.com/colab${markController.text}', context));
              },
            child: 
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage("http://nodejs.hackerkernel.com/colab${markController.text}"),
                  fit: BoxFit.fill,
                  alignment: Alignment.topCenter,
                ),
              ),
          ),
            )
          ),
          ),
            const Divider(color: Colors.grey,), 
            if(groupedViewpoints.isNotEmpty)...{
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Center(child: Text("Viewpoints",style: textStyleBodyText1.copyWith(fontSize: 14,color: Colors.grey),),)
            ]),
          ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 10,bottom: 10),
          shrinkWrap: true,
          itemCount: groupedViewpoints.keys.length,
          itemBuilder: (BuildContext context, int outerIndex) {
             var outerKey = groupedViewpoints.keys.toList()[outerIndex];
            return Column(
              children: [
                const SizedBox(height: 20,),
                Row(children: [
                  Text("VIEWPOINT:  View ${outerIndex+1}",style: textStyleBodyText1.copyWith(fontSize: 14),)
                ],),
                const SizedBox(height: 10,),
                  Container(
                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                    boxShadow:  [
                      BoxShadow(color:Colors.grey[300]!, spreadRadius: 1),
                    ],
                  ),
                    child:
                    Column(
                      children: [
                          Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                        Center(child: Text("Snag Image", style: textStyleBodyText1.copyWith(fontSize: 16,color: Colors.grey),),),
                        const SizedBox(width: 10,),
                        Center(child: Text("De-Snag Image", style: textStyleBodyText1.copyWith(fontSize: 16, color:Colors.grey),),),
                  ],),
                  const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 130,
                        child:
                        ListView.builder(
                        physics:const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                          itemCount: groupedViewpoints[outerKey]?.length,
                          itemBuilder: (context, innerIndex) {
                            return
                        GestureDetector(
                      onTap: () async {
                        await showDialog(
                          useSafeArea: true,
                          context: context,
                          builder: (_) => imageDialog('Snag Image','https://nodejs.hackerkernel.com/colab${groupedViewpoints[outerKey][innerIndex]}' , context));
                        },
                      child: 
                      Container(
                        margin:const EdgeInsets.only(top: 10,bottom: 10),
                        height: 100,
                        width: 30,
                        child:
                        FittedBox(
                          fit: BoxFit.fill,
                          child: Image.network("https://nodejs.hackerkernel.com/colab${groupedViewpoints[outerKey][innerIndex]}", 
                        height: 10,
                        width: 30,),),
                      ));
                          }
                         )
                      )
                    ],
                  ),
                  VerticalDivider(color:Colors.grey[500],thickness: 10,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       SizedBox(
                        width: MediaQuery.of(context).size.width/2.5,
                        child:
                    ListView.builder(
                      physics:const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                       itemCount: groupedDeSnagImages[outerKey]?.length,
                       itemBuilder: (context, innerIndex) {
                       return
                       widget.from=='desnagnew'?
                       GestureDetector(
                      onTap: () async {},
                      child: 
                      Row(
                mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                if(groupedDeSnagImages[outerKey]![innerIndex]!=null && groupedOnlyDeSnag[outerKey]![innerIndex]=='null')...{
                  SizedBox(
                   height: 100,
                   child:
                  InkWell(
                      onTap: () {
                        return;
                      },
                        child:
                        Container(
                        margin:const EdgeInsets.only(top: 10,bottom: 10),
                        height: 100,
                        width: 50,
                        child:
                          Image.network("https://nodejs.hackerkernel.com/colab${groupedDeSnagImages[outerKey][innerIndex]}",
                          height: 10,
                          width: 30,
                      ),),
                      )
                    ),
                },
                if(groupedOnlyDeSnag[outerKey]![innerIndex]!='null')...{
                  SizedBox(
                   height: 100,
                   child:
                  InkWell(
                      onTap: () {
                        return;
                      },
                          child:
                           Container(
                            margin: const EdgeInsets.only(top:10,bottom: 10,),
                            height: 100,
                            width: 50,
                            decoration:groupedOnlyDeSnag[outerKey]![innerIndex]!='null'? BoxDecoration(
                              color: Colors.grey[300],
                              image:groupedOnlyDeSnag[outerKey]![innerIndex]!='null'?DecorationImage(
                                image:FileImage(File(groupedOnlyDeSnag[outerKey]![innerIndex].split(":")[1].trim().replaceAll("'", "")?? "")),
                              fit: BoxFit.fill,
                              ):null,
                            ):null,
                          )
                      )
                    ),
                },
                Container(
                height: 35,
                margin: const EdgeInsets.only(top:15,bottom: 15,left:5,right: 10),
                width: MediaQuery.of(context).size.width/4.5,
                decoration: widget.from=='desnagnew'? BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: const LinearGradient(
                    begin: Alignment(-0.95, 0.0),
                    end: Alignment(1.0, 0.0),
                    colors: [Color.fromARGB(173, 57, 54, 54),Color.fromARGB(250, 19, 14, 14)],
                    stops: [0.0, 1.0],
                  ),
                ):null,
                child: widget.from=='desnagnew'?
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100)),),
                    backgroundColor: Colors.transparent,
                      disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
                      shadowColor: Colors.transparent,
                  ),
                  onPressed: () async {
                      final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
                      final File imagefile = File(image!.path);
                      groupedOnlyDeSnag[outerKey][innerIndex]=imagefile.toString();
                        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                        var token=sharedPreferences.getString('token'); 
                        FormData formData=FormData(); 
                        var dio = Dio();
                        formData.fields.add(MapEntry('viewpoint_id', groupedViewpointsID[outerKey][innerIndex].toString()));
                        formData.files.add(
                        MapEntry("de_snag_image", await MultipartFile.fromFile(groupedOnlyDeSnag[outerKey][innerIndex].split(":")[1].trim().replaceAll("'", ""), filename: 'de_snag_image')));
                        var res= await dio.post("http://nodejs.hackerkernel.com/colab/api/de_snags_image",
                        data:formData,
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
                        setState(() { });
                        if (kDebugMode) {
                          print(res);
                        }
                  },
                  child: const Center(
                    child: Text(
                      'Upload Image',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xffffffff),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ): SizedBox(
                      height: 100,
                      width: 10,
                      child: Image.network("https://nodejs.hackerkernel.com/colab${groupedDeSnagImages[outerKey][innerIndex]}"),
                    ),
              ),
                  ]
                ),
              ):Container();
                  }))],
                    ),
                  ]
                )
              ]
            )
                  // ),
                ),
              ],
            );
          }),
            }
            ])
            ),
            const SizedBox(height: 10,),
            CustomContainer2(
            child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("REMARK",style: textStyleBodyText1.copyWith(fontSize: 14),),
              ],),),
               const SizedBox(height: 10,),
               CustomTextFieldGrey(enabled: false,controller: remarkController,)
          ])
            ),
            if(widget.from!="new")...{
            if(widget.from!="desnagnew")...{
            const SizedBox(height: 10,),
             CustomContainer2(child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("DE-SNAG REMARK", style: textStyleBodyText1.copyWith(fontSize: 14),),
              ],),),
               const SizedBox(height: 10,),
               CustomTextFieldGrey(enabled: false,controller: deSnagRemarkController,)
          ])
            ),
            },
            },
            const SizedBox(height: 10,),
            CustomContainer2(child:
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("DEBIT TO",
                style: textStyleBodyText1.copyWith(fontSize: 14),),
              ],),),
                CustomContainer(child:
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Center(child: Text("Select debit to", textAlign: TextAlign.center,style: textStyleBodyText1.copyWith(fontSize: 14),),),
              const Icon(Icons.arrow_drop_down_outlined, size: 30,color: Colors.grey,),
              ]))
          ])
            ),
            const SizedBox(height: 10,),
             CustomContainer(
            child: 
            Row(children: [
            Container(
              margin:const EdgeInsets.only(top: 5,bottom: 5),
              child: 
             Text("Due Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(dueDateController.text))}",style: textStyleBodyText1.copyWith(fontSize: 14),),
            ),
            ])
          ),
           const SizedBox(height: 10,),
            CustomContainer2(child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("DEBIT AMOUNT", style: textStyleBodyText1.copyWith(fontSize: 14),),
              ],),),
               const SizedBox(height: 10,),
              CustomTextFieldGrey(enabled: false, controller: debitAmountController,)
          ])
            ),
            if(widget.from=='openedSnag')...{
            const SizedBox(height: 10,),   
            CustomContainer2(child:
            Column(
              children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("Snag Priority",style: textStyleBodyText1.copyWith(fontSize: 14),),
              ],),),
               const SizedBox(height: 10,),
          SizedBox(
          height: 75,child: 
          ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(top: 15,bottom: 15,left: 0,right: 0),
          itemCount: 3,
          itemBuilder: (BuildContext context, int index){
            isCardEnabled2.add(false);
            return GestureDetector(
                onTap: (){},
                child: SizedBox(
                  height: 10,
                  width: 100,
                  child: Container(
                   decoration: BoxDecoration(
                     color: priority[index].toString().substring(0,2).toUpperCase()==priorityController.text? AppColors.primary:AppColors.white,
                     border: Border.all(width: 1.2,color: AppColors.primary,),
                    ),
                    child: Center(
                      child: Text(priority[index],textAlign: TextAlign.center,
                        style: TextStyle(
                          color: priority[index].toString().substring(0,2).toUpperCase()==priorityController.text?Colors.black:AppColors.primary,
                          fontSize: 16
                        ),
                      ),
                    ),
                  ),
                )
            );
          }),
          ),
          ]),
            ),
           },
             const SizedBox(height: 10,),
            CustomContainer2(child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("SNAG ASSIGNED BY",style: textStyleBodyText1.copyWith(fontSize: 14),),
              ],),),
               const SizedBox(height: 10,),
               CustomContainer(child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                Center(child: Text(snagAssignedByController.text, style: textStyleBodyText1.copyWith(fontSize: 14),),),
                const Icon(Icons.arrow_drop_down_outlined, size: 30,color: Colors.grey,)
                ])
              ),
          ])
            ),
              const SizedBox(height: 10,),
            CustomContainer2(
              child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("SNAG ASSIGNED TO", style: textStyleBodyText1.copyWith(fontSize: 14),),
              ],),),
               const SizedBox(height: 10,),
              CustomContainer(child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Center(child: Text(snagAssignedToController.text,style: textStyleBodyText1.copyWith(fontSize: 14),),),
              const Icon(Icons.arrow_drop_down_outlined,size: 30,color: Colors.grey,),
              ])
            ),
          ])
            ),
            if(widget.from!='openedSnag')...{
            const SizedBox(height: 10,),
           CustomContainer2(child: 
            Column(
              children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("Snag Priority", style: textStyleBodyText1.copyWith(fontSize: 14),),
              ],),),
               const SizedBox(height: 10,),
           SizedBox(
            height: 75,
            child: 
          ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(top: 15,bottom: 15,left: 0,right: 0),
          itemCount: 3,
          itemBuilder: (BuildContext context, int index){
            isCardEnabled2.add(false);
            return GestureDetector(
                onTap: (){
                },
                child: SizedBox(
                  height: 10,
                  width: MediaQuery.of(context).size.width/3.8,
                  child: Container(
                   decoration: BoxDecoration(
                     color: priority[index].toString().substring(0,2).toUpperCase()==priorityController.text? AppColors.primary:AppColors.white,
                     border: Border.all(width: 1.2,color: AppColors.primary,),
                    ),
                    child: Center(
                      child: Text(priority[index],textAlign: TextAlign.center,
                        style: TextStyle(
                          color: priority[index].toString().substring(0,2).toUpperCase()==priorityController.text?AppColors.white:AppColors.primary,
                          fontSize: 16
                        ),
                      ),
                    ),
                  ),
                )
            );
          }),
          ),
          ]),
            ),
            },
            if(widget.from=="desnagnew")...{
              const SizedBox(height: 10,),
                 CustomContainer2(child:
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("DE-SNAG REMARK", style: textStyleBodyText1.copyWith(fontSize: 14),),
              ],),),
            const SizedBox(height: 10,),
            CustomTextFieldGrey(enabled: true,controller: deSnagRemarkController,)
          ])
            ),
            Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left:20.0,right: 20.0,bottom: 20.0),
            padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
            child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                ElevatedButton(onPressed: (){
                Navigator.pop(context);
              }, 
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(150,40),
                backgroundColor: AppColors.white
              ),
              child: const Text("Cancel",style: TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.normal,),)),
                ElevatedButton(onPressed: ()
                async {
                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                var token=sharedPreferences.getString('token');
                var createdById=sharedPreferences.getString('id');
                if(deSnagRemarkController.text.isNotEmpty && deSnagRemarkController.text!="Not any Remark"){
                  try {
                    await http.post(
                    Uri.parse("http://nodejs.hackerkernel.com/colab/api/snags_status_change"),
                     headers: {
                              "Accept": "application/json",
                              "Authorization": "Bearer $token",
                            },
                      body: {
                      'id':widget.snagModel.id.toString(),
                      "client_id":widget.snagModel.clientId.toString(),
                      "project_id":widget.snagModel.projectId.toString(),
                      "category_id": widget.snagModel.categoryId.toString(),
                      "location_id": widget.snagModel.locationId.toString(),
                      "sub_loc_id":widget.snagModel.subLocId.toString(),
                      "sub_sub_loc_id": widget.snagModel.subSubLocId.toString(),
                      "activity_head_id": widget.snagModel.activityHeadId.toString(),
                      "activity_id":widget.snagModel.activityId.toString(),
                      "contractor_id": widget.snagModel.contractorId.toString(), 
                      "remark": widget.snagModel.remark.toString(),
                      "debit_note":widget.snagModel.debitNote.toString(),
                      "debit_amount":widget.snagModel.debitAmount.toString(),
                      "due_date": widget.snagModel.dueDate.toString(),
                      "assigned_to": widget.snagModel.assignedTo.toString(),
                      "created_by": createdById,
                      "de_snag_remark":deSnagRemarkController.text,
                      "snag_status": widget.from=="desnagnew"?"O":"N",
                      }
                    );
                    EasyLoading.showToast("Sent for review",toastPosition: EasyLoadingToastPosition.bottom); 
                    await getDeSnag.getSnagData(context: context);
                    Get.put(GetNewDeSnag()); 
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);               
                    } catch (e) {
                      EasyLoading.showToast("server error occured",toastPosition: EasyLoadingToastPosition.bottom);
                      EasyLoading.dismiss();
                     if (kDebugMode) {
                       print(e);
                     } 
                    }
                }
                else{
                  EasyLoading.showToast("De-Snag remark cannot be empty",toastPosition: EasyLoadingToastPosition.bottom);
                }
                },
                style: ElevatedButton.styleFrom(
                minimumSize: const Size(150,40),
                backgroundColor: const Color.fromARGB(255, 91, 235, 96)
              ), 
                child: const Text("Send For Review",style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: AppColors.black),),
                )
              ],)
                )
            },
               if(widget.from=="openedSnag")...{
                  Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left:20.0,right: 20.0,),
            padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
            child: FittedBox(child:
            Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async{
                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  var token=sharedPreferences.getString('token');
                  var createdById=sharedPreferences.getString('id');
                   showDialog(
    context: context,
    builder: (BuildContext context1) {
      return 
      Container(
        decoration:const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
         width: MediaQuery.of(context1).size.width/1,
        child:
      AlertDialog(
        elevation: 2,
        title: Text('Snag',textAlign: TextAlign.center,style: textStyleBodyText1.copyWith(fontSize: 14).copyWith(fontSize: 20,color: Colors.grey),),
        content:
        SizedBox(width: MediaQuery.of(context1).size.width/1,child:
            TextField(
              enabled: true,
              controller: closingRemarkController,
              textAlign: TextAlign.center,
               decoration: InputDecoration(
                filled: true,
                hintText: "Type remark here",
                fillColor: Colors.grey[200],
                hintStyle:const TextStyle(color: Colors.grey,),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color:Colors.grey[500]!), //<-- SEE HERE
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color:Colors.grey[500]!), //<-- SEE HERE
                ),
                errorBorder: InputBorder.none,
                disabledBorder:OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                      width: 1, color:Colors.grey[300]!), //<-- SEE HERE
                ),),
               maxLines: 1,
              style: textStyleHeadline2.copyWith(fontWeight: FontWeight.w400,fontSize: 16,),
            ),
        ),
        actions: <Widget>[
                  Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context1).size.width/3,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100)),),
                    backgroundColor: Colors.transparent,
                      disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
                      shadowColor: Colors.transparent,
                  ),
                  onPressed: ()async{
                   closingRemarkController.text="";
                   Navigator.pop(context1);
                  },
                  child: const Center(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        letterSpacing: -0.3858822937011719,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context1).size.width/3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: const LinearGradient(
                    begin: Alignment(-0.95, 0.0),
                    end: Alignment(1.0, 0.0),
                    colors: [Color.fromARGB(174, 218, 108, 108),Color.fromARGB(251, 236, 85, 85)],
                    stops: [0.0, 1.0],
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100)),),
                    backgroundColor: Colors.transparent,
                      disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
                      shadowColor: Colors.transparent,
                  ),
                  onPressed: ()async{
                    if(closingRemarkController.text.isNotEmpty){
                      try {
                     var res=await http.post(
                    Uri.parse("http://nodejs.hackerkernel.com/colab/api/snags_status_change"),
                     headers: {
                              "Accept": "application/json",
                              "Authorization": "Bearer $token",
                            },
                      body: {
                      'id':widget.snagModel.id.toString(),
                      "client_id":widget.snagModel.clientId.toString(),
                      "project_id":widget.snagModel.projectId.toString(),
                      "category_id": widget.snagModel.categoryId.toString(),
                      "location_id": widget.snagModel.locationId.toString(),
                      "sub_loc_id":widget.snagModel.subLocId.toString(),
                      "sub_sub_loc_id": widget.snagModel.subSubLocId.toString(),
                      "activity_head_id": widget.snagModel.activityHeadId.toString(),
                      "activity_id":widget.snagModel.activityId.toString(),
                      "contractor_id": widget.snagModel.contractorId.toString(), 
                      "remark": widget.snagModel.remark.toString(),
                      "debit_note":widget.snagModel.debitNote.toString(),
                      "debit_amount":widget.snagModel.debitAmount.toString(),
                      "due_date": widget.snagModel.dueDate.toString(),
                      "assigned_to": widget.snagModel.assignedTo.toString(),
                      "created_by": createdById,
                      "close_snag_remark":closingRemarkController.text,
                      "de_snag_remark":deSnagRemarkController.text,
                      "snag_status": "CWD",
                            }
                          );
                    if (kDebugMode) {
                      print(res.statusCode);
                    }
                    EasyLoading.showToast("Closed with debit",toastPosition: EasyLoadingToastPosition.bottom); 
                    await getOpenedSnag.getOpenedSnagData(context: context);
                    Get.put(GetOpenedSnag()); 
                         // ignore: use_build_context_synchronously
                    Navigator.of(context1, rootNavigator: true).pop();
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);           
                    } catch (e) {
                      EasyLoading.showToast("server error occured",toastPosition: EasyLoadingToastPosition.bottom);
                      EasyLoading.dismiss();
                     if (kDebugMode) {
                       print(e);
                     } 
                    }
                    }
                    else{
                       EasyLoading.showToast("Closing remark is required",toastPosition: EasyLoadingToastPosition.bottom);
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
            )
        ],
      )
      );
    },
  );
              }, 
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width/2,60),
                backgroundColor: AppColors.white
              ),
              child: const Text("Close with debit",style: TextStyle(color: Colors.black),)),
              const SizedBox(width: 20,),
              //------------------------------------------------------------------
               ElevatedButton(onPressed: ()async{
                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  var token=sharedPreferences.getString('token');
                  var createdById=sharedPreferences.getString('id');
                   showDialog(
    context: context,
    builder: (BuildContext context1) {
      return 
      Container(
        decoration:const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
         width: MediaQuery.of(context1).size.width/1,
        child:
      AlertDialog(
        elevation: 2,
        title: Text('Snag',textAlign: TextAlign.center,style: textStyleBodyText1.copyWith(fontSize: 14).copyWith(fontSize: 20,color: Colors.grey),),
        content:
        SizedBox(width: MediaQuery.of(context1).size.width/1,child:
            TextField(
              enabled: true,
              controller: closingRemarkController,
              textAlign: TextAlign.center,
               decoration: InputDecoration(
                filled: true,
                hintText: "Type remark here",
                fillColor: Colors.grey[200],
                hintStyle:const TextStyle(color: Colors.grey,),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color:Colors.grey[500]!), //<-- SEE HERE
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color:Colors.grey[500]!), //<-- SEE HERE
                ),
                errorBorder: InputBorder.none,
                disabledBorder:OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                      width: 1, color:Colors.grey[300]!), //<-- SEE HERE
                ),),
               maxLines: 1,
              style: textStyleHeadline2.copyWith(fontWeight: FontWeight.w400,fontSize: 16,),
            ),
        ),
        actions: <Widget>[
                  Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context1).size.width/3,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100)),),
                    backgroundColor: Colors.transparent,
                      disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
                      shadowColor: Colors.transparent,
                  ),
                  onPressed: ()async{
                   closingRemarkController.text="";
                   Navigator.pop(context1);
                  },
                  child: const Center(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        letterSpacing: -0.3858822937011719,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context1).size.width/3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: const LinearGradient(
                    begin: Alignment(-0.95, 0.0),
                    end: Alignment(1.0, 0.0),
                    colors: [Color.fromARGB(174, 218, 108, 108),Color.fromARGB(251, 236, 85, 85)],
                    stops: [0.0, 1.0],
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100)),),
                    backgroundColor: Colors.transparent,
                      disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
                      shadowColor: Colors.transparent,
                  ),
                  onPressed: ()async{
                    if(closingRemarkController.text.isNotEmpty){
                      try {
                     var res=await http.post(
                    Uri.parse("http://nodejs.hackerkernel.com/colab/api/snags_status_change"),
                     headers: {
                              "Accept": "application/json",
                              "Authorization": "Bearer $token",
                            },
                      body: {
                      'id':widget.snagModel.id.toString(),
                      "client_id":widget.snagModel.clientId.toString(),
                      "project_id":widget.snagModel.projectId.toString(),
                      "category_id": widget.snagModel.categoryId.toString(),
                      "location_id": widget.snagModel.locationId.toString(),
                      "sub_loc_id":widget.snagModel.subLocId.toString(),
                      "sub_sub_loc_id": widget.snagModel.subSubLocId.toString(),
                      "activity_head_id": widget.snagModel.activityHeadId.toString(),
                      "activity_id":widget.snagModel.activityId.toString(),
                      "contractor_id": widget.snagModel.contractorId.toString(), 
                      "remark": widget.snagModel.remark.toString(),
                      "debit_note":widget.snagModel.debitNote.toString(),
                      "debit_amount":widget.snagModel.debitAmount.toString(),
                      "due_date": widget.snagModel.dueDate.toString(),
                      "assigned_to": widget.snagModel.assignedTo.toString(),
                      "created_by": createdById,
                      "close_snag_remark":closingRemarkController.text,
                      "de_snag_remark":deSnagRemarkController.text,
                      "snag_status": "C",
                            }
                          );
                    if (kDebugMode) {
                      print(res.statusCode);
                    }
                    EasyLoading.showToast("Closed without debit",toastPosition: EasyLoadingToastPosition.bottom); 
                    await getOpenedSnag.getOpenedSnagData(context: context);
                    Get.put(GetOpenedSnag()); 
                         // ignore: use_build_context_synchronously
                    Navigator.of(context1, rootNavigator: true).pop();
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);           
                    } catch (e) {
                      EasyLoading.showToast("server error occured",toastPosition: EasyLoadingToastPosition.bottom);
                      EasyLoading.dismiss();
                     if (kDebugMode) {
                       print(e);
                     } 
                    }
                    }
                    else{
                       EasyLoading.showToast("Closing remark is required",toastPosition: EasyLoadingToastPosition.bottom);
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
            )
        ],
      )
      );
    },
  );
              }, 
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width/2,60),
                backgroundColor: AppColors.white
              ),
              child: const Text("Close without debit",style: TextStyle(color: Colors.black),)),
              ],),
                const SizedBox(height: 10,),
                //--------------------------------------------------------------
                  ElevatedButton(onPressed: ()async{
                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  var token=sharedPreferences.getString('token');
                  var createdById=sharedPreferences.getString('id');
                   showDialog(
    context: context,
    builder: (BuildContext context1) {
      return 
      Container(
        decoration:const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
         width: MediaQuery.of(context1).size.width/1,
        child:
      AlertDialog(
        elevation: 2,
        title: Text('Snag',textAlign: TextAlign.center,style: textStyleBodyText1.copyWith(fontSize: 14).copyWith(fontSize: 20,color: Colors.grey),),
        content:
        SizedBox(width: MediaQuery.of(context1).size.width/1,child:
            TextField(
              enabled: true,
              controller: rejectedRemarkController,
              textAlign: TextAlign.center,
               decoration: InputDecoration(
                filled: true,
                hintText: "Type remark here",
                fillColor: Colors.grey[200],
                hintStyle:const TextStyle(color: Colors.grey,),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color:Colors.grey[500]!), //<-- SEE HERE
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color:Colors.grey[500]!), //<-- SEE HERE
                ),
                errorBorder: InputBorder.none,
                disabledBorder:OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                      width: 1, color:Colors.grey[300]!), //<-- SEE HERE
                ),),
               maxLines: 1,
              style: textStyleHeadline2.copyWith(fontWeight: FontWeight.w400,fontSize: 16,),
            ),
        ),
        actions: <Widget>[
                  Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context1).size.width/3,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100)),),
                    backgroundColor: Colors.transparent,
                      disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
                      shadowColor: Colors.transparent,
                  ),
                  onPressed: ()async{
                   rejectedRemarkController.text="";
                   Navigator.pop(context1);
                  },
                  child: const Center(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        letterSpacing: -0.3858822937011719,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context1).size.width/3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: const LinearGradient(
                    begin: Alignment(-0.95, 0.0),
                    end: Alignment(1.0, 0.0),
                    colors: [Color.fromARGB(174, 218, 108, 108),Color.fromARGB(251, 236, 85, 85)],
                    stops: [0.0, 1.0],
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100)),),
                    backgroundColor: Colors.transparent,
                      disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
                      shadowColor: Colors.transparent,
                  ),
                  onPressed: ()async{
                    if(rejectedRemarkController.text.isNotEmpty){
                      try {
                     var res=await http.post(
                    Uri.parse("http://nodejs.hackerkernel.com/colab/api/snags_status_change"),
                     headers: {
                              "Accept": "application/json",
                              "Authorization": "Bearer $token",
                            },
                      body: {
                      'id':widget.snagModel.id.toString(),
                      "client_id":widget.snagModel.clientId.toString(),
                      "project_id":widget.snagModel.projectId.toString(),
                      "category_id": widget.snagModel.categoryId.toString(),
                      "location_id": widget.snagModel.locationId.toString(),
                      "sub_loc_id":widget.snagModel.subLocId.toString(),
                      "sub_sub_loc_id": widget.snagModel.subSubLocId.toString(),
                      "activity_head_id": widget.snagModel.activityHeadId.toString(),
                      "activity_id":widget.snagModel.activityId.toString(),
                      "contractor_id": widget.snagModel.contractorId.toString(), 
                      "remark": rejectedRemarkController.text.toString(),
                      "debit_note":widget.snagModel.debitNote.toString(),
                      "debit_amount":widget.snagModel.debitAmount.toString(),
                      "due_date": widget.snagModel.dueDate.toString(),
                      "assigned_to": widget.snagModel.assignedTo.toString(),
                      "created_by": createdById,
                      "de_snag_remark":deSnagRemarkController.text,
                      "snag_status": "N",
                            }
                            );
                    if (kDebugMode) {
                      print(res.statusCode);
                    }
                    EasyLoading.showToast("Rejected",toastPosition: EasyLoadingToastPosition.bottom);   
                    // ignore: use_build_context_synchronously
                    await getOpenedSnag.getOpenedSnagData(context: context);
                    Get.put(GetOpenedSnag()); 
                         // ignore: use_build_context_synchronously
                    Navigator.of(context1, rootNavigator: true).pop();
                      // ignore: use_build_context_synchronously
                    Navigator.pop(context);       
                    } catch (e) {
                      EasyLoading.showToast("server error occured",toastPosition: EasyLoadingToastPosition.bottom);
                      EasyLoading.dismiss();
                     if (kDebugMode) {
                       print(e);
                     } 
                    }
                    }
                    else{
                       EasyLoading.showToast("Closing remark is required",toastPosition: EasyLoadingToastPosition.bottom);
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
                  )
              ],
            )
            );
          },);},
                style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width+20,60),
                backgroundColor:const Color.fromARGB(255, 245, 79, 134)
              ), 
                child: const Text("Reject",style: TextStyle(color: Colors.black),),
                )
              ]
            )
            )
          )
        }
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
