import 'dart:convert';
import 'package:colab/constants/colors.dart';
import 'package:colab/network/area_of_concern_network.dart';
import 'package:colab/network/labourData/labour_data_network.dart';
import 'package:colab/network/progress_network.dart';
import 'package:colab/network/quality_network.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import '../controller/signInController.dart';
import '../network/client_project.dart';

// ignore: must_be_immutable
class ProjectLevelPage1 extends StatefulWidget {
  ProjectLevelPage1({Key? key,required this.clientData, required this.index}) : super(key: key);
  dynamic clientData;
  dynamic index;

  @override
  State<ProjectLevelPage1> createState() => _ProjectLevelPage1State();
}

class _ProjectLevelPage1State extends State<ProjectLevelPage1> {
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
  final getClientProjectsController = Get.find<GetClientProject>();
   final List<ChartData> chartData = [   
            ChartData('David', 60,"60.0\n Balance %",Colors.green,),
            ChartData('Steve', 40,"40.0\n Work \nDone %",AppColors.primary),
        ];
    List<String> items = [
    "assets/images/labour_data_img.png",
    "assets/images/activites.png",
    "assets/images/quality_checklist_img.png",
    "assets/images/snag_desnag_img.png",
    "assets/images/other_360.png",
    "assets/images/other_360.png",
    "assets/images/other_360.png",
  ];
  List<String> buttonText = [
    "LABOUR DATA",
    "ACTIVITIES",
    "QUALITY CHECKLIST",
    "SNAG",
    "360 IMAGE",
    "AREAS OF CONCERN",
    "DRAWING MASTER",
  ];
   List<String> iconText = [];
 late List<ExpenseData> _chartData=[];
 late String _selectedDate;

  @override
  void initState() {
    _selectedDate=DateFormat('yyyy-MM-dd').format(DateTime.now());
    // _chartData = getChartData(_selectedDate);
    getClientProfileController.getUserProfile(context: context);
     getClientProfileController.getUserProfile(context: context);
    getLabourDataContractorListController.getContractorListData(context: context);
    getLabourDataOfSelectedContractorController.getSelectedContractorData(context: context);
    getNewSnagDataController.getSnagData(context: context);
    getNewDeSnagDataController.getSnagData(context: context);
    getOpenedSnagDataController.getOpenedSnagData(context: context);
    getOpenedDeSnagDataController.getOpenedSnagData(context: context);
    getClosedSnagDataController.getClosedSnagData(context: context);
    getClosedDeSnagDataController.getClosedSnagData(context: context);
    getClientProjectsController.getSelectedProjects(context:context);
    super.initState();
  }

  List<String> myToolsData=[];

