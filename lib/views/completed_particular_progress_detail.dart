import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:colab/config.dart';
import 'package:colab/models/daily_progress.dart';
import 'package:colab/services/container.dart';
import 'package:colab/services/container2.dart';
import 'package:colab/services/textfield.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/colors.dart';
import 'package:http/http.dart' as http;

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
  final progressDataController = TextEditingController();
  final labourORprw = TextEditingController();
  final quantityController = TextEditingController();
  final achievedController = TextEditingController();
  final cumulativeController = TextEditingController();
  final remarkController = TextEditingController();
  final uOfMNameController=TextEditingController();
  final totalQuantity=TextEditingController();
  final image=TextEditingController();
  final progressDailyId=TextEditingController();
  final progressId=TextEditingController();
  DailyProgress? progressData;
  var _sliderValue=0.0;
  File?  _selectedImage;

   Future<void> _getData() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token=sharedPreferences.getString('token');
    // Set up the POST request body
    Map<String, String> requestHeaders={
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };
    // Perform the get request
    var response = await http.get(
      Uri.parse('${Config.getDailyProgressData}${widget.concernModel.progressId}'),
      headers: requestHeaders,
    );
    // Update the data with the response data
    setState(() {
     progressData = DailyProgress.fromJson(jsonDecode(response.body));
     if(progressData!.data!=null){
    locationController.text=progressData!.data![0].locationName??"";
    subLocationController.text=progressData!.data![0].subLocationName??"";
    subSubLocationController.text=progressData!.data![0].subSubLocationName??"";
    activityController.text=progressData!.data![0].activity??"";
    activityHeadController.text=progressData!.data![0].activityHead??"";
    assignedToController.text=progressData!.data![0].debetContactor??"";
    quantityController.text=progressData!.data![0].totalQuantity!=null?progressData!.data![0].totalQuantity.toString():"";
    achievedController.text=progressData!.data![0].achivedQuantity!=null?progressData!.data![0].achivedQuantity.toString():"";
    cumulativeController.text=progressData!.data![0].cumulativeQuantity!=null?progressData!.data![0].cumulativeQuantity.toString():"";
    remarkController.text=progressData!.data![0].remarks!=null?progressData!.data![0].remarks.toString():"";
    uOfMNameController.text=progressData!.data![0].uomName!=null?progressData!.data![0].uomName.toString():"";
    _sliderValue=progressData!.data![0].progressPercentage!=null?double.parse(progressData!.data![0].progressPercentage.toString()):0.0;
    totalQuantity.text=progressData!.data![0].totalQuantity!=null?progressData!.data![0].totalQuantity.toString():"";
    image.text=progressData!.data![0].fileName!=null?progressData!.data![0].fileName.toString():"";
    progressDailyId.text=progressData!.data![0].dailyId!=null?progressData!.data![0].dailyId.toString():"";
    progressId.text=progressData!.data![0].progressId!=null?progressData!.data![0].progressId.toString():"";
    EasyLoading.dismiss();
     }
     else if(progressData!.data==null){
      EasyLoading.dismiss();
     }
    });
  }

 
 @override
 void initState(){
  super.initState();
  EasyLoading.show(maskType: EasyLoadingMaskType.black);
    // Get the initial data
    _getData();
 }   

  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor:AppColors.primary,
      title: Text("Completed Site Progress", style: textStyleHeadline3.copyWith(color: Colors.black,fontWeight: FontWeight.w400),),
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
                child:Center(child:Text('Labour Supply', style: textStyleBodyText1,),),
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
            Center(child: Text(locationController.text.isEmpty?"":locationController.text,style: textStyleBodyText1.copyWith(fontSize: 18),),),
              const Icon(Icons.arrow_drop_down_outlined,size: 30,color: Colors.grey,)
            ])
          ),
            CustomContainer(child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Center(child: Text(subLocationController.text.isEmpty?"":'${subLocationController.text} / ${subSubLocationController.text}',style: textStyleBodyText1.copyWith(fontSize: 18))),
             const Icon(Icons.arrow_drop_down_outlined,size: 30,color: Colors.grey,)
            ])
          ),
          CustomContainer(child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
             Center(child: Text(activityHeadController.text.isEmpty?"":'${activityHeadController.text} / ${activityController.text}',style: textStyleBodyText1.copyWith(fontSize: 18),),),
            const Icon(Icons.arrow_drop_down_outlined,size: 30,color: Colors.grey,)
            ])
          ),
          const SizedBox(height: 10,),
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
              Text("0 ${uOfMNameController.text}",style: textStyleBodyText1),
              Text("",style: textStyleBodyText1,),
              Text("",style: textStyleBodyText1,),
              Text("",style: textStyleBodyText1,),
              Text("",style: textStyleBodyText1,),
              Text("${totalQuantity.text} ${uOfMNameController.text}",style: textStyleBodyText1)
            ],),
            const SizedBox(height: 30,),
            Container(
              margin:const EdgeInsets.only(left: 20,right:20),
              child: 
            Row(children: [
               Text("TOTAL QUANTITY: ${totalQuantity.text}",style: textStyleBodyText4),
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
                  child:Center(child: Text(achievedController.text,style: textStyleBodyText4,),),
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
                  child:Center(child: Text(cumulativeController.text,style: textStyleBodyText4,),),
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
               CustomTextField3(enabled: false,controller: remarkController,hintText: "Enter here",)
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
              const Icon(Icons.arrow_drop_down_outlined,size: 30,color: Colors.grey,)
            ])
          ),
          ])
            ),
            if(image.text.isNotEmpty && _selectedImage==null)...{
            const SizedBox(height: 20,),
            Center(child: 
             GestureDetector(
                onTap: () async {
                  await showDialog(
                  useSafeArea: true,
                  context: context,
                  builder: (_) => imageDialog('Snag Image','https://nodejs.hackerkernel.com/colab${image.text}' , context));
                  },
            child: 
             Container(
                margin:const EdgeInsets.only(top: 10,bottom: 10),
                height: 100,
                width: 100,
                child:
                  FittedBox(
                    fit: BoxFit.fill,
                    child: Image.network("https://nodejs.hackerkernel.com/colab${image.text}", 
                    height: 10,
                    width: 10,
                  ),
                ),
              ),
             ),
            ),
            },
              if(_selectedImage!=null)...{
            const SizedBox(height: 20,),
            Center(child: 
             GestureDetector(
                onTap: () async {},
            child: 
             Container(
                margin:const EdgeInsets.only(top: 10,bottom: 10),
                height: 100,
                width: 100,
                child:
                  FittedBox(
                    fit: BoxFit.fill,
                    child: Image.file(_selectedImage!, 
                    height: 10,
                    width: 10,
                  ),
                ),
              ),
             ),
            ),
            },
            const SizedBox(height: 20,),
            Container(
              margin: const EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async {
                          showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return SimpleDialog(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Text("      Choose", style: textStyleHeadline3.copyWith(fontWeight: FontWeight.normal),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                SimpleDialogOption(
                                  child: 
                                  Column(
                                        children: <Widget>[     
                                          const SizedBox(width: 10),
                                          const Icon(Icons.image,size: 70, color: Colors.grey,),
                                          Text("Gallery", style: textStyleBodyText1.copyWith(color: Colors.grey),),
                                        ],
                                      ),
                                    onPressed: () async {
                                      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
                                      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                      var token=sharedPreferences.getString('token');
                                      FormData formData=FormData();
                                      var dio = Dio();
                                      formData.fields.add(MapEntry('progress_daily_id', progressDailyId.text));
                                      formData.fields.add(MapEntry('progress_id', progressId.text));
                                      formData.files.add(
                                      MapEntry("progress_image", await MultipartFile.fromFile((image!.path), filename: 'progress_image')));
                                      await dio.post("http://nodejs.hackerkernel.com/colab/api/update_progress_image",
                                      data:formData,
                                      options: Options(
                                          followRedirects: false,
                                          validateStatus: (status){
                                            return status! < 500;
                                          },
                                          headers: {
                                            "authorization": "Bearer ${token!}",
                                            "Content-type": "application/json",
                                          },
                                        ),
                                      );
                                      setState(() {
                                         _selectedImage=File(image.path);
                                          }
                                        );
                                      // ignore: use_build_context_synchronously
                                      Navigator.pop(context);
                                    },
                                  ),
                                  SimpleDialogOption(
                                    child: Column(
                                      children: <Widget>[
                                        const SizedBox(width: 10),
                                        const Icon(Icons.camera_alt, size: 70,color: Colors.grey,),
                                        Text("Camera", style:textStyleBodyText1.copyWith(color: Colors.grey),),
                                      ],
                                    ),
                                    onPressed: () async {
                                      var image = await ImagePicker().pickImage(source: ImageSource.camera);
                                      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                      var token=sharedPreferences.getString('token');
                                      FormData formData=FormData(); 
                                      var dio = Dio();
                                      formData.fields.add(MapEntry('progress_daily_id', progressDailyId.text));
                                      formData.fields.add(MapEntry('progress_id', progressId.text));
                                      formData.files.add(
                                      MapEntry("progress_image", await MultipartFile.fromFile((image!.path), filename: 'progress_image')));
                                      await dio.post("http://nodejs.hackerkernel.com/colab/api/update_progress_image",
                                      data:formData,
                                      options: Options(
                                          followRedirects: false,
                                          validateStatus: (status){
                                            return status! < 500;
                                          },
                                          headers:{
                                            "authorization": "Bearer ${token!}",
                                            "Content-type": "application/json",
                                          },
                                        ),
                                      );
                                      setState(() {
                                        _selectedImage=File(image.path);
                                          }
                                        );
                                      // ignore: use_build_context_synchronously
                                      Navigator.pop(context);
                                    },
                                  ),
                                ]),
                              SimpleDialogOption(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    const SizedBox(width: 10),
                                    Text("Cancel", style:textStyleBodyText1.copyWith(color: AppColors.primary),),
                                  ],
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                     },
                    child: 
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


Widget imageDialog(text, path, context) {
return Dialog(
  backgroundColor: Colors.transparent,
  elevation: 0,
  child: Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop('dialog');
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text("CANCEL",style: TextStyle(color: AppColors.white),),
          ),
        ],
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height/1.2,
        child: 
        InteractiveViewer(
        minScale: 0.1,
        maxScale: 10.0,
        child:
        Image.network(
          '$path',
          fit: BoxFit.contain,
        ),
        ),
      ),
    ],
  ),
);}