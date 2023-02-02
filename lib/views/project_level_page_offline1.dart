import 'package:colab/constants/colors.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/progress_offline.dart';
import '../models/snag_offline.dart';
import '../services/local_database/local_database_service.dart';

class ProjectLevelPageOffline1 extends StatefulWidget {
  const ProjectLevelPageOffline1({Key? key,}) : super(key: key);

  @override
  State<ProjectLevelPageOffline1> createState() => _ProjectLevelPage1State();
}

class _ProjectLevelPage1State extends State<ProjectLevelPageOffline1> {

 
  List<String> items = [
    "assets/images/activites.png",
    "assets/images/snag_desnag_img.png",
  ];
  List<String> buttonText = [
    "ACTIVITIES",
    "SNAGS",
  ];
   List<String> iconText = [];
  late DatabaseProvider databaseProvider;
  List<ProgressOffline> progressData=[];
  List<SnagDataOffline> snagData=[];

  @override
  void initState() {
    databaseProvider = DatabaseProvider();
    databaseProvider.init();
    super.initState();
    fetchData();
    fetchSnagData();
  }

  Future<List<ProgressOffline>> fetchData() async {
    progressData= await databaseProvider.getMyJsonModels();
    return progressData;
  }

  Future<List<SnagDataOffline>> fetchSnagData() async {
    snagData= await databaseProvider.getSnagModel();
    return snagData;
  }

  List<String> myToolsData=[];
  
  @override
  Widget build(BuildContext context) {
    return
    ListView(
      children:[
      Center(
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: 2,
            itemBuilder: (ctx, i) {
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            child: Container(
            height: 290,
            width: 350,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50)),
            margin: const EdgeInsets.all(5),
            child: Stack(
                  children: [
                  Column(
                  children: [
                        Container(
                          height: 90,
                          width: 100,
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(items[i].toString(),
                        fit: BoxFit.fill,
                        ),
                        ),
                        if(i!=3)...{
                        Center(child: 
                        Container(
                          padding: const EdgeInsets.only(left: 5,right: 5,top: 8,bottom: 8),
                           decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50))
                            ),
                        child:
                        Stack(
                          children: [
                        Card(
                          margin: const EdgeInsets.all(8),
                          shadowColor: Colors.transparent,
                          color: AppColors.white,
                          elevation: 10,
                          child: 
                        ElevatedButton(
                          onPressed: ()
                          async{
                        if(i==0){
                            // ignore: use_build_context_synchronously
                           context.pushNamed('ACTIVITIESOFFLINE');
                         }
                         if(i==1){
                          // ignore: use_build_context_synchronously
                          context.pushNamed('SNAGSOFFLINE');
                            }
                        },
                        style: ElevatedButton.styleFrom(
                        minimumSize:const Size(10,45),
                        splashFactory: NoSplash.splashFactory,
                        backgroundColor: const Color.fromARGB(255, 29, 51, 88),
                        ),
                        child: Center(child:Text(buttonText[i],
                        textAlign: TextAlign.center,
                        style:textStyleButton.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          ),
                        )
                        )
                        ),
                        ),
                        if(i==0)...{
                         Positioned(
                              top: 40,
                              left: 10,
                              right: 10,
                              child: InkWell(
                                onTap: () {},
                                child:  const Center(
                                  child: CircleAvatar(
                                    backgroundColor:AppColors.primary,
                                    radius: 12.0,
                                    child: Text("0", style: TextStyle(color: Colors.black),),
                                  ),
                                ),
                              ),
                            ),
                        }
                        ])
                        ),
                        ),
                        },
          ],
        ),
      ],
    ),
  ),
);
},
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 200,
                ),
              ),
            )
    ]);}}