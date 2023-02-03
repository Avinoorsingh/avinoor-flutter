import 'dart:async';
import 'package:colab/constants/colors.dart';
import 'package:colab/network/labourData/labour_data_network.dart';
import 'package:colab/services/helper/dependency_injector.dart';
import 'package:colab/services/local_database/local_database_service.dart';
import 'package:colab/views/loading_data_screen.dart';
import 'package:colab/views/project_level_page1.dart';
import 'package:colab/views/project_level_page2.dart';
import 'package:colab/views/project_level_page3.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';
import '../controller/signInController.dart';
import '../network/client_project.dart';
import '../theme/text_styles.dart';

// ignore: must_be_immutable
class ProjectLevelPage extends StatefulWidget {
  ProjectLevelPage({Key? key,required this.from, required this.clientData, required this.index}) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final from;
  // ignore: prefer_typing_uninitialized_variables
  final index;
  dynamic clientData;

  @override
  // ignore: no_logic_in_create_state
  State<ProjectLevelPage> createState() => _ProjectLevelPageState(clientData,index);
}

class _ProjectLevelPageState extends State<ProjectLevelPage> {
  final signInController=Get.find<SignInController>();
  final getClientProjectsController = Get.find<GetClientProject>();
  final getClientProfileController = Get.find<GetUserProfileNetwork>();
  final getNewSnagDataController=Get.find<GetNewSnag>();
  final getLabourDataContractorListController=Get.find<GetLabourDataContractor>();
  final getLabourDataOfSelectedContractorController=Get.find<GetSelectedContractorData>();
  final getLabourDataTodayController=Get.find<GetLabourDataToday>();
  final getNewDeSnagDataController=Get.find<GetNewDeSnag>();
  final getOpenedSnagDataController=Get.find<GetOpenedSnag>();
  final getOpenedDeSnagDataController=Get.find<GetOpenedDeSnag>();
  final getClosedSnagDataController=Get.find<GetClosedSnag>();
  final getClosedDeSnagDataController=Get.find<GetClosedDeSnag>();
  // ignore: prefer_typing_uninitialized_variables
  var clientDataGet;
  List pages=[];
  