   _selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                primaryColor: AppColors.primary,
                buttonTheme: const ButtonThemeData(
                textTheme: ButtonTextTheme.primary
              ), colorScheme: const ColorScheme.light(primary:AppColors.primary,).copyWith(secondary: const Color(0xFF8CE7F1)),
            ),
            child: child!,
          );
        }, 
        initialDate:DateTime.parse(_selectedDate,),
        firstDate: DateTime(1990),
        lastDate: DateTime(2132));
    if (picked != null) {
      setState(() {
        _selectedDate = DateFormat('yyyy-MM-dd').format(picked);
      });
       _chartData = await getChartData(_selectedDate);
       setState(() {});
    }
  }
  
  @override
  Widget build(BuildContext context) {
     if(mounted){
    setState(() {});
    }
  final getNewSnagDataController=Get.find<GetNewSnag>();
  final getLabourDataContractorListController=Get.find<GetLabourDataContractor>();
  final getLabourDataOfSelectedContractorController=Get.find<GetSelectedContractorData>();
  final getLabourDataTodayController=Get.find<GetLabourDataToday>();
  final getNewDeSnagDataController=Get.find<GetNewDeSnag>();
  final getNewQualityDataController=Get.find<GetNewCheckList>();
  final getCompletedSiteProgressDataController=Get.find<GetCompletedSiteProgress>();
  final getInQualitySiteProgressDataController=Get.find<GetInEqualitySiteProgress>();
  final getOnGoingSiteProgressDataController=Get.find<GetOnGoingSiteProgress>();
  final getAreaOfConcernDataController=Get.find<GetAreaOfConcern>();
  final getOpenedQualityDataController=Get.find<GetOpenedCheckList>();
  final getClosedQualityDataController=Get.find<GetClosedCheckList>();
  final getOpenedDeSnagDataController=Get.find<GetOpenedDeSnag>();
  final getClosedDeSnagDataController=Get.find<GetClosedDeSnag>();
  return GetBuilder<GetUserProfileNetwork>(
      builder: (_){
      final signInController=Get.find<SignInController>();
      getClientProjectsController.getSelectedProjects(context:context);
     EasyLoading.dismiss();
    return
    signInController.getProjectData?.clientid!=null?
    ListView(
      children:[
      Center(
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: 7,
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
                            await getLabourDataContractorListController.getContractorListData(context: context);
                            await getLabourDataOfSelectedContractorController.getSelectedContractorData(context: context);
                            await getLabourDataTodayController.getContractorListData(context: context, date:DateFormat('yyyy-MM-dd').format(DateTime.now()));
                            // ignore: use_build_context_synchronously
                            context.pushNamed('LABOURDATA');
                         }
                         if(i==1){
                          await getCompletedSiteProgressDataController.getCompletedListData(context: context);
                          await getOnGoingSiteProgressDataController.getOnGoingListData(context: context);
                          await getInQualitySiteProgressDataController.getInEqualityListData(context: context);
                          // ignore: use_build_context_synchronously
                          context.pushNamed('ACTIVITIES');
                            }
                         if(i==2){
                          await getNewQualityDataController.getCheckListData(context: context);
                          await getOpenedQualityDataController.getCheckListData(context: context);
                          await getClosedQualityDataController.getCheckListData(context: context);
                          // ignore: use_build_context_synchronously
                             context.pushNamed('QUALITYCHECKLIST');
                         }
                          if(i==4){
                          // ignore: use_build_context_synchronously
                          context.pushNamed('360IMAGE');
                         }
                         if(i==5){
                          await getAreaOfConcernDataController.getAreaOfConcernData(context: context);
                          // ignore: use_build_context_synchronously
                          context.pushNamed('AREASOFCONCERN');
                         }
                          if(i==6){
                          // ignore: use_build_context_synchronously
                          context.pushNamed('DRAWING');
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
                        if(i==5)...{
                          Positioned(
                              top: 40,
                              left: 10,
                              right: 10,
                              child: InkWell(
                                onTap: () {},
                                child:  Center(
                                  child: CircleAvatar(
                                    backgroundColor:AppColors.primary,
                                    radius: 12.0,
                                    child: Text(signInController.getProjectData!.areaOfConernTotal!=null?signInController.getProjectData!.areaOfConernTotal.toString():"0", style:const TextStyle(color: Colors.black),),
                                  ),
                                ),
                              ),
                            ),
                        },
                        if(i!=5)...{
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
                         if(i==3)...{
                          FittedBox(child:
                        Row(
                          children:[ 
                            GestureDetector(
                              onTap: ()async{
                                await getNewSnagDataController.getSnagData(context: context);
                                await getOpenedSnagDataController.getOpenedSnagData(context: context);
                                await getClosedSnagDataController.getClosedSnagData(context: context);
                               // ignore: use_build_context_synchronously
                                context.pushNamed('SNAGS');
                              },
                              child: 
                        Container(
                           decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50))
                            ),
                        child:
                          Stack(children: [
                        Card(
                          margin: const EdgeInsets.all(8),
                          shadowColor: Colors.transparent,
                          color: AppColors.white,
                          elevation: 10,
                          child: 
                        MaterialButton(onPressed: () async {
                          await getNewSnagDataController.getSnagData(context: context);
                          await getOpenedSnagDataController.getOpenedSnagData(context: context);
                          await getClosedSnagDataController.getClosedSnagData(context: context);
                          // ignore: use_build_context_synchronously
                          context.pushNamed('SNAGS');
                        },
                        height: 45,
                        color: const Color.fromARGB(255, 29, 51, 88),
                        child: Center(child:Text(buttonText[i],
                        textAlign: TextAlign.center,
                        style:textStyleButton.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          ),
                        )
                      )
                    ),
                  ),
                Positioned(
                  top: 40,
                  left: 10,
                  right: 10,
                  child: InkWell(
                    onTap: () {},
                    child:  Center(
                    child: CircleAvatar(
                        backgroundColor:AppColors.primary,
                        radius: 12.0,
                        child: Text((signInController.getProjectData!.snagTotalCount!=null?signInController.getProjectData!.snagTotalCount!-1:"0").toString(),style: const TextStyle(color: Colors.black),),
                                  ),
                                ),
                              ),
                            ),
                          ]
                        )
                      ),
                    ),
                    GestureDetector(
                        onTap: () async{
                        await getNewDeSnagDataController.getSnagData(context: context);
                        await getOpenedDeSnagDataController.getOpenedSnagData(context: context);
                        await getClosedDeSnagDataController.getClosedSnagData(context: context);
                        // ignore: use_build_context_synchronously
                        context.pushNamed('DESNAGS');
                        },
                        child: 
                         Container(
                           decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50))
                            ),
                        child:
                         Stack(children: [
                        Card(
                          margin: const EdgeInsets.all(8),
                          shadowColor: Colors.transparent,
                          color: AppColors.white,
                          elevation: 10,
                          child: 
                          MaterialButton(onPressed: ()
                         async {
                        await getNewDeSnagDataController.getSnagData(context: context);
                        await getOpenedDeSnagDataController.getOpenedSnagData(context: context);
                        await getClosedDeSnagDataController.getClosedSnagData(context: context);
                            // ignore: use_build_context_synchronously
                            context.pushNamed('DESNAGS');
                        },
                        height: 45,
                        color: const Color.fromARGB(255, 29, 51, 88),
                        child: Center(child:Text("DESNAG",
                        textAlign: TextAlign.center,
                        style:textStyleButton.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          ),
                        )
                      )
                    ),
                  ),
                  Positioned(
                        top: 40,
                        left: 10,
                        right: 10,
                              // bottom: 20,
                              // left: 310,
                              //MediaQuery.of(context).size.width/1.22,
                        child: InkWell(
                          onTap: () {},
                          child:  const Center(
                                child: CircleAvatar(
                                backgroundColor:AppColors.primary,
                                radius: 12.0,
                                child: Text("0",style: TextStyle(color: Colors.black),),
                                  ),
                                ),
                              ),
                            ),
                         ]
                        )
                      ),
                    ),
                  ]
                ),
              )
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
            ),
               const SizedBox(height: 10,),
                Container(
                  padding: const EdgeInsets.only(left: 10,right: 10,top: 8,bottom: 8),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50))
                    ),
                    child: 
                        Card(
                           shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0), //<-- SEE HERE
                        ),
                          elevation: 3,
                          child: 
                        Column(children: [
                          const SizedBox(height: 10,),
                          Center(child: Text("WORK SUMMERY",style: textStyleBodyText1.copyWith(fontWeight: FontWeight.bold),),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Row(children: const [Icon(Icons.square,color: Colors.green,size: 10), Text(" Work Done %    ",style: TextStyle(fontSize: 10),)],),
                              Row(children: const [Icon(Icons.square,color:AppColors.primary,size: 10), Text(" Balance %    ",style: TextStyle(fontSize: 10),)],)
                            ],
                          )
                        ],
                      ),
                      Stack(
                            alignment: Alignment.center,
                            children:[
                            Column(
                            children: [Text("Colab",style: textStyleBodyText1,),
                             const Text("Tools",style: TextStyle(color: Colors.grey),),
                            ]
                          ),
                        SfCircularChart(
                           series: <CircularSeries>[
                            // Renders doughnut chart
                            DoughnutSeries<ChartData, String>(
                                explode: true,
                                explodeAll: true,
                                explodeOffset: "0.9",
                                dataSource: chartData,
                                innerRadius: "65",
                                pointColorMapper:(ChartData data,  _) => data.color,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                dataLabelMapper: (ChartData data, _) => data.z,
                                dataLabelSettings: const DataLabelSettings(
                                    // Renders the data label
                                    textStyle: TextStyle(fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white),
                                    isVisible: true
                                )
                              )
                            ]
                          ),
                        ]
                      ),
                    ]
                  ),
                )
              ),
                const SizedBox(height: 10,),
                Container(
                  padding: const EdgeInsets.only(left: 10,right: 10,top: 8,bottom: 8),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50))
                    ),
                    child: 
                        Card(
                           shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                          elevation: 3,
                          child: 
                        Column(children: [
                          const SizedBox(height: 10,),
                          Center(child: Text("WORK TREND",style: textStyleBodyText1.copyWith(fontWeight: FontWeight.bold),),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width/4.5,
                                height: 30,
                                margin:const EdgeInsets.only(right: 20,top: 10),
                                decoration: BoxDecoration(
                                 border: Border.all(
                                  color: Colors.grey,
                                  width: 0.5,
                                ),
                              borderRadius:const BorderRadius.all(Radius.circular(5))
                              ),child:
                              ElevatedButton(
                                onPressed: _selectDate,
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  foregroundColor: Colors.grey,
                                  backgroundColor: Colors.white),
                                child: 
                                FittedBox(child: 
                                Text(_selectedDate.toString(),style: textStyleBodyText2,),
                                )
                                ),
                              )
                          ],),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [],
                              )
                          ],
                        ),
                        Stack(
                          children:[
                        SfCartesianChart(
                          legend: Legend(
                            isVisible: true, 
                            position: LegendPosition.bottom
                            ),
                            zoomPanBehavior: ZoomPanBehavior(  
                              enablePanning: true,
                              zoomMode: ZoomMode.xy,
                              enablePinching: true,
                              enableMouseWheelZooming: true,
                              enableSelectionZooming: true
                           ), 
                          primaryXAxis: DateTimeAxis(
                          interval: 1,
                          intervalType: DateTimeIntervalType.days,
                          enableAutoIntervalOnZooming: true,
                          minimum: DateTime.parse(_selectedDate).subtract(const Duration(days: 7)),
                          maximum: DateTime.parse(_selectedDate),
                          isVisible: true,
                          opposedPosition: true,
                          dateFormat: DateFormat('dd'),
                          ),
                          primaryYAxis: NumericAxis(
                          decimalPlaces: 2, 
                          enableAutoIntervalOnZooming: true
                          ),
                          axes: [
                          NumericAxis(
                          name: 'secondary',
                          decimalPlaces: 2, 
                          opposedPosition: true,
                          enableAutoIntervalOnZooming: true
                          ),
                          ],
                        series: <ChartSeries>[
                        StackedColumnSeries<ExpenseData, DateTime>(
                        color:AppColors.primaryButtonColor,
                        dataSource: _chartData,
                        xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                        yValueMapper: (ExpenseData exp, _) => exp.son,
                        name: 'IN HOUSE',
                        dataLabelSettings: const DataLabelSettings(
                        showZeroValue: false, 
                        textStyle: TextStyle(color: Colors.red),         
                        isVisible: true, alignment: ChartAlignment.near)),
                          StackedColumnSeries<ExpenseData, DateTime>(
                        color: Colors.green,
                        dataSource: _chartData,
                        xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                        yValueMapper: (ExpenseData exp, _) => exp.father,
                        name: 'BCWP',
                        dataLabelSettings: const DataLabelSettings( 
                        showZeroValue: false, 
                        textStyle: TextStyle(color: Colors.red),         
                        isVisible: true,
                        alignment: ChartAlignment.near
                            )
                          ),
                        StackedColumnSeries<ExpenseData, DateTime>(
                        color:AppColors.primary,
                        dataSource: _chartData,
                        xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                        yValueMapper: (ExpenseData exp, _) => exp.mother,
                        name: 'PRW',
                        dataLabelSettings: const DataLabelSettings(  
                        showZeroValue: false, 
                        textStyle: TextStyle(color: Colors.red),      
                        isVisible: true,
                        alignment: ChartAlignment.near
                        ),
                        ),
                        LineSeries<ExpenseData, DateTime>(
                        yAxisName: 'secondary',
                        color: Colors.red,
                        dataSource: _chartData,
                        xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                        yValueMapper: (ExpenseData exp, _) => exp.daughter,
                        name: 'MISC',
                        dataLabelSettings: const DataLabelSettings(    
                        textStyle: TextStyle(color: Colors.red),          
                        isVisible: true, alignment: ChartAlignment.near
                        ),
                        markerSettings: const MarkerSettings(color: Colors.red,
                        shape: DataMarkerType.circle,isVisible: true)
                        ),
                        ]
                      )
                    ]
                  ),
                ]
              ),
            )
          )
        ]
      ): Container();
    }
  );
  }
}


