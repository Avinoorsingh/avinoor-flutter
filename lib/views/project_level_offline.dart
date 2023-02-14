import 'package:colab/models/all_offline_data.dart';
import 'package:colab/models/all_offline_data2.dart';
import 'package:colab/models/snag_offline.dart';
import 'package:colab/services/local_database/local_database_service.dart';
import 'package:colab/views/project_level_page_offline1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
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
  
  _ProjectLevelPageState(){
     List pages = [
    const ProjectLevelPageOffline1(),
  ];
    this.pages=pages;
  }

  @override
  void initState(){
    databaseProvider = DatabaseProvider();
    databaseProvider.init();
    super.initState();
    fetchProgressData();
    fetchSnagData();
  }

  Future<List<ProgressOffline>> fetchProgressData() async {
    progressData= await databaseProvider.getMyJsonModels();
    return progressData;
  }

  Future<List<SnagDataOffline>> fetchSnagData() async {
    snagData= await databaseProvider.getSnagModel();
    await fetchAllData();
    return snagData;
  }

  Future<List<AllOfflineData>> fetchAllData() async {
    allOfflineData= await databaseProvider.getAllOfflineModel();
    return allOfflineData;
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
                child: Image.network("https://nodejs.hackerkernel.com/colab",
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
}