import 'dart:async';
import 'dart:convert';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/colors.dart';
import '../controller/signInController.dart';
import '../models/location_list.dart';
import '../network/area_of_concern_network.dart';

class AddThreeSixtyImage extends StatefulWidget {
  const AddThreeSixtyImage({Key? key,this.locName, this.subLocName, this.subSubLocName, this.locId, this.subLocId, this.subSubLocId}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final locName;
  // ignore: prefer_typing_uninitialized_variables
  final subLocName;
  // ignore: prefer_typing_uninitialized_variables
  final subSubLocName;
  // ignore: prefer_typing_uninitialized_variables
  final locId;
  // ignore: prefer_typing_uninitialized_variables
  final subLocId;
  // ignore: prefer_typing_uninitialized_variables
  final subSubLocId;

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
  final masterImageController=TextEditingController();
  late String subV="";
  late String subSubV="";
  String dropdownvalue = 'Select Location';  
  String dropdownvalue2 = 'Select Sub Location';  
  final signInController=Get.find<SignInController>();
  final List<String> _imagePaths = [];
  final List<String> viewpointsName=[];
  final List<int> viewpointsNameID=[];
  final List<String> fileName=[];
  final List<int> fileNameID=[];
 
 @override
 void initState(){
  super.initState();
  getAreaOfConcern.getAreaOfConcernData(context: context);
  _getViewPoint();
 }

 Future<void> _getViewPoint() async {
  viewpointsName.clear();
  viewpointsNameID.clear();
  fileName.clear();
  fileNameID.clear();
  _imagePaths.clear();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token=sharedPreferences.getString('token');
    var res=await http.post(
            Uri.parse("http://nodejs.hackerkernel.com/colab/api/getViewPointMaster"),
            headers: {
                  "Accept": "application/json",
                  "Authorization": "Bearer $token",
                  },
            body: {
                  "loc_id": widget.locId,
                  "sub_loc_id": widget.subLocId,
                  "sub_sub_location_id": widget.subSubLocId,
                  }
                );
            if(jsonDecode(res.body)['data'].isNotEmpty){
            masterImageController.text=jsonDecode(res.body)['data'][0]['master_file'];
                for(int i=0;i<jsonDecode(res.body)['data'].length;i++){
                  viewpointsName.add(jsonDecode(res.body)['data'][i]['viewpoint']??"Name $i");
                  viewpointsNameID.add(jsonDecode(res.body)['data'][i]['viewpoint_name_id']);
                  fileName.add(jsonDecode(res.body)['data'][i]['file_name']??"add");
                  fileNameID.add(jsonDecode(res.body)['data'][i]['file_name_id']??0);
                  _imagePaths.add("add");
                }
              }
              else{
                masterImageController.text="Not available";
              }
            setState(() {});
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
        title: Text("Add 360 Images", style: textStyleHeadline3.copyWith(color: Colors.black,fontWeight: FontWeight.w400),),
    ),
    body: masterImageController.text.isNotEmpty ?
    Container(margin: const EdgeInsets.only(top: 0),
    child:
    ListView(
      children: [
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width, 
          color: Colors.black38,
          padding: const EdgeInsets.only(top: 20),
          child:Text('${widget.locName}/${widget.subLocName}', style: textStyleBodyText1.copyWith(fontSize: 18), textAlign: TextAlign.center,),),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10,),
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
                        child: FittedBox(
                          child:
                          masterImageController.text!="Not available"? Image.network('https://nodejs.hackerkernel.com/colab${masterImageController.text}',height: 150,width: 250,):Image.asset('assets/images/no_image_icon.png',height: 150,width: 250,),
                          )
                        )
                      ],
                     ),
                   ),
              const SizedBox(height: 40,),
              Padding(
              padding: const EdgeInsets.only(left: 0, right: 0,),
              child:
              viewpointsNameID.isNotEmpty ?
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppColors.lightGrey),
                  borderRadius: BorderRadius.circular(10),
                ),    
                child:
                ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: viewpointsNameID.length,
                itemBuilder: (context, index){
                  return 
                  Column(children: [
                    SizedBox(
                      height: 50,
                      child: 
                      Row(children: [
                        Text("VIEWPOINT:", style: textStyleBodyText1.copyWith(fontSize: 18),),
                        Text(viewpointsName[index], style: textStyleBodyText1.copyWith(fontSize: 18),)
                        ],),
                    ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                      children: [
                      fileName[index]!="add" ? Image.network('https://nodejs.hackerkernel.com/colab${fileName[index]}', height: 70, width: 70,)
                      : Image.asset('assets/images/no_image_icon.png', height: 70, width: 70,),
                      const SizedBox(height: 10,),
                      Text(DateFormat('dd/MM/yyyy').format(DateTime.now()).toString(),style: textStyleBodyText1,),
                      ]),
                      Column(
                      children: [
                      SizedBox(
                        width: 100,
                        child:
                        ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                        child:const Text('VIEW'),
                        onPressed: () async {
                        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                        var token = sharedPreferences.getString('token');
                        var res = await http.get(
                              Uri.parse("http://nodejs.hackerkernel.com/colab/api/getViewPointImagesForSlider/${viewpointsNameID[index].toString()}"),
                              headers: {
                              "Content-Type": "application/json",
                              "Accept": "application/json",
                              "Authorization": "Bearer $token",
                              }
                            );
                            if(jsonDecode(res.body)['data'].isNotEmpty){
                                // ignore: use_build_context_synchronously
                              context.pushNamed('VIEW360IMAGE',
                              queryParams: {
                              "viewpointID": viewpointsNameID[index].toString(),
                              "masterImage": masterImageController.text,
                              });
                            }
                            else {
                              EasyLoading.showToast('No images available here', toastPosition: EasyLoadingToastPosition.bottom);
                            }
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
                          builder: (BuildContext context){
                            return SimpleDialog(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Text("      Choose", style: textStyleHeadline3.copyWith(fontWeight: FontWeight.normal),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                SimpleDialogOption(
                                  child: 
                                  Column(
                                        children: <Widget>[     
                                          const SizedBox(width: 10),
                                          const Icon(Icons.image,size: 70, color: Colors.grey,),
                                          Text("Gallery", style: textStyleBodyText1.copyWith(color: Colors.grey),),
                                        ],
                                      ),
                                    onPressed: () async {
                                      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
                                      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                      var token=sharedPreferences.getString('token');
                                      FormData formData=FormData();
                                      var dio = Dio();
                                      formData.fields.add(MapEntry('id', viewpointsNameID[index].toString()));
                                      formData.files.add(
                                      MapEntry("file", await MultipartFile.fromFile((image!.path), filename: 'de_snag_image')));
                                      await dio.post("http://nodejs.hackerkernel.com/colab/api/uploadViewpointFiles",
                                      data:formData,
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
                                      await  _getViewPoint();
                                      setState(() {
                                          _imagePaths[index]=image.path;
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
                                        const Icon(Icons.camera_alt, size: 70,color: Colors.grey,),
                                        Text("Camera", style:textStyleBodyText1.copyWith(color: Colors.grey),),
                                      ],
                                    ),
                                    onPressed: () async {
                                      var image = await ImagePicker().pickImage(source: ImageSource.camera);
                                      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                      var token=sharedPreferences.getString('token');
                                      FormData formData=FormData(); 
                                      var dio = Dio();
                                      formData.fields.add(MapEntry('id', viewpointsNameID[index].toString()));
                                      formData.files.add(
                                      MapEntry("file", await MultipartFile.fromFile((image!.path), filename: 'de_snag_image')));
                                      await dio.post("http://nodejs.hackerkernel.com/colab/api/uploadViewpointFiles",
                                      data:formData,
                                      options: Options(
                                          followRedirects: false,
                                          validateStatus: (status){
                                            return status! < 500;
                                          },
                                          headers:{
                                            "authorization": "Bearer ${token!}",
                                            "Content-type": "application/json",
                                          },
                                        ),
                                      );
                                      await  _getViewPoint();
                                      setState(() {
                                          _imagePaths[index]=image.path;
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
                                    Text("Cancel", style:textStyleBodyText1.copyWith(color: AppColors.primary),),
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
  ):Center(child: Text("Viewpoints Not available",style: textStyleBodyText1,))
 )
],
),
),
],
),
):const Center(child: CircularProgressIndicator(color: AppColors.primary,),),
);
}
}