  _ProjectLevelPageState(clientData,index){
     List pages = [
    ProjectLevelPage1(clientData: clientData,index: index,),
    const ProjectLevelPage2(),
    const ProjectLevelPage3(),
  ];
    // this.clientDataGet=clientData;
    this.pages=pages;
  }

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  late DatabaseProvider databaseProvider;


  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false){
            showDialogBox();
            setState(() => isAlertSet = true);
          }
          if (isDeviceConnected){
            saveData();
          }
        },
      );

  saveData () async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var tokenValue=sharedPreferences.getString('token');
     var clientId=sharedPreferences.getString('client_id');
     var projectID=sharedPreferences.getString('projectIdd');
     if(projectID!=null){
     try{
     var getProgressOfflineDataURL=Uri.parse('${Config.getProgressOfflineData}$clientId/$projectID');
     var res=await http.get(
            getProgressOfflineDataURL,
            headers: {
              "Accept": "application/json",
              "Authorization": "Bearer $tokenValue",
            },
            );
          if(res.statusCode==200){
          await databaseProvider.insertMyJsonModel(res.body);
          }
      } catch (e) {
          if (kDebugMode) {
            print("error in progress offline data");
            print(e);
          }
        }
        try{
     var getSnagOfflineDataURL=Uri.parse('${Config.getSnagOfflineData}$clientId/$projectID');
     var res=await http.get(
            getSnagOfflineDataURL,
            headers: {
              "Accept": "application/json",
              "Authorization": "Bearer $tokenValue",
            },
            );
          if(res.statusCode==200){
          await databaseProvider.insertSnagModel(res.body);
          }
      } catch (e) {
          if (kDebugMode) {
            print("error in snag offline data");
            print(e);
          }
        }
     }
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    getConnectivity();
    databaseProvider = DatabaseProvider();
    databaseProvider.init();
    clientDataGet=widget.clientData;
    getClientProfileController.getUserProfile(context: context);
    getLabourDataContractorListController.getContractorListData(context: context);
    getLabourDataOfSelectedContractorController.getSelectedContractorData(context: context);
    getClientProjectsController.getUpcomingProjects(context: context);
    getNewSnagDataController.getSnagData(context: context);
    getNewDeSnagDataController.getSnagData(context: context);
    getOpenedSnagDataController.getOpenedSnagData(context: context);
    getOpenedDeSnagDataController.getOpenedSnagData(context: context);
    getClosedSnagDataController.getClosedSnagData(context: context);
    getClosedDeSnagDataController.getClosedSnagData(context: context);
    saveProjectId();
  }

  saveProjectId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(widget.clientData.projectid!=null){
        sharedPreferences.setString("projectIdd",widget.clientData.projectid.toString());
        getClientProfileController.getUserProfile(context: context);
        getLabourDataContractorListController.getContractorListData(context: context);
        getLabourDataOfSelectedContractorController.getSelectedContractorData(context: context);
        getClientProjectsController.getUpcomingProjects(context: context);
        getNewSnagDataController.getSnagData(context: context);
        getNewDeSnagDataController.getSnagData(context: context);
        getOpenedSnagDataController.getOpenedSnagData(context: context);
        getOpenedDeSnagDataController.getOpenedSnagData(context: context);
        getClosedSnagDataController.getClosedSnagData(context: context);
        getClosedDeSnagDataController.getClosedSnagData(context: context);
        DependencyInjector.initializeControllers();
    }
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
     "MY TOOLS",
     "MY TASK",
     "MY TOOLS",
  ];

  int current = 0;
  @override
  Widget build(BuildContext context) {
    if(mounted){
    getClientProfileController.getUserProfile(context: context);
    getClientProjectsController.getUpcomingProjects(context: context);
    getClientProjectsController.getSelectedProjects(context:context);
    }
     return 
      GetBuilder<GetUserProfileNetwork>(builder: (_){
      final signInController=Get.find<SignInController>();
      return signInController.getClientProfile?.clientid!=null? Scaffold(
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
                      'Hi, ${signInController.getClientProfile?.name}',
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      style: textStyleHeadline4.copyWith(fontSize: 16),
                    ),
                    SizedBox(
                      child: Text(
                      'Last Login: ${signInController.getClientProfile?.updatedat!=null ? f.format(DateTime.parse(signInController.getClientProfile!.updatedat.toString())):f.format(DateTime.now())}',
                      overflow: TextOverflow.ellipsis,
                      style: textStyleBodyText2.copyWith(
                          color: Colors.black, fontSize: 14),
                    )),
                    Flexible(
                     child: 
                     Text(
                     ' ${signInController.getClientProfile?.name}',
                     overflow: TextOverflow.ellipsis,
                     style: textStyleBodyText2.copyWith(
                         color: Colors.black, fontSize: 14),
                    )),
                      if(widget.from=="client")
                       Flexible(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(elevation: 0,
                          splashFactory: NoSplash.splashFactory,
                          backgroundColor: Colors.greenAccent),
                          child: const Text("CHANGE PROJECT", style: TextStyle(color: Colors.black,fontSize: 8)),
                          onPressed: () async {
                          context.pushNamed('CLIENTLEVELPAGE');
                        },)
                       )
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
              onTap: () {
                context.pushNamed('MYPROFILEPAGE');
                },
                child: Image.network("https://nodejs.hackerkernel.com/colab${signInController.getClientProfile?.userimage}",
                          errorBuilder: (BuildContext? context, Object? exception, StackTrace? stackTrace) {
                              EasyLoading.dismiss();
                              return const Image(image: AssetImage('assets/images/user_fill.png'), height: 50,
                          width: 50,
                          fit: BoxFit.cover);
                          },
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover),
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
      // height: double.infinity,
      margin: const EdgeInsets.only(left:5,right: 5),
      child: Column(
        children: [
          /// CUSTOM TABBAR
          SizedBox(
            width: double.infinity,
            height: 90,
            child:
            Center(child: 
             ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: items.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            current = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.all(5),
                          width: 80,
                          decoration: BoxDecoration(
                            color: current == index
                                ? AppColors.white
                                : Colors.white54,
                            borderRadius: current == index
                                ? BorderRadius.circular(15)
                                : BorderRadius.circular(10),
                            border: current == index
                                ? Border.all(
                                    color: Colors.white, width: 2)
                                : null,
                          ),
                          child: 
                          Card(
                            color: current == index
                                ?AppColors.primary
                                : Colors.white,
                            elevation: 5,
                            child: 
                          Center(
                            child: 
                            Image.asset(items[index].toString())
                          ),
                          ),
                        ),
                      ),
                      Visibility(
                          visible: current == index,
                          child: Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                                color:AppColors.primary,
                                shape: BoxShape.circle),
                          )),
                    ],
                  );
                }),
            )
          ),
          Visibility(child: Center(child: Text(tabName[current],style: textStyleHeadline3,)),),
          Expanded(
              child: pages[current],
          ),
        ],
      ),
      ),
      )
    ):const LoadingDataScreen();
  });
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
                                isDeviceConnected =
                                    await InternetConnectionChecker().hasConnection;
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
                                }, child: Text("OFFLINE",style:textStyleBodyText1.copyWith(color: AppColors.primary),),)
                              ],
                            ),
                           ),
                         ],
                       );
                     },
                   );
}