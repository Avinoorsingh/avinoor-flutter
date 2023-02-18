import 'dart:async';
import 'dart:convert';
import 'package:colab/models/all_offline_data2.dart';
import 'package:colab/models/snag_offline.dart';
import 'package:colab/services/local_database/local_database_service.dart';
import 'package:colab/views/project_level_page_offline1.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/colors.dart';
import '../models/progress_offline.dart';
import '../theme/text_styles.dart';

class ProjectLevelOffline extends StatefulWidget {
  const ProjectLevelOffline({Key? key}) : super(key: key);


  @override
  State<ProjectLevelOffline> createState() => _ProjectLevelPageState();
}

class _ProjectLevelPageState extends State<ProjectLevelOffline> {
  // ignore: prefer_typing_uninitialized_variables
  var clientDataGet;
  List pages=[];
  List<ProgressOffline> progressData=[];
  List<AllOfflineData> allOfflineData=[];
  List<SnagDataOffline> snagData=[];
  late DatabaseProvider databaseProvider;
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  List formDataList = [];
  List outerProgressFormDataList=[];
  FormData formData=FormData(); 
  FormData formData2=FormData(); 
  var dio = Dio();
  
  _ProjectLevelPageState(){
     List pages = [
    const ProjectLevelPageOffline1(),
  ];
    this.pages=pages;
  }

   getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (isDeviceConnected){
            fetchSnagsFromLocal();
            fetchOuterProgressFromLocal();
          }
          else if (!isDeviceConnected && isAlertSet == false){
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );
  
   Future<List<SnagDataOffline>> fetchSnagData() async {
    snagData= await databaseProvider.getSnagModel();
    await fetchSnagsFromLocal();
     setState(() {
      snagData;
    });
    return snagData;
  }

  fetchSnagsFromLocal() async {
    formDataList=await databaseProvider.getSnagFormData();
    List<dynamic> snagsDataList = formDataList.map((snag) => snag['snags_data']).toList();
    // Iterate through each snag
    if(snagsDataList.isNotEmpty){
       formData.fields.add(MapEntry('snags_data',jsonEncode(snagsDataList)));
    }
    for (int i = 0; i < formDataList.length; i++) {
      Map<String, dynamic> snag = formDataList[i];
      // Iterate through each viewpoint in the snag
      snag.forEach((key, value) {
        if (key.startsWith("viewpoint_")) {
          // Add the viewpoint file to the formData
          formData.files.add(MapEntry(key, MultipartFile.fromFileSync(value, filename: "viewpoint_image")));
        }
      });
    }
      for (int i = 0; i < formDataList.length; i++) {
      Map<String, dynamic> markup = formDataList[i];
      // Iterate through each viewpoint in the snag
      markup.forEach((key, value) {
        if (key.startsWith("markup_")) {
          // Add the viewpoint file to the formData
          if(value.isNotEmpty){
          formData.files.add(MapEntry(key, MultipartFile.fromFileSync(key, filename: "image${i + 1}")));
          }
          else{
             formData.fields.add(MapEntry(key, ''));
          }
        }
      });
    }
     try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var token=sharedPreferences.getString('token');
      var res=await dio.post(
        "http://nodejs.hackerkernel.com/colab/api/add_offline_snags",
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
        if (kDebugMode) {
          // print(res.data);
          // print(formData.fields);
          // print(formData.files);
          // formData.fields.clear();
          // formData.files.clear();
        }
        // EasyLoading.showToast("Snag Saved", toastPosition: EasyLoadingToastPosition.bottom);
        } catch (e) {
        EasyLoading.showToast("server error occured", toastPosition: EasyLoadingToastPosition.bottom);
        EasyLoading.dismiss();
        if (kDebugMode) {
          print(e);
        }
      }
  }

