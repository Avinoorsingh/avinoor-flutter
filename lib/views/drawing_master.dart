import 'dart:convert';
import 'package:colab/views/drawing_master_pdf.dart';
import 'package:http/http.dart' as http;
import 'package:colab/constants/colors.dart';
import 'package:colab/network/area_of_concern_network.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';
import '../controller/signInController.dart';
import '../theme/text_styles.dart';

class DrawingMaster extends StatefulWidget {
  const DrawingMaster({Key? key,}) : super(key: key);

  @override
  State<DrawingMaster> createState() => _DrawingMasterState();
}

bool show=false;
// ignore: prefer_typing_uninitialized_variables
late var tapped;

class _DrawingMasterState extends State<DrawingMaster> {
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
  List treeData=[];
  final locationId=TextEditingController();
  final categoryController=TextEditingController();
  final locationController = TextEditingController();
  final subLocationController = TextEditingController();
  final subSubLocationController = TextEditingController();
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
  List<int> locationID=[];
 
 @override
 void initState(){
  EasyLoading.show(maskType: EasyLoadingMaskType.black);
  super.initState();
  // getAreaOfConcern.getAreaOfConcernData(context: context);
  drawingTree();
 }

 drawingTree() async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token=sharedPreferences.getString('token');
  var projectID=sharedPreferences.getString('projectIdd');
  var clientID=sharedPreferences.getString('client_id');
  try {
    var getDrawingMasterListUrl=Uri.parse("${Config.getDrawingModuleApi}$clientID/${projectID??"1"}");
    var res=await http.get(
      getDrawingMasterListUrl,
      headers:{
        "Accept": "application/json",
        "Authorization": "Bearer $token",
        },
      );
      var cData4=jsonDecode(res.body);
        if(cData4!=null){
          // for(int i=0;i<cData4['data'].length;i++){
            treeData=cData4['data'];
            // }
            }
          setState(() {});
          EasyLoading.dismiss();
          }
          catch(e){
            if (kDebugMode) {
            print("Error");
            print(e);
          }
        }
      }

  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
    return 
    Scaffold(
    appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor:AppColors.primary,
      title: Text("Drawing Master", style: textStyleHeadline3.copyWith(color: Colors.black,fontWeight: FontWeight.w400),),
      ),
    body: 
    Container(margin: const EdgeInsets.only(top: 10),
    child:treeData.isNotEmpty?
    ListView.builder(
      itemCount: treeData.length,
      itemBuilder: (context, index) {
        final item = treeData[index];
        return ExpansionTile(
          textColor: AppColors.black,
          // leading: const Icon(Icons.arrow_forward_ios,size: 20,),
          collapsedTextColor: AppColors.black,
          key: PageStorageKey(item['drawing_category']),
          title: Row(
            children: [ 
            const Icon(Icons.folder, color:AppColors.black,),
            const Text("    "),
            Text(item['drawing_category'], style: const TextStyle(color: Colors.black),),
            ]),
          children: <Widget>[
            for (var type in item['type'])
              _buildTreeViewItem(context, type)
          ],
        );
      },
    ):const Center(child: CircularProgressIndicator(color: AppColors.primary,),)) 
    );
}
}

  Widget _buildTreeViewItem(BuildContext context, Map<String, dynamic> item) {
    return 
    Container(
      margin:const EdgeInsets.only(left: 10),
      child:
    ExpansionTile(
      textColor: AppColors.black,
      collapsedTextColor: AppColors.black,
      key: PageStorageKey(item['drawing_type']),
      title:Row(children: [
        const Icon(Icons.folder, color:AppColors.black,),
        const Text("   "),
        Text(item['drawing_type'], style:const TextStyle(color: Colors.black),),
      ],),
      children: <Widget>[
        for (var activity in item['activity'])
          _buildTreeViewActivity(context, activity)
      ],
    ));
  }

  Widget _buildTreeViewActivity(BuildContext context, Map<String, dynamic> item){
    return 
     Container(
      margin:const EdgeInsets.only(left: 10),
      child:
    ExpansionTile(
      textColor: AppColors.black,
      collapsedTextColor: AppColors.black,
      key: PageStorageKey(item['activity_head']),
      title:
      Row(children: [
        const Icon(Icons.folder, color:AppColors.black,),
        const Text("   "), 
        Text(item['activity_head'], style:const TextStyle(color: Colors.black),),
      ]),
      children: <Widget>[
        for (var location in item['location'])
          _buildTreeViewLocation(context, location)
      ],
    ));
  }

  Widget _buildTreeViewLocation(BuildContext context, Map<String, dynamic> item) {
    return 
     Container(
      margin:const EdgeInsets.only(left: 10),
      child:
    ExpansionTile(
      textColor: AppColors.black,
      collapsedTextColor: AppColors.black,
      key: PageStorageKey(item['location_name']),
      title:Row(children: [
        const Icon(Icons.folder, color:AppColors.black,),
        const Text("   "),
       Text(item['location_name'], style:const TextStyle(color: Colors.black),),
      ]),
      children: <Widget>[
        for (var files in item['files'])
          _buildTreeViewFiles(context, files)
      ],
     ));
  }

  Widget _buildTreeViewFiles(BuildContext context, Map<String, dynamic> item) {
    return 
     Container(
      margin:const EdgeInsets.only(left: 10),
      child:
      Column(
    // ExpansionTile(
    //   textColor: AppColors.black,
    //   collapsedTextColor: AppColors.black,
    //   leading:const Icon(Icons.folder, color:AppColors.black,),
    //   key: PageStorageKey(item['location_name']),
    //   title:Text(""),
      children: <Widget>[
        for (var file in item['drawing_master_file'])
          ListTile(
            title: 
              GestureDetector(
              onTap: (){
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PDFScreen(path: "https://nodejs.hackerkernel.com/colab${file['drawing_master_file']}"),
              ),
            );
              },
              child:
              Row(children: [ 
                Container(
                  height: 25,
                  width: MediaQuery.of(context).size.width/7.4,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color.fromARGB(255, 10, 124, 218), Color.fromARGB(255, 231, 235, 239)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child:Center(child: Text("VIEW", style: textStyleButton.copyWith(color: AppColors.white,fontSize: 12),),),),
                  Text("   ${file['drawing_name']}")]))
            // subtitle: 
            // Text(file['drawing_master_file']),
          ),
      ],
    ));
  }