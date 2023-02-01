import 'package:colab/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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

  @override
  void initState(){
    super.initState();
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
                      // if(widget.from=="client")
                      //  Flexible(
                      //   child: ElevatedButton(
                      //     style: ElevatedButton.styleFrom(elevation: 0,
                      //     splashFactory: NoSplash.splashFactory,
                      //     backgroundColor: Colors.greenAccent),
                      //     child: const Text("CHANGE PROJECT", style: TextStyle(color: Colors.black,fontSize: 8)),
                      //     onPressed: () async {
                      //     context.pushNamed('CLIENTLEVELPAGE');
                      //   },)
                      //  )
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
          // Expanded(
          //     child: pages[current],
          // ),
        ],
      ),
      ),
      )
     )
    );
  }
}