class ChartData {
        ChartData(this.x, this.y, this.z,this.color);
            final String x;
            final double y;
            final String z;
            final Color color;
    }
 List<ExpenseData> chartData2=[];
     getChartData1(String selectedDate)async {
    chartData2.clear();
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var token=sharedPreferences.getString('token');
     var projectID=sharedPreferences.getString('projectIdd');
     var clientID=sharedPreferences.getString('client_id');
    //  print(clientID);
    //  print(projectID);
    //  print(token);
    //  print(selectedDate);
      try {
      var getDataUrl=Uri.parse('http://nodejs.hackerkernel.com/colab/api/prw_inhouse_misc_chart_data');
        var res=await http.post(
            getDataUrl,
            headers:{
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
            body: {
              "client_id":clientID.toString(),
              "project_id":projectID.toString(),
              "prw_misc_chart_date":selectedDate.toString(),
              }
          );
         if (kDebugMode) {
          print(res.body);
         }
         if(chartData2.isEmpty){
         for(int i=0;i<jsonDecode(res.body)['obj']['dates'].length; i++){
          DateTime expenseCategory =(DateFormat('dd MMM yyyy').parse(jsonDecode(res.body)['obj']['dates'][i]));
          num father = num.parse(jsonDecode(res.body)['obj']['inHouse'][i].toString() == ""? "0":jsonDecode(res.body)['obj']['inHouse'][i].toString());
          num mother = num.parse(jsonDecode(res.body)['obj']['misc'][i].toString() == "" ? "0" :jsonDecode(res.body)['obj']['misc'][i].toString());
          num son = num.parse(jsonDecode(res.body)['obj']['prw'][i].toString() == "" ? "0" :jsonDecode(res.body)['obj']['prw'][i].toString());
          num daughter = num.parse(jsonDecode(res.body)['obj']['rate'][i].toString() == "" ? "0" :jsonDecode(res.body)['obj']['rate'][i].toString());
          chartData2.add(ExpenseData(expenseCategory, father, mother, son, daughter));
         }
         }
        } catch(e){
          if (kDebugMode) {
            print(e);
          }
        }
        return chartData2;
  }
    Future<List<ExpenseData>> getChartData(String selectedDate) async {
      await getChartData1(selectedDate);
      final signInController=Get.find<SignInController>();
      final List<ExpenseData> chartData = chartData2;
      signInController.getChartData=chartData;
      signInController.getChartData=chartData;
    return chartData;
  }

class ExpenseData {
  ExpenseData(
      this.expenseCategory, this.father, this.mother, this.son, this.daughter);
  final DateTime expenseCategory;
  final num father;
  final num mother;
  final num son;
  final num daughter;
}