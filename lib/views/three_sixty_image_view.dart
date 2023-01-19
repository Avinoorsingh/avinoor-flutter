import 'dart:async';
import 'dart:convert';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:panorama/panorama.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/colors.dart';
import '../controller/signInController.dart';
import '../network/area_of_concern_network.dart';
import 'package:http/http.dart' as http;

class ThreeSixtyImageView extends StatefulWidget {
  const ThreeSixtyImageView({Key? key,this.viewpointID}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final viewpointID;

  @override
  State<ThreeSixtyImageView> createState() => _ThreeSixtyImageState();
}

bool show=false;
// ignore: prefer_typing_uninitialized_variables
late var tapped;

class _ThreeSixtyImageState extends State<ThreeSixtyImageView> {
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
  final List<String> viewpointsImage=[];
  final List<String> viewpointsImageDate=[];
  final List<String> fileName=[];
  final List<int> fileNameID=[];
 
 @override
 void initState(){
  super.initState();
  getAreaOfConcern.getAreaOfConcernData(context: context);
  _getViewPoint();
 }

 Future<void> _getViewPoint() async {
  viewpointsImage.clear();
  viewpointsImageDate.clear();
  fileName.clear();
  fileNameID.clear();
  _imagePaths.clear();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token=sharedPreferences.getString('token');
  var res=await http.get(
        Uri.parse("http://nodejs.hackerkernel.com/colab/api/getViewPointImagesForSlider/${widget.viewpointID}"),
        headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
        }
      );
    if(jsonDecode(res.body)['data'].isNotEmpty){
      for(int i=0;i<jsonDecode(res.body)['data'].length;i++){
         viewpointsImage.add(jsonDecode(res.body)['data'][i]['file_name']);
         viewpointsImageDate.add(jsonDecode(res.body)['data'][i]['created_at']);
      }
    }
    print(viewpointsImage);
    setState(() {});
  }
 double _lon = 0;
  double _lat = 0;
  double _tilt = 0;
  int _panoId = 0;
  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
    return 
    Scaffold(
    appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor:AppColors.primary,
      title: Text("360 Images",style: textStyleHeadline3.copyWith(color: Colors.black,fontWeight: FontWeight.w400),),
      ),
    body: viewpointsImage.isNotEmpty?
    Column(children: [
      Container(
        height: 600,
        width: MediaQuery.of(context).size.width,
        child: 
       Panorama(
        
        // croppedArea: Rect.fromLTWH(2533.0, 1265.0, 5065.0, 2533.0),
        // croppedFullWidth: 10132.0,
        // croppedFullHeight: 5066.0,
        zoom: 1,
        animSpeed: 0,
        child:Image(image:NetworkImage(
          "https://nodejs.hackerkernel.com/colab${viewpointsImage[0]}",
          // height:100,
          // width:MediaQuery.of(context).size.width,
        ),
          fit: BoxFit.cover,
        ),
      ),)]):const Center(child: CircularProgressIndicator(color: AppColors.primary,)));
  }
}

Widget hotspotButton({String? text, IconData? icon, VoidCallback? onPressed}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(CircleBorder()),
            backgroundColor: MaterialStateProperty.all(Colors.black38),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          child: Icon(icon),
          onPressed: onPressed,
        ),
        text != null
            ? Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Center(child: Text(text)),
              )
            : Container(),
      ],
    );
  }