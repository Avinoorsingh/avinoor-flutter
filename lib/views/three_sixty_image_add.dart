import 'dart:convert';
import 'dart:io';
import 'package:colab/views/activity_head.dart';
import 'package:http/http.dart' as http;
import 'package:colab/constants/colors.dart';
import 'package:colab/network/area_of_concern_network.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';
import '../controller/signInController.dart';
import '../models/activity_head.dart';
import '../models/location_list.dart';
import '../models/sub_location_list.dart';
import '../theme/text_styles.dart';
import 'sub_location.dart';

class AddThreeSixtyImage extends StatefulWidget {
  const AddThreeSixtyImage({Key? key,}) : super(key: key);

  @override
  State<AddThreeSixtyImage> createState() => _ThreeSixtyImageState();
}

bool show=false;
// ignore: prefer_typing_uninitialized_variables
late var tapped;

class _ThreeSixtyImageState extends State<AddThreeSixtyImage> {
  final getAreaOfConcern = Get.find<GetAreaOfConcern>();
  List<String?> locationName=[];
  List<String?> activity=[];
  List<String?> activityHead=[];
  List<String?> date=[];
  List<String?> description=[];
  List<String?> status=[];
  List areaData=[];
  List dateDifference=[];
  List<String> locationList=[];
  final categoryController=TextEditingController();
  final locationController = TextEditingController();
  final subLocationController = TextEditingController();
  final subSubLocationController = TextEditingController();
  final locationId=TextEditingController();
  final subSubLocationId = TextEditingController();
  final subLocationId = TextEditingController();
  final projectId=TextEditingController();
  final clientId = TextEditingController();
  final categoryIDController=TextEditingController();
  // ignore: non_constant_identifier_names
  final linking_activity_id=TextEditingController();
  final remarkController = TextEditingController();
  final debitToController=TextEditingController();
  final debitAmountController=TextEditingController();
  final snapAssignedToController=TextEditingController();
  final priorityController=TextEditingController();
  late String subV="";
  late String subSubV="";
  String dropdownvalue = 'Select Location';  
  String dropdownvalue2 = 'Select Sub Location';  
  final signInController=Get.find<SignInController>();
  final List<String> _imagePaths = ["add","add"];
 
 @override
 void initState(){
  super.initState();
  getAreaOfConcern.getAreaOfConcernData(context: context);
 }

