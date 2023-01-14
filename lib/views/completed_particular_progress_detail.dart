import 'package:colab/services/container.dart';
import 'package:colab/services/container2.dart';
import 'package:colab/services/textfield.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../constants/colors.dart';

// ignore: must_be_immutable
class CompletedParticularProgressDetail extends StatefulWidget {
  CompletedParticularProgressDetail({Key? key, this.from, this.concernModel }) : super(key: key);

 // ignore: prefer_typing_uninitialized_variables
 final from;
 dynamic concernModel;
  @override
  State<CompletedParticularProgressDetail> createState() => _ProgressState();
}

class _ProgressState extends State<CompletedParticularProgressDetail> {

  final locationController = TextEditingController();
  final subLocationController = TextEditingController();
  final subSubLocationController = TextEditingController();
  final activityController = TextEditingController();
  final activityHeadController = TextEditingController();
  final otherLocationController = TextEditingController();
  final descriptionController=TextEditingController();
  final assignedToController=TextEditingController();
  final statusController = TextEditingController();
  var _sliderValue=100.0;

  @override
  void initState() {
    super.initState(); 
    statusController.text=widget.concernModel?.status??"";
    locationController.text=widget.concernModel?.locationName??"";
    subLocationController.text=widget.concernModel?.subLocationName??"";
    subSubLocationController.text=widget.concernModel?.subSubLocationName??"";
    activityController.text=widget.concernModel?.activity??"";
    activityHeadController.text=widget.concernModel?.activityHead??"";
    otherLocationController.text=widget.concernModel?.otherLocation??"";
    descriptionController.text=widget.concernModel?.description??"";
    assignedToController.text=widget.concernModel?.assigneeName??"";
  }
   

  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor:AppColors.primary,
      title: Text("Completed Site Progress",style: textStyleHeadline3.copyWith(color: Colors.black,fontWeight: FontWeight.w400),),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          CustomContainer(
            child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
             Text("30/12/2022",style: textStyleBodyText1.copyWith(fontSize: 18),),
             const Icon(Icons.calendar_month),
            ])
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20,top: 20,),
                width: MediaQuery.of(context).size.width/2.25,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.3,color: AppColors.primary),
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primary,
                ),
                child:Center(child:Text('Labour Supply',style: textStyleBodyText1,),),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20,right: 20),
                width: MediaQuery.of(context).size.width/2.25,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.3,color: AppColors.primary),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                ),
                child:Center(child: Text('PRW',style: textStyleBodyText1.copyWith(color: AppColors.primary),),),
              ),
            ],
          ),
          CustomContainer(child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Center(child: Text(locationController.text.isEmpty?"D Series (D01- D06)":locationController.text,style: textStyleBodyText1.copyWith(fontSize: 18),),),
              const Icon(Icons.arrow_drop_down_circle_outlined,color: Colors.grey,)
            ])
          ),
            CustomContainer(child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Center(child: Text(subLocationController.text.isEmpty?"Sub Level/D-01":'${subLocationController.text} / ${subSubLocationController.text}',style: textStyleBodyText1.copyWith(fontSize: 18))),
             const Icon(Icons.arrow_drop_down_circle_outlined,color: Colors.grey,)
            ])
          ),
          CustomContainer(child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
             Center(child: Text(activityHeadController.text.isEmpty?"Sub Structure/Excavation":'${activityHeadController.text} / ${activityController.text}',style: textStyleBodyText1.copyWith(fontSize: 18),),),
            const Icon(Icons.arrow_drop_down_circle_outlined,color: Colors.grey,)
            ])
          ),
          CustomContainer2(
            child:
          Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Quantity: $_sliderValue %",style: textStyleBodyText1.copyWith(fontSize: 18),)
            ],),
            Slider(
              divisions: 10,
              activeColor: AppColors.primary,
              focusNode: null,
              inactiveColor: AppColors.primary,
                value: _sliderValue,
                onChanged: (newValue) {
                  setState(() {
                    _sliderValue = newValue;
                  });
                },
                min: 0,
                max: 100,
              ),
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              Text("0 CUM",style: textStyleBodyText1),
              Text("",style: textStyleBodyText1,),
              Text("",style: textStyleBodyText1,),
              Text("",style: textStyleBodyText1,),
              Text("",style: textStyleBodyText1,),
              Text("267 CUM",style: textStyleBodyText1)
            ],),
            const SizedBox(height: 30,),
            Container(
              margin:const EdgeInsets.only(left: 20,right:20),
              child: 
            Row(children: [
               Text("TOTAL QUANTITY: 267",style: textStyleBodyText4),
            ],)
            ),
            const SizedBox(height: 30,),
            Container(
              margin:const EdgeInsets.only(left: 20,right:20),
              child: 
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(children: [
              Card(
                elevation: 4,
                color: AppColors.primary,
                child: 
                SizedBox(
                  width: 120,
                  child: 
                  Padding(
                  padding:const EdgeInsets.all(8.0),
                  child:Center(child: Text('80.1',style: textStyleBodyText4,),),
                ),
                ),
              ),
              const SizedBox(height: 10,),
              Center(child: Text("Archived",style: textStyleBodyText4,),),
              ]),
              Column(children: [
                Card(
                elevation: 4,
                color: AppColors.primary,
                child: 
                SizedBox(
                  width: 120,
                  child: 
                  Padding(
                  padding:const EdgeInsets.all(8.0),
                  child:Center(child: Text('267.0',style: textStyleBodyText4,),),
                ),
                ),
              ),
              const SizedBox(height: 10,),
              Center(child: Text("Cumulative",style: textStyleBodyText4,),),
              ])
            ],
          )
            ),
            
          ],) 
            ),
          const SizedBox(height: 20,),
            CustomContainer2(
            child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("Remark",style: textStyleBodyText1,),
              ],),),
               const SizedBox(height: 10,),
               CustomTextField3(enabled: false,controller: otherLocationController,hintText: "Enter here",)
          ])
            ),
            CustomContainer2(child:
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("DEBIT TO",style: textStyleBodyText1,),
              ],),),
               CustomContainer(child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Center(child: Text(assignedToController.text.isEmpty?"":assignedToController.text,style: textStyleBodyText1,),),
              const Icon(Icons.arrow_drop_down_circle_outlined,color: Colors.grey,)
            ])
          ),
          ])
            ),
            const SizedBox(height: 20,),
            Container(
              margin: const EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Card(
                    color: AppColors.primary,
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.edit),
                        ),
                        Text('EDIT IMAGE   '),
                      ],
                    ),
                  ),
                    Card(
                    color: AppColors.primary,
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.cloud_download),
                        ),
                        Text('SAVE IMAGE   '),
                      ],
                    ),
                  )
                ],
              ),
            ),
             const SizedBox(height: 20,),
          ]
        ),
      )
    );
  }
}
