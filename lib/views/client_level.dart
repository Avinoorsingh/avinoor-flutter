import 'package:colab/controller/signInController.dart';
import 'package:colab/models/client_response.dart';
import 'package:colab/models/login_response_model.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:intl/intl.dart';
import '../network/client_project.dart';

class ClientLevelPage extends StatefulWidget {
  const ClientLevelPage({Key? key}) : super(key: key);

  @override
  State<ClientLevelPage> createState() => _ClientLevelPageState();
}

class _ClientLevelPageState extends State<ClientLevelPage> {

  final getClientProjectsController = Get.find<GetClientProject>();
  final getClientProfileController = Get.find<GetUserProfileNetwork>();
  final signInController=Get.find<SignInController>();
  TextEditingController dateInput = TextEditingController();
  List<ClientProfileData> clientData = [];
  LoginResponseModel? getProfile;
   @override
  void initState() {
    super.initState(); 
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    clientData.clear();
    // ignore: prefer_interpolation_to_compose_strings
    dateInput.text ="Date:   "+getFormatedDate(DateTime.now().toString()); 
    getClientProfileController.getUserProfile(context: context);
    getClientProjectsController.getUpcomingProjects(context: context);
  }

  var name="";
  var updatedAt="";
  final f = DateFormat('yyyy-MM-dd hh:mm a');
   getFormatedDate(date) {
      var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
      var inputDate = inputFormat.parse(date);
      var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(inputDate);
    }