  @override
  Widget build(BuildContext context) {
     if(signInController.getLocationList!.data!.isNotEmpty && locationList.isEmpty){
        List<LocationData>? locationList1=signInController.getLocationList?.data;
        locationList.add("Select Location");
        for(var data in locationList1!){
          locationList.add(data.locationName!);
        }
      }
    EasyLoading.dismiss();
    return 
    Scaffold(
    appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor:AppColors.primary,
      title: Text("Add 360 Images",style: textStyleHeadline3.copyWith(color: Colors.black,fontWeight: FontWeight.w400),),
      ),
    body: 
    Container(margin: const EdgeInsets.only(top: 0),
    child:
    Column(
      children: [
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width,color: Colors.black38,
          padding: const EdgeInsets.only(top: 20),
          child:Text('Tower 1/Gr Floor/ U1',style: textStyleBodyText1.copyWith(fontSize: 18), textAlign: TextAlign.center,),),
          Padding(padding: const EdgeInsets.only(left: 10,right: 10,),
            child:
            Column(
              children: [
                const SizedBox(height: 20,),
                Card(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 150,
                        width: 250,
                        child: FittedBox(child:
                      Image.network('https://via.placeholder.com/250x150',height: 150,width: 250,),
                      )
                    )
                    ],
                  ),
                ),
              const SizedBox(height: 40,),
              Padding(padding: const EdgeInsets.only(left: 5,right: 5,),
              child:
                Container(
                  padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                  decoration: BoxDecoration(
                  border: Border.all(width: 1,color: AppColors.lightGrey),
                  borderRadius: BorderRadius.circular(10),
                ),    
                child:
                ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:2,
                itemBuilder: (context, index) {
                  return 
                  Column(children: [
                    SizedBox(
                      height: 50,
                      child: 
                      Row(children: [
                        Text("VIEWPOINT:", style: textStyleBodyText1.copyWith(fontSize: 18),),
                        Text(" View $index", style: textStyleBodyText1.copyWith(fontSize: 18),)
                        ],),
                    ),
                  Container(
                    padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                    boxShadow:  [
                      BoxShadow(color:Colors.grey[300]!, spreadRadius: 1
                    ],
                  ),
                    child:
                    Column(
                    children: [
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(children: [
                      _imagePaths[index]!="add"?Image.file(File(_imagePaths[index]),height: 70,width: 70):Image.asset('assets/images/no_image_icon.png',height: 70,width: 70,),
                      const SizedBox(height: 20,),
                      Text("18/01/2023",style: textStyleBodyText1,)
                      ]),
                      Column(children: [
                      SizedBox(width: 100,
                        child:
                        ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                        child:const Text('VIEW'),
                        onPressed: () async {
                        },
                      ),
                      ),
                       SizedBox(
                        width: 100,
                        child:
                       ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                        child:const Text('UPDATE'),
                        onPressed: () async {
                          showDialog(
                   context: context,
                   builder: (BuildContext context) {
                     return SimpleDialog(
                      alignment: Alignment.center,
                       children: <Widget>[
                        Text("      Choose",style: textStyleHeadline3.copyWith(fontWeight: FontWeight.normal),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                         SimpleDialogOption(
                            child: 
                            Column(
                                children: <Widget>[     
                                  const SizedBox(width: 10),
                                  const Icon(Icons.image,size: 70,color: Colors.grey,),
                                  Text("Gallery",style: textStyleBodyText1.copyWith(color: Colors.grey),),
                                ],
                              ),
                             onPressed: () async{
                               var image = await ImagePicker().pickImage(source: ImageSource.gallery);
                               setState(() {
                                  _imagePaths[index]=(image!.path);
                                  }
                                );
                               // ignore: use_build_context_synchronously
                               Navigator.pop(context);
                             },
                           ),
                          SimpleDialogOption(
                            child: Column(
                              children: <Widget>[
                                const SizedBox(width: 10),
                                 const Icon(Icons.camera_alt,size: 70,color: Colors.grey,),
                                Text("Camera",style:textStyleBodyText1.copyWith(color: Colors.grey),),
                              ],
                            ),
                             onPressed: () async{
                               var image = await ImagePicker().pickImage(source: ImageSource.camera);
                               setState(() {
                                  _imagePaths[index]=(image!.path);
                                  }
                                );
                               // ignore: use_build_context_synchronously
                               Navigator.pop(context);
                             },
                           ),
                        ]),
                           SimpleDialogOption(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                const SizedBox(width: 10),
                                Text("Cancel",style:textStyleBodyText1.copyWith(color: AppColors.primary),),
                              ],
                            ),
                             onPressed: () {
                               Navigator.pop(context);
                             },
                           ),
                         ],
                       );
                     },
                   );
                  },
                ),
              )
            ])
          ],
        )
      ]
    )
  )
]
);
},
)
)
)
],
)
),
],
)
)
);
}
}


Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const SubLocation(),
   transitionsBuilder: (context, animation, secondaryAnimation, child) {
  const begin = Offset(0.0, 1.0);
  const end = Offset.zero;
  final tween = Tween(begin: begin, end: end);
  final offsetAnimation = animation.drive(tween);

  return SlideTransition(
    position: offsetAnimation,
    child: child,
  );
},
  );
}


Route _createRoute2() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const ActivityHeadPage(),
   transitionsBuilder: (context, animation, secondaryAnimation, child) {
  const begin = Offset(0.0, 1.0);
  const end = Offset.zero;
  final tween = Tween(begin: begin, end: end);
  final offsetAnimation = animation.drive(tween);

  return SlideTransition(
    position: offsetAnimation,
    child: child,
  );
},
  );
}