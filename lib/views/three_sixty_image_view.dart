import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:panorama/panorama.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/colors.dart';
import '../controller/signInController.dart';
import '../network/area_of_concern_network.dart';
import 'package:http/http.dart' as http;

class ThreeSixtyImageView extends StatefulWidget {
  const ThreeSixtyImageView({Key? key,this.viewpointID, this.masterImage}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final viewpointID;
  // ignore: prefer_typing_uninitialized_variables
  final masterImage;

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
  bool _isBottomSheetExpanded = false;
  final imageController=TextEditingController();
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
  List<bool> isCardEnabled = [];
  List<String> categoryNew=[];
  List<int> categoryID=[];
 
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
      imageController.text=viewpointsImage[0];
    }
  if (kDebugMode) {
    print(viewpointsImage);
  }
  setState(() {});
  }

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
    Stack(
      children: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: 
        Panorama(
          zoom: 1,
          animSpeed: 0,
          child:Image(
              image:CachedNetworkImageProvider(
                "https://nodejs.hackerkernel.com/colab${imageController.text}",
            ),
            fit: BoxFit.fill,
            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
               if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                  color: AppColors.primary,
                  value: loadingProgress.expectedTotalBytes != null
                         ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
          ),
        ),),
        Positioned(
          bottom: 20,
          child:
         SizedBox(
          height: 90,child: 
          ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(15),
          itemCount: viewpointsImage.length,
          itemBuilder: (BuildContext context, int index){
            isCardEnabled.add(false);
            return GestureDetector(
                onTap: (){
                  isCardEnabled.replaceRange(0, isCardEnabled.length, [for(int i = 0; i < isCardEnabled.length; i++)false]);
                  isCardEnabled[index]=true;
                  imageController.text=viewpointsImage[index];
                  // categoryIDController.text=categoryID[index].toString();
                  if (kDebugMode) {
                    print(categoryIDController.text);
                  }
                  setState(() {});
                },
                child: SizedBox(
                  height: 200,
                  width: 90,
                  child: Card(
                    elevation: 5,
                    color: isCardEnabled[index]? AppColors.primary:AppColors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color:  AppColors.primary,width: 1),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Center(
                      child:
                      Text(DateFormat('yyyy-MM-dd').format(DateTime.parse(viewpointsImageDate[index])),textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isCardEnabled[index]?Colors.black: AppColors.primary,
                          fontSize: 14
                        ),
                      )
                    ),
                  ),
                )
            );
          })
          ),
        )
        ]):
      const Center(child: CircularProgressIndicator(color: AppColors.primary,)),
      bottomSheet: BottomSheet(
      onClosing: () {
        setState(() {
          _isBottomSheetExpanded = false;
        });
      },
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          height: _isBottomSheetExpanded ? 200 : 0,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: const <Widget>[
                Text('Bottom Sheet Content'),
              ],
            ),
          ),
        );
      },
      // expand: _isBottomSheetExpanded,
    ),
    bottomNavigationBar: BottomAppBar(
      child: 
    SizedBox(height: 80,child:
    Column(children: [ 
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Container(
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      margin:const EdgeInsets.only(top: 10),
      width: 30,
      height: 5,
    )]),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text("Master Image",style: textStyleHeadline2,),
        const SizedBox(width: 10,),
        IconButton(
            icon: const Icon(Icons.keyboard_arrow_up, size: 35,),
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (BuildContext context) => Container(
                alignment: Alignment.center,
                height: 280,
                child: Column(
                  children: [
                     Column(
                      children: [ 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Container(
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    margin:const EdgeInsets.only(top: 10),
                    width: 30,
                    height: 5,
                  )]),
                  Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Master Image",style: textStyleHeadline2,),
                      const SizedBox(width: 10,),
                      IconButton(
                          icon: const Icon(Icons.keyboard_arrow_down, size: 35,),
                          onPressed: () => {
                            Navigator.pop(context),
                          }
                        ),
                    ],
                  ),
                Card(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 150,
                        width: 250,
                        child: FittedBox(
                          child:
                         widget.masterImage!="Not available"?Image.network('https://nodejs.hackerkernel.com/colab${widget.masterImage}',height: 150,width: 250,):Image.asset('assets/images/no_image_icon.png',height: 150,width: 250,),
                      )
                    )
                    ],
                  ),
                ),])])
                  ],
                ),
              ),
            ),
          ),
      ],
    )]))),
    );
  }
}