  fetchOuterProgressFromLocal() async {
    outerProgressFormDataList = await databaseProvider.getOuterProgressFormData();
    List<dynamic> progressDataList = outerProgressFormDataList.map((progress) => progress['progress_data']).toList();
    if(progressDataList.isNotEmpty){
      for(int i=0;i<progressDataList.length;i++){
        print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
        print(progressDataList[i]);
        print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
        for(int j=0;j<progressDataList[i].length;j++){
    Map<String, dynamic> dataToBeSent = {
      "client_id": progressDataList[i][j]["client_id"],
      "project_id": progressDataList[i][j]["project_id"],
      "link_activity_id": progressDataList[i][j]["link_activity_id"],
      "created_by": progressDataList[i][j]["client_id"],
      "daily_progress": progressDataList[i],
    };
    formData2.fields.add(MapEntry('progress_data',jsonEncode(dataToBeSent)));
      }
    }
    for (int i = 0; i < progressDataList.length; i++) {
      for(int j=0;j<progressDataList[i].length;j++){
      Map<String, dynamic> progress = progressDataList[i][j];
      progress.forEach((key, value) {
        if(value!=null){
        if (key.startsWith("progress_image")) {
          formData2.files.add(MapEntry(key, MultipartFile.fromFileSync(value, filename: "progress_image")));
        }
        }
        else{
           formData2.fields.add(MapEntry(key, ''));
        }
      });
      }
    }
      try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var token=sharedPreferences.getString('token');
      var res=await dio.post(
        "http://nodejs.hackerkernel.com/colab/api/progress_add_offline_data",
        data: formData2,
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
        if (kDebugMode) {
          print(res.data);
          print(formData2.fields);
          print(formData2.files);
          formData.fields.clear();
          formData.files.clear();
        }
        // EasyLoading.showToast("Progress Saved", toastPosition: EasyLoadingToastPosition.bottom);
        } catch (e) {
        EasyLoading.showToast("server error occured", toastPosition: EasyLoadingToastPosition.bottom);
        EasyLoading.dismiss();
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }



  @override
  void initState(){
    databaseProvider = DatabaseProvider();
    databaseProvider.init();
    super.initState();
    getConnectivity();
  }


  final f = DateFormat('yyyy-MM-dd hh:mm a');
   getFormatedDate(date) {
      var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
      var inputDate = inputFormat.parse(date);
      var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(inputDate);
  }

    List<String> items = [
    "assets/images/my_tools_img.png",
    "assets/images/my_task_img.png",
    "assets/images/my_info.png",
  ];

  List<String> tabName=[
     "OFFLINE FEATURES",
  ];

  int current = 0;
  @override
  Widget build(BuildContext context) {
    if(mounted){
    }
     return WillPopScope(
      onWillPop: ()async{
        // print('willPopScope');
        // Navigator.of(context, rootNavigator: false).pop();
        return false;
      },
     child:
     Scaffold(
        appBar: AppBar(
           flexibleSpace: 
           Container(
            decoration: 
              const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/dash_bg_img.png'),
                  fit: BoxFit.cover,
                ),
              ),
          ),
          elevation: 0,
          title:
          Container(
            padding: const EdgeInsets.only(bottom: 80,top: 40),
            child:
          Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 220,
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Hi, User',
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      style: textStyleHeadline4.copyWith(fontSize: 16),
                    ),
                    SizedBox(
                      child: Text(
                      'Last Login: 08:22 PM',
                      overflow: TextOverflow.ellipsis,
                      style: textStyleBodyText2.copyWith(
                          color: Colors.black, fontSize: 14),
                    )),
                    Flexible(
                     child: 
                     Text(
                     ' ',
                     overflow: TextOverflow.ellipsis,
                     style: textStyleBodyText2.copyWith(
                         color: Colors.black, fontSize: 14),
                    )),
                  ],
                ),
              ),
              const SizedBox(width: 10,),
             Material(
             borderRadius: BorderRadius.circular(100),
             clipBehavior: Clip.antiAliasWithSaveLayer,
             color: Colors.white,
             elevation: 0,
             shadowColor: Colors.black,
             borderOnForeground: true,
             child: InkWell(
              onTap: () {},
                child: const Image(image: AssetImage('assets/images/user_fill.png'), height: 50,
                          width: 50,
                          fit: BoxFit.cover)
                    ),
                  ),
            ],
          ),
          ],
          ),
          ),
          toolbarHeight: 170,
          backgroundColor: Colors.transparent,
          leading: 
          const Padding(padding:EdgeInsets.only(bottom: 80) ,child:
          Icon(
            Icons.notifications,
            size: 28,
          ),
          ),
        ),
      body:
      Center(child: 
      Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left:5,right: 5),
      child: Column(
        children: [
          Visibility(child: Center(child: Text("OFFLINE FEATURES",style: textStyleHeadline3,)),),
          Expanded(
              child: pages[current],
          ),
        ],
      ),
      ),
      )
     )
    );
  }
showDialogBox() => showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context1) {
              return SimpleDialog(
                alignment: Alignment.center,
                contentPadding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                children: <Widget>[
                Text("No Internet Connection", style: textStyleHeadline3.copyWith(fontWeight: FontWeight.bold),),
                Text("You need to have Mobile Data or wifi to access this. Press Offline to go Offline feature.",style: textStyleBodyText1.copyWith(color: Colors.black),),
                SimpleDialogOption(
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                  GestureDetector(onTap : () async {
                  Navigator.pop(context1, 'Cancel');
                  setState(() => isAlertSet = false);
                  isDeviceConnected = await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              }, 
              child: Text("RETRY",style:textStyleBodyText1.copyWith(color: AppColors.primary),),),
              const SizedBox(width: 20),
              GestureDetector( 
               onTap: (){
                  Navigator.pop(context1);
                  context.pushNamed('PROJECTOFFLINE');
                }, 
                child: Text("OFFLINE",style:textStyleBodyText1.copyWith(color: AppColors.primary),),)
              ],
            ),
          ),
        ],
      );
    },
  );
}