import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../controller/signInController.dart';
import '../network/client_project.dart';
import '../theme/text_styles.dart';

class OpenedDeSnags extends StatefulWidget {
  const OpenedDeSnags({Key? key}) : super(key: key);

  @override
  State<OpenedDeSnags> createState() => _NewSnagState();
}

bool show=false;
late var tapped;

class _NewSnagState extends State<OpenedDeSnags> {
  final getSnag = Get.find<GetNewSnag>();
  List<String?> locationName=[];
  List<String?> subLocationName=[];
  List<String?> subSubLocationName=[];
  List<String?> dueDates=[];
  List<String?> createdDates=[];
  List<String?> remark=[];
  List<String?> deSnagRemark=[];
 
 @override
 void initState(){
  super.initState();
  getSnag.getSnagData(context: context);
 }

  @override
  Widget build(BuildContext context) {
    var outputFormat = DateFormat('dd/MM/yyyy');;
    return GetBuilder<GetOpenedSnag>(builder: (_){
      final signInController=Get.find<SignInController>();
     print(signInController.getSnagDataOpenedList!.data);
     if(signInController.getSnagDataOpenedList!.data!.isNotEmpty && subLocationName.isEmpty){
      for(int i=0;i<signInController.getSnagDataOpenedList!.data!.length;i++){
       subLocationName.add(signInController.getSnagDataOpenedList!.data![i].subLocation!.subLocationName);
       subSubLocationName.add(signInController.getSnagDataOpenedList!.data![i].subSubLocation!.subSubLocationName);
       locationName.add(signInController.getSnagDataOpenedList!.data![i].location!.locationName);
       remark.add(signInController.getSnagDataOpenedList!.data![i].remark);
       deSnagRemark.add(signInController.getSnagDataOpenedList!.data![i].deSnagRemark);
       dueDates.add(signInController.getSnagDataOpenedList!.data![i].dueDate);
       createdDates.add(signInController.getSnagDataOpenedList!.data![i].createdAt);
      }
     }
    EasyLoading.dismiss();
    return 
    Scaffold(
    body: 
    Container(margin: const EdgeInsets.only(top: 110),
    child:
    ListView(
      children: [
        Padding(padding: const EdgeInsets.only(left: 10,right: 10,),
            child:
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: subLocationName.length,
              itemBuilder: (BuildContext context, int index) {
                return 
                FittedBox(
                          fit: BoxFit.fitWidth,
                          child: 
                          Column(
                            children:[
                              Center(child: 
                        Stack(
                          clipBehavior: Clip.none,
                          children: [ 
                            InkWell(
                            splashColor: Colors.transparent,
                              onTap: () {
                                setState(() {
                                  show=!show;
                                  tapped=index;
                                });
                              },
                              child:
                            Card(
                              borderOnForeground: true,
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
                              ),
                              elevation: 0,
                              child:
                              Container(
                                padding: const EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1),
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                // height: 0,
                                width: 335,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${subLocationName[index]} / ${subSubLocationName[index]}",style: textStyleHeadline4.copyWith(fontSize: 14),),
                                    Text("${locationName[index]}",style: textStyleHeadline4.copyWith(fontSize: 14),),
                                    const SizedBox(height: 20,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      Text("Date: ${outputFormat.format(DateTime.parse(createdDates[index]!))}",style: textStyleHeadline4.copyWith(fontSize: 10,color: Colors.grey),),
                                      Text("Due Date: ${outputFormat.format(DateTime.parse(dueDates[index]!))}",style: textStyleHeadline4.copyWith(fontSize: 10,color: Colors.grey),),
                                      ],
                                    ),
                                    const SizedBox(height: 10,),
                                  ],),
                            )),
                            ),
                            Positioned(
                              top: 10,
                              bottom: 20,
                              left: 320,
                              //MediaQuery.of(context).size.width/1.22,
                              child: InkWell(
                                onTap: () {},
                                child:  const Center(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.red,
                                    radius: 15.0,
                                    child: Text("0",style: TextStyle(color: Colors.black),),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                              ),
                              if(show==true && index==tapped)
                        Container(
                            padding: const EdgeInsets.only(left: 10,right: 10,top: 0),
                            margin: const EdgeInsets.only(bottom: 20),
                            height: 50,
                            width: 330,
                            decoration: BoxDecoration(
                                    color:  Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                            child:
                            InkWell(
                              onTap: (){
                                context.pushNamed('SNAGDETAIL');
                              },
                              child: 
                              Column(children: [
                              const  SizedBox(height: 10,),
                             Row(children: [
                              Text("Snag Remark: ",style: textStyleHeadline4,),
                              Text("${remark[index]}",style: textStyleBodyText2,overflow: TextOverflow.ellipsis,),
                             ],),
                              Row(children: [
                              Text("De-Snag Remark: ",style: textStyleHeadline4,),
                              Text(deSnagRemark[index] ?? "",style: textStyleBodyText2,overflow: TextOverflow.ellipsis,),
                              ]),
                             ]),
                            ),
                          )]
                          )
                        );
                    }
                  )
        ),
      ],
    )),
   );
      }
      );
  }
}