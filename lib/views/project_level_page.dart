import 'package:colab/constants/colors.dart';
import 'package:colab/views/loading_data_screen.dart';
import 'package:colab/views/project_level_page1.dart';
import 'package:colab/views/project_level_page2.dart';
import 'package:colab/views/project_level_page3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../controller/signInController.dart';
import '../network/client_project.dart';
import '../theme/text_styles.dart';

// ignore: must_be_immutable
class ProjectLevelPage extends StatefulWidget {
  ProjectLevelPage({Key? key,required this.from, required this.clientData}) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final from;
  dynamic clientData;

  @override
  // ignore: no_logic_in_create_state
  State<ProjectLevelPage> createState() => _ProjectLevelPageState(clientData);
}

class _ProjectLevelPageState extends State<ProjectLevelPage> {
  final signInController=Get.find<SignInController>();
  final getClientProjectsController = Get.find<GetClientProject>();
  final getClientProfileController = Get.find<GetUserProfileNetwork>();
  final getNewSnagDataController=Get.find<GetNewSnag>();
  final getNewDeSnagDataController=Get.find<GetNewDeSnag>();
  final getOpenedSnagDataController=Get.find<GetOpenedSnag>();
  final getOpenedDeSnagDataController=Get.find<GetOpenedDeSnag>();
  final getClosedSnagDataController=Get.find<GetClosedSnag>();
  final getClosedDeSnagDataController=Get.find<GetClosedDeSnag>();
  // ignore: prefer_typing_uninitialized_variables
  var clientDataGet;
  List pages=[];
  
  _ProjectLevelPageState(clientData){
     List pages = [
    ProjectLevelPage1(clientData: clientData,),
    const ProjectLevelPage2(),
    const ProjectLevelPage3(),
  ];
    // this.clientDataGet=clientData;
    this.pages=pages;
  }

  @override
  void initState() {
    super.initState();
    clientDataGet=widget.clientData;
    // EasyLoading.dismiss();
    getClientProfileController.getUserProfile(context: context);
    getClientProjectsController.getUpcomingProjects(context: context);
    getNewSnagDataController.getSnagData(context: context);
    getNewDeSnagDataController.getSnagData(context: context);
    getOpenedSnagDataController.getOpenedSnagData(context: context);
    getOpenedDeSnagDataController.getOpenedSnagData(context: context);
    getClosedSnagDataController.getClosedSnagData(context: context);
    getClosedDeSnagDataController.getClosedSnagData(context: context);
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

  /// List of body icon

  int current = 0;
  @override
  Widget build(BuildContext context) {
    if(mounted){
    getClientProfileController.getUserProfile(context: context);
    getClientProjectsController.getUpcomingProjects(context: context);
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
            padding: const EdgeInsets.only(bottom: 80,top: 30),
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
                    Flexible(
                        child: Text(
                      'Last Login: ${signInController.getClientProfile?.updatedat!=null ? f.format(DateTime.parse(signInController.getClientProfile!.updatedat.toString())):f.format(DateTime.now())}',
                      overflow: TextOverflow.ellipsis,
                      style: textStyleBodyText2.copyWith(
                          color: Colors.black, fontSize: 14),
                    )),
                     Flexible(
                        child: Text(
                      ' ${signInController.getClientProfile?.name}',
                      overflow: TextOverflow.ellipsis,
                      style: textStyleBodyText2.copyWith(
                          color: Colors.black, fontSize: 14),
                    )),
                    Flexible(child: Container(height: 10),),
                      if(widget.from=="client")
                       Flexible(
                        child: MaterialButton(
                          elevation: 0,
                          minWidth: 8,
                          color: Colors.greenAccent,
                          child: const Text("CHANGE PROJECT",style: TextStyle(color: Colors.black,fontSize: 8)),
                          onPressed: (){
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
             child: InkWell(
              onTap: () {
                context.pushNamed('MYPROFILEPAGE');
                },
                child:  Image.network("https://nodejs.hackerkernel.com/colab${signInController.getClientProfile?.userimage}",
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
}