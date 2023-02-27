import 'dart:io';

import 'package:colab/services/container.dart';
import 'package:colab/services/container2.dart';
import 'package:colab/services/textfield.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../constants/colors.dart';

// ignore: must_be_immutable
class GetCompletedSiteProgress extends StatefulWidget {
  GetCompletedSiteProgress({Key? key, this.from, this.editModel }) : super(key: key);

 // ignore: prefer_typing_uninitialized_variables
 final from;
 dynamic editModel;
  @override
  State<GetCompletedSiteProgress> createState() => _ProgressState();
}

class _ProgressState extends State<GetCompletedSiteProgress> {

  final locationController = TextEditingController();
  final subLocationController = TextEditingController();
  final subSubLocationController = TextEditingController();
  final activityController = TextEditingController();
  final activityHeadController = TextEditingController();
  final otherLocationController = TextEditingController();
  final remarkController=TextEditingController();
  final assignedToController=TextEditingController();
  final statusController = TextEditingController();
  final quantityController=TextEditingController();
  final priorityController=TextEditingController();
  TextEditingController dateInput=TextEditingController();
  final uomName=TextEditingController();
  final type=TextEditingController();
  List<bool> isCardEnabled2 = [];
  List<String> toggleList=[
    "Labour Supply",
    "PRW",
   ];
  TextEditingController achivedQuantity=TextEditingController();
  TextEditingController comulativeQuantity=TextEditingController(); 
  var _sliderValue=0.0;
  bool? update=false;
  List<String> contractorList=["Select Contractor Name"];
  TextEditingController contractorController=TextEditingController();
  String dropdownvalue = 'Select Contractor Name';  
  File?  _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    setState(() {
      _selectedImage =File(image!.path);
    });
  }

  @override
  void initState() {
    super.initState(); 
    EasyLoading.dismiss();
    locationController.text=widget.editModel?.locationName??"";
    subLocationController.text=widget.editModel?.subLocationName??"";
    subSubLocationController.text=widget.editModel?.subSubLocationName??"";
    activityController.text=widget.editModel?.activity??"";
    activityHeadController.text=widget.editModel?.activityHead??"";
    quantityController.text=widget.editModel?.totalQuantity.toString()??"";
    uomName.text=widget.editModel?.uomName??"";
    achivedQuantity.text=widget.editModel?.achivedQuantity.toDouble().toString()??"";
    comulativeQuantity.text=widget.editModel?.cumulativeQuantity.toDouble().toString()??"";
    _sliderValue=double.parse(widget.editModel?.progressPercentage.toString()??"0.0");
    remarkController.text=widget.editModel?.remarks??"";
    type.text=widget.editModel?.type.toString()??"";
    type.text=="0"?priorityController.text="Labour Supply":priorityController.text="PRW";
    dateInput.text= DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.editModel?.createdAt??DateTime.now()));
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
            InkWell(
              onTap:() async {
                if(update==true){
                DateTime? pickedDate = await showDatePicker(
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
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100));
                if (pickedDate != null) {
                  String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                  setState(() {
                    dateInput.text =formattedDate;
                  });
                } else {}
                }
              },
              child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
             Text(dateInput.text,style: textStyleBodyText1.copyWith(fontSize: 18),),
             const Icon(Icons.calendar_month),
            ])
            )
        ),
        //done
        Column(
              children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
               ),),
           SizedBox(
            height: 65,child: 
          ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(top: 15,bottom: 0,left: 0,right: 0),
          itemCount: 2,
          itemBuilder: (BuildContext context, int index){
            isCardEnabled2.add(false);
            return GestureDetector(
                onTap: (){
                  if(update==true){
                  isCardEnabled2.replaceRange(0, isCardEnabled2.length, [for(int i = 0; i < isCardEnabled2.length; i++)false]);
                  isCardEnabled2[index]=true;
                  priorityController.text=(toggleList[index]);
                  setState(() {});
                  }
                  else{}
                },
                child: SizedBox(
                  height: 20,
                  width: MediaQuery.of(context).size.width/2.2,
                  child: Container(
                   decoration: BoxDecoration(
                    borderRadius:const BorderRadius.all(Radius.circular(5)),
                     color:toggleList[index].toString()==priorityController.text? AppColors.primary:AppColors.white,
                     border: Border.all(width: 1.2,color: AppColors.primary,),
                    ),
                    child: Center(
                      child: Text(toggleList[index],textAlign: TextAlign.center,
                        style: TextStyle(
                          color: toggleList[index].toString()==priorityController.text?Colors.black:AppColors.primary,
                          fontSize: 16
                        ),
                      ),
                    ),
                  ),
                )
            );
          }),
          ),
          ]),
          CustomContainer(child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Center(child: Text(locationController.text.isEmpty?"Location Unavailable":locationController.text,style: textStyleBodyText1.copyWith(fontSize: 18),),),
              const Icon(Icons.arrow_drop_down_outlined,size: 30,color: Colors.grey,)
            ])
          ),
            CustomContainer(child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Center(child: Text(subLocationController.text.isEmpty?"SubLocation Unavailable":'${subLocationController.text} / ${subSubLocationController.text}',style: textStyleBodyText1.copyWith(fontSize: 18))),
             const Icon(Icons.arrow_drop_down_outlined,size: 30,color: Colors.grey,)
            ])
          ),
          CustomContainer(child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
             Center(child: Text(activityHeadController.text.isEmpty?"Activity / Activity Head Unavailable":'${activityHeadController.text} / ${activityController.text}',style: textStyleBodyText1.copyWith(fontSize: 18),),),
            const Icon(Icons.arrow_drop_down_outlined,size: 30,color: Colors.grey,)
            ])
          ),
          CustomContainer2(
            child:
          Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Quantity: ${_sliderValue.toInt()} %",style: textStyleBodyText1.copyWith(fontSize: 18),)
            ],),
            SizedBox(height: 50,
            width: 350,
            child:
            FittedBox(
              fit: BoxFit.cover,
              child: 
            Slider(
              divisions: 100,
              activeColor: AppColors.primary,
              focusNode: null,
              inactiveColor: AppColors.lightGrey,
                value: _sliderValue,
                onChanged: (newValue) {
                  setState(() {
                   if(update==true){
                    _sliderValue = newValue;
                   }
                   else{}
                  });
                },
                min: 0,
                max: 100,
              ),
            ),
            ),
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              Text("${comulativeQuantity.text} ${uomName.text}",style: textStyleBodyText1),
              Text("",style: textStyleBodyText1,),
              Text("",style: textStyleBodyText1,),
              Text("",style: textStyleBodyText1,),
              Text("",style: textStyleBodyText1,),
              Text("${quantityController.text} ${uomName.text}",style: textStyleBodyText1)
            ],),
            const SizedBox(height: 30,),
            Container(
              margin:const EdgeInsets.only(left: 20,right:20),
              child: 
            Row(children: [
               Text("TOTAL QUANTITY: ${quantityController.text}",style: textStyleBodyText1),
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
                  child:Center(child: Text(achivedQuantity.text,style: textStyleBodyText1,),),
                ),
                ),
              ),
              const SizedBox(height: 10,),
              Center(child: Text("Achived",style: textStyleBodyText4,),),
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
                  child:Center(child: Text(comulativeQuantity.text,style: textStyleBodyText1,),),
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
            if(update==true)...{
            if(priorityController.text=='Labour Supply')...{
            CustomContainer2(
           child: Column(children: [
            const SizedBox(height: 20,),
            const Text("LABOUR",style: TextStyle(color: Colors.grey,fontSize: 16),),
           DropdownButtonFormField(
              value: contractorList[0],
              icon: const Padding( 
              padding: EdgeInsets.only(left:20),
              child:Icon(Icons.arrow_drop_down_outlined,size: 30)
             ), 
            iconEnabledColor: Colors.grey,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 17
            ), 
          dropdownColor: AppColors.white,
          decoration: const InputDecoration(enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
            ),
              isExpanded: true,
              items: contractorList.map((String items){
                return
                DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) async {
                setState(() {
                  contractorController.text=newValue!;
                  dropdownvalue = newValue;
                   });
              },
            ),
            const Text("Over-Time",style: TextStyle(color: Colors.grey,fontSize: 16),),
            const SizedBox(height: 20,),
            ])
          ),
            }
            },
            if(update==true)...{
              if(priorityController.text=="PRW")...{
                  CustomContainer2(
            child:
          Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("LABOUR",style: textStyleBodyText1.copyWith(fontSize: 18),)
            ],),
             Container(
           margin: const EdgeInsets.only(left:20,right:20,top: 20),
           padding: const EdgeInsets.only(bottom: 10,),
            child: 
           DropdownButtonFormField(
              value: contractorList[0],
             icon: const Padding( 
              padding: EdgeInsets.only(left:20),
              child:Icon(Icons.arrow_drop_down_outlined,size: 30)
             ), 
            iconEnabledColor: Colors.grey,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 17
            ), 
          dropdownColor: AppColors.white,
          decoration: const InputDecoration(enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1),
      ),
    ),
              isExpanded: true,
              items: contractorList.map((String items){
                return
                DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) async {
                setState(() {
                  contractorController.text=newValue!;
                  dropdownvalue = newValue;
                   });
              },
            ),
          ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Over-Time",style: textStyleBodyText1.copyWith(fontSize: 16),)
            ],),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                    width: 120,
                    height: 40,
                    child:Center(child: Text('Skilled',style: textStyleBodyText1.copyWith(fontSize: 16,color: Colors.grey),),),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                  height: 40,
                  width: 120,
                  child: 
                 TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Labour count',
                      hintStyle:const TextStyle(fontSize: 14),
                      enabledBorder:OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                          width: 1, color:Colors.grey[300]!), //<-- SEE HERE
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                          width: 1, color:Colors.grey[300]!), //<-- SEE HERE
                    ),
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    ),
                  )
                ),
              ],
            ),
                 Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                    width: 120,
                    height: 40,
                    child:Center(child: Text('Unskilled',style: textStyleBodyText1.copyWith(fontSize: 16,color: Colors.grey),),),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                  height: 40,
                  width: 120,
                  child: 
                 TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Labour count',
                      hintStyle:const TextStyle(fontSize: 14),
                      enabledBorder:OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                          width: 1, color:Colors.grey[300]!), //<-- SEE HERE
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                          width: 1, color:Colors.grey[300]!), //<-- SEE HERE
                    ),
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    ),
                  )
                ),
              ],
            )
          ],) 
            ),
              }
            },
          // const SizedBox(height: 20,),
            CustomContainer2(
            child: 
            Column(children: [
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("Remark",style: textStyleBodyText1,),
              ],),),
               const SizedBox(height: 10,),
               CustomTextField3(enabled:update==true? true:false,controller: remarkController,hintText: "Enter here",)
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
            if(_selectedImage != null)
            Container(
              margin:const EdgeInsets.only(top: 20),
              child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Image.file(_selectedImage!,height: 200,width: 100,),
            ],),),
            const SizedBox(height: 20,),
             Container(
              margin: const EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(onTap: (){
                        showDialog(
                   context: context,
                   builder: (BuildContext context) {
                     return SimpleDialog(
                      alignment: Alignment.center,
                       children: <Widget>[
                        Text("      Choose",style: textStyleHeadline3.copyWith(fontWeight: FontWeight.normal),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                         SimpleDialogOption(
                            child: 
                            Column(
                                children: <Widget>[
                                  
                                  const SizedBox(width: 10),
                                  const Icon(Icons.image,size: 70,color: Colors.grey,),
                                  Text("Gallery",style: textStyleBodyText1.copyWith(color: Colors.grey),),
                                ],
                              ),
                             onPressed: () {
                               // Call the _pickImage function with the gallery source
                               _pickImage(ImageSource.gallery);
                               // Close the modal pop-up
                               Navigator.pop(context);
                             },
                           ),
                          SimpleDialogOption(
                            child: Column(
                              children: <Widget>[
                                const SizedBox(width: 10),
                                 const Icon(Icons.camera_alt,size: 70,color: Colors.grey,),
                                Text("Camera",style:textStyleBodyText1.copyWith(color: Colors.grey),),
                              ],
                            ),
                             onPressed: () {
                               // Call the _pickImage function with the camera source
                               _pickImage(ImageSource.camera);
                               // Close the modal pop-up
                               Navigator.pop(context);
                             },
                           ),
                        ]),
                           SimpleDialogOption(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                const SizedBox(width: 10),
                                Text("Cancel",style:textStyleBodyText1.copyWith(color: AppColors.primary),),
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
                  )
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