  @override
  Widget build(BuildContext context) {
      return 
      GetBuilder<GetUserProfileNetwork>(builder: (_){
        final signInController=Get.find<SignInController>();
        EasyLoading.dismiss();
        return
      Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 220,
                height: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                        child: Text(
                      'Hi, ${signInController.getClientProfile?.name??''}  ',
                      overflow: TextOverflow.ellipsis,
                      style: textStyleHeadline4.copyWith(fontSize: 16),
                    )),
                    Flexible(
                        child: Text(
                      'Last Login:  ${signInController.getClientProfile?.updatedat!=null ? f.format(DateTime.parse(signInController.getClientProfile!.updatedat.toString())):f.format(DateTime.now())}  ',
                      overflow: TextOverflow.ellipsis,
                      style: textStyleBodyText2.copyWith(
                          color: Colors.black, fontSize: 14),
                    )),
                  ],
                ),
              ),
              Material(
                    borderRadius: BorderRadius.circular(100),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
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
          toolbarHeight: 80,
          backgroundColor: const Color.fromRGBO(255, 192, 0, 1),
          leading: const Icon(
            Icons.notifications,
            size: 28,
          ),
        ),
        body: 
    GetBuilder<GetClientProject>(
      builder: (_) {
        if(getClientProjectsController.getClientProjects.isNotEmpty){
      clientData=getClientProjectsController.getClientProjects.toSet().toList();
      EasyLoading.dismiss();
        }
      return 
        // SingleChildScrollView(
        //   child: 
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
          children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(12.0),
            padding: const EdgeInsets.only(left: 10,right: 10,top: 3,bottom: 3),
            decoration: BoxDecoration(
              border: Border.all(width: 0.2, color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: 
            TextField(
               decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,),
              readOnly: true,
              controller: dateInput,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                          primaryColor: const Color.fromRGBO(255, 192, 0, 1),
                          buttonTheme: const ButtonThemeData(
                            textTheme: ButtonTextTheme.primary
                          ), colorScheme: const ColorScheme.light(primary:Color.fromRGBO(255, 192, 0, 1),).copyWith(secondary: const Color(0xFF8CE7F1)),
                      ),
                     child: child!,
                    );
                     }, 
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2100));
 
                if (pickedDate != null) {
                //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  //formatted date output using intl package =>  2021-03-16
                  setState(() {
                    dateInput.text ="Date:   $formattedDate";
                     getClientProjectsController.getSelectedProjects(context: context,selectedDate: formattedDate);
                    clientData=getClientProjectsController.getClientProjects.toSet().toList();
                     //set output date to TextField value.
                  });
                } else {}
              },
             // "Date:  ${getFormatedDate(DateTime.now().toString())}",
              style: textStyleHeadline2.copyWith(fontWeight: FontWeight.w400,fontSize: 22),
            ),
          ),
              Expanded(
            child:
              Container(
                decoration: const BoxDecoration(                
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child:
                ListView(children: [
                 ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                 shrinkWrap: true,
                //  scrollDirection: Axis.vertical,
                itemCount: clientData.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: const BoxDecoration(                
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                    height: 230,
                    width: double.maxFinite,
                    child: Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      elevation:10,
                      child: Container(
                        decoration: const BoxDecoration(                
                        borderRadius:BorderRadius.all(Radius.circular(12)),
                          color: Color.fromRGBO(44, 62, 76, 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left:2,right: 2),
                          child: Stack(children: <Widget>[
                            Align(
                              alignment: Alignment.centerRight,
                              child: Stack(
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.only(left: 10, top: 5,right: 10),
                                      child: Column(
                                        children: [
                                            Row(
                                        crossAxisAlignment: CrossAxisAlignment.center, //takes the row to the top
                                        mainAxisAlignment: MainAxisAlignment.center, //Used this for spacing between the children
                                        children: [
                                          if(clientData[index].projectlogoname!=null)...{
                                          Material(
                                            borderRadius: BorderRadius.circular(100),
                                            clipBehavior: Clip.antiAliasWithSaveLayer,
                                            child: InkWell(
                                              onTap: () {
                                                context.pushNamed('PROJECTLEVELPAGE',  queryParams: {"from": "client"},extra: clientData[index]);  
                                              },
                                              child:  Image.network("https://nodejs.hackerkernel.com/colab${clientData[index].projectlogoname}",
                                                errorBuilder: (BuildContext? context, Object? exception, StackTrace? stackTrace) {
                                                    EasyLoading.dismiss();
                                                    return const Image(image: AssetImage('assets/images/user.png'),height: 60,
                                                  width: 60,
                                                  fit: BoxFit.cover);
                                                },
                                                  height: 60,
                                                  width: 60,
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          },
                                          Column(
                                            // mainAxisAlignment: MainAxisAlignment.center,
                                            // crossAxisAlignment: CrossAxisAlignment.center,  //used for aligning the children vertically
                                            children: [
                                              FittedBox(fit: BoxFit.fitWidth,child: 
                                             SizedBox(width: 200, child: Center(child: Text(clientData[index].projectname??'Building name',textAlign: TextAlign.center, style: const TextStyle(fontSize: 22,fontWeight: FontWeight.w600,color: Colors.white))))),
                                            ],
                                          ),
                                           FittedBox(fit: BoxFit.fitWidth,child: 
                                        CircularPercentIndicator( //circular progress indicator
                                          radius: 30.0, //radius for circle
                                          lineWidth: 5.0, //width of circle line
                                          animation: true, //animate when it shows progress indicator first
                                          percent: int.parse('${clientData[index].progressDepartCount??"0"}')/100, //vercentage value: 0.6 for 60% (60/100 = 0.6)
                                          center: Text("${clientData[index].progressDepartCount??"0"}%",style: const TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 12.0,color: Colors.white),
                                          ), //center text, you can set Icon as well
                                          // footer: const Text("", style:TextStyle( 
                                          //   fontWeight: FontWeight.bold, fontSize: 17.0),
                                          // ), //footer text 
                                          backgroundColor: const Color.fromARGB(255, 76, 107, 130),//backround of progress bar
                                          circularStrokeCap: CircularStrokeCap.round, //corner shape of progress bar at start/end
                                          progressColor: Colors.greenAccent, //progress bar color
                                        ),
                                           )
                                        ],),
                                        const Divider(
                                          color: Colors.white,
                                        ),
                                           FittedBox(
                                          fit: BoxFit.fitWidth,child: 
                                         Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                          Padding(
                                              padding: const EdgeInsets.only(top: 3.0,left:12,right: 12,bottom: 3.0),
                                              child: Column(children: [
                                                Text("${clientData[index].totalPwrLabourCount??'0'}",style: textStyleHeadline1.copyWith(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400)),
                                                Text("PRW",style: textStyleHeadline4.copyWith(color: Colors.white)),
                                              ])),
                                          Padding(
                                             padding: const EdgeInsets.only(top: 3.0,left:12,right: 12,bottom: 3.0),
                                              child: Column(children: [
                                                Text("${clientData[index].totalDeptLabourCount??'0'}",style: textStyleHeadline1.copyWith(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400)),
                                                Text("Dept.",style: textStyleHeadline4.copyWith(color: Colors.white)),
                                              ])),
                                          Padding(
                                              padding: const EdgeInsets.only(top: 3.0,left:12,right: 12,bottom: 3.0),
                                              child: Column(children: [
                                                Text("${clientData[index].totalMisscLabourCount??'0'}",style: textStyleHeadline1.copyWith(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),),
                                                Text("Misc.",style: textStyleHeadline4.copyWith(color: Colors.white)),
                                              ])),
                                          Padding(
                                              padding: const EdgeInsets.only(top: 3.0,left:25,right: 20,bottom: 3.0),
                                              child: Column(children: [
                                                Text("${clientData[index].areaOfConernTotal??'0'}",style: textStyleHeadline1.copyWith(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400)),
                                                Text("Act. Count",style: textStyleHeadline4.copyWith(color: Colors.white)),
                                              ])),
                                               Padding(
                                              padding: const EdgeInsets.only(left: 30,right: 5,bottom: 5,top: 3.0),
                                              child: Column(children: [
                                                Text("--",style: textStyleHeadline1.copyWith(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400)),
                                                Text("BCWP",style: textStyleHeadline4.copyWith(color: Colors.white)),
                                              ])),
                                        ]), 
                                           ),  
                                            const Divider(
                                          color: Colors.white,
                                        ),
                                        const Padding(padding: EdgeInsets.all(5)),                                        
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                       children: [
                                        Column(
                                          children: [
                                            Row(
                                              children:  [
                                              SizedBox(width: 100,child: 
                                              Text("Pending Areas of Concern.",style: textStyleBodyText3.copyWith(fontWeight: FontWeight.bold,color: Colors.white),)
                                              ),
                                              const SizedBox(width: 10,),
                                              FittedBox(child: 
                                              Container(
                                                width: 50.0,
                                                height: 35.0,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5.0),
                                                  color: Colors.white,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    '${clientData[index].areaOfConern??'0'}',
                                                    style: textStyleBodyText1,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                              ),
                                            ],
                                            )
                                          ],
                                       ),
                                       Column(
                                          children: [
                                            Row(
                                              children:  [
                                                const Padding(padding: EdgeInsets.all(10)),
                                              SizedBox(width: 80,
                                              child: 
                                              Text("New Snag",style: textStyleBodyText3.copyWith(fontWeight: FontWeight.bold,color: Colors.white),)
                                              ),
                                              const SizedBox(width: 10,),
                                              FittedBox(child: 
                                              Container(
                                                width: 50.0,
                                                height: 35.0,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5.0),
                                                  color: Colors.white,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    '${clientData[index].snagCount??'0'}',
                                                    style: textStyleBodyText1,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                              ),
                                            ],
                                            )
                                          ],
                                       )
                                       ],
                                      )
                                    ],
                                   ))
                              ],
                            ),
                          )
                        ]),
                      ),
                    ),
                  ),
                );
              }),
              // const SizedBox(height: 200,),
              ])
           ),
       ),
      //  SizedBox(height: 200,)
         ]
        // )
         );
         }
         )
         );
           });
  }
}