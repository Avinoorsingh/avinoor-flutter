import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:colab/services/container.dart';
import 'package:colab/services/container2.dart';
import 'package:colab/services/textfield.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';
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
  final List<TextEditingController> _controllers3 = [];
  final List<TextEditingController> _controllers4=[];
  List<String> trade=[];
  List<String> trade2=[];
  List<String> labourSupplyContractorName=[];
  List<List> contractorLabourDetails=[];
  TextEditingController dateInput=TextEditingController();
  final pwrContractorId=TextEditingController();
  final pwrContractorName=TextEditingController();
  final previousContractorId=TextEditingController();
  final previousContractorName=TextEditingController();
  final uomName=TextEditingController();
  final type=TextEditingController();
  List<bool> isCardEnabled2 = [];
  List<String> toggleList=[
    "Labour Supply",
    "PRW",
   ];
  TextEditingController achivedQuantity=TextEditingController();
  TextEditingController comulativeQuantity=TextEditingController(); 
  Map<String, List<String>> labourNames = {};
  Map<String, List<String>> labourCounts = {};
  final debitToController=TextEditingController(); 
  TextEditingController networkImage=TextEditingController();
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
    getContractorName();
    locationController.text=widget.editModel?.locationName??"";
    subLocationController.text=widget.editModel?.subLocationName??"";
    subSubLocationController.text=widget.editModel?.subSubLocationName??"";
    activityController.text=widget.editModel?.activity??"";
    activityHeadController.text=widget.editModel?.activityHead??"";
    quantityController.text=widget.editModel?.totalQuantity.toString()??"";
    debitToController.text=widget.editModel?.debetContactor.toString()??"";
    uomName.text=widget.editModel?.uomName??"";
    networkImage.text=widget.editModel.fileName??"";
    achivedQuantity.text=widget.editModel?.achivedQuantity.toDouble().toString()??"";
    comulativeQuantity.text=widget.editModel?.cumulativeQuantity.toDouble().toString()??"";
    _sliderValue=double.parse(widget.editModel?.progressPercentage.toString()??"0.0");
    remarkController.text=widget.editModel?.remarks??"";
    type.text=widget.editModel?.type.toString()??"";
    type.text=="0"?priorityController.text="Labour Supply":priorityController.text="PRW";
    dateInput.text= DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.editModel?.createdAt??DateTime.now()));
  }

   getContractorName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var tokenValue=sharedPreferences.getString('token');
    var res=await http.get(
         Uri.parse('${Config.getPwrClientList}${widget.editModel.linkActivityId}/${widget.editModel?.clientId}/${widget.editModel?.projectId}'),
         headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $tokenValue",
         }
      );
    if(res.body.isNotEmpty){
      print("********************************");
      print(res.body);
      print('${Config.getPwrClientList}${widget.editModel.linkActivityId}/${widget.editModel.clientId}/${widget.editModel.projectId}');
      print("********************************");     
      if(jsonDecode(res.body)['success']==true){
        pwrContractorName.text=jsonDecode(res.body)['data'][0]['contractor_name'];
      }
    }
    var res2=await http.get(
         Uri.parse('${Config.getProgressLabourLinkingData}${widget.editModel.dailyId}'),
         headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $tokenValue",
         }
      );
    if(priorityController.text=="PRW"){
      if(jsonDecode(res2.body)['data2']!=null){
      for(int i=0;i<jsonDecode(res2.body)['data2'].length;i++){
        _controllers3.add(TextEditingController(text:jsonDecode(res2.body)['data2'][i]['labour_count']!=null?jsonDecode(res2.body)['data2'][i]['labour_count'].toString():"0"));
        trade.add(jsonDecode(res2.body)['data2'][i]['trade'] ?? "Unskilled");
      } 
      }
    }
    if(priorityController.text=="Labour Supply"){
      if(jsonDecode(res2.body)['mainData']!=null && jsonDecode(res2.body)['mainData'].isNotEmpty){
          for (var contractor in jsonDecode(res2.body)['mainData']) {
            if (!labourNames.containsKey(contractor["contractor_name"])) {
                labourNames[contractor["contractor_name"]] = [];
                labourCounts[contractor["contractor_name"]]=[];
              }
              for(int j=0;j<contractor['labourDetails'].length;j++){
                  labourNames[contractor["contractor_name"]]!.add(contractor['labourDetails'][j]['name']);
                  labourCounts[contractor["contractor_name"]]!.add(contractor['labourDetails'][j]['time'].toString());
                  }
            }
       for(int j=0;j<jsonDecode(res2.body)['mainData'].length;j++){
        for(int i=0;i<jsonDecode(res2.body)['mainData'][j]['labourDetails'].length;i++){
          _controllers4.add(TextEditingController(text:jsonDecode(res2.body)['mainData'][j]['labourDetails'][i]['time'] ?? "0"));
          trade2.add(jsonDecode(res2.body)['mainData'][j]['labourDetails'][i]['name']??"N/A");
          } 
         labourSupplyContractorName.add(jsonDecode(res2.body)['mainData'][j]['contractor_name']);
        }
      }
    }
    setState(() {});
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
          const SizedBox(height: 10,),
            if(priorityController.text=='Labour Supply')...{
          const SizedBox(height: 10,),
          ListView.builder(
          padding: const EdgeInsets.only(bottom: 10),
          physics:const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: labourSupplyContractorName.length,
          itemBuilder: (context, outerIndex) {
            // finalList.add(outerIndex);
          return 
          Column(children: [
          CustomContainer2(
            child:
          Column(children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("LABOUR", style: textStyleBodyText1.copyWith(fontSize: 18),)
            ],),
            if((priorityController.text=='Labour Supply' || priorityController.text=="Misc." ) && labourSupplyContractorName.isNotEmpty)...{
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Over-Time', style: textStyleBodyText1.copyWith(color: Colors.grey),)],),
                Column(children: [
            Container(
            margin: const EdgeInsets.only(top: 20,bottom: 10),
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration :  BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ],
              ),
            child:Center(child:Text(labourSupplyContractorName[outerIndex], style: textStyleBodyText1,)),
              ),
              ListView.builder(
              physics:const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: labourNames.values.toList()[outerIndex].length,
              itemBuilder: (context, innerIndex){
              return 
                Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  SizedBox(
                    height: 65,
                    width: 250,
                    child:
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    ),
                    width: 200,
                    child: DropdownButton(
                    onTap: null,
                    isExpanded: true,
                    underline: Container(),
                    value: labourNames.values.toList()[outerIndex][innerIndex],
                    items: labourNames.values.toList()[outerIndex]
                    .map((value) => DropdownMenuItem(
                    value: value,
                    child: Padding(padding:const EdgeInsets.only(left: 10),child: Text(value,style: textStyleBodyText1,)),
                    ))
                    .toList(),
                    onChanged: null,
                    )
                      )
                    ),
                    Container(           
                      width: MediaQuery.of(context).size.width/7,
                      height: 55,
                      decoration :  BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(1),
                      ),],
                      ),
                      child:Center(child:
                      Text(labourCounts.values.toList()[outerIndex][innerIndex],
                      style: textStyleBodyText1,)
                      ),
                      )
                ]),
                ]);})
               ])
          },
          if((priorityController.text=="Labour Supply"||priorityController.text=="Misc.") && contractorController.text.isNotEmpty)...{
          }
          ],
          )
          ),
          ],
          );
          }),
          if(priorityController.text!='Labour Supply' && priorityController.text!="Misc." && trade.isNotEmpty)...{
           Column(children: [
          CustomContainer2(
            child:
          Column(children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("LABOUR",style: textStyleBodyText1.copyWith(fontSize: 18),)
            ],),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Over-Time', style: textStyleBodyText1.copyWith(color: Colors.grey),)],),
                Column(children: [
          CustomContainer(
            child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Center(child: Text(pwrContractorName.text.isNotEmpty?pwrContractorName.text:"No Contractor Selected 1",style: textStyleBodyText1),),
             const Icon(Icons.arrow_drop_down_outlined,size: 30,color: Colors.grey,)
            ])
          ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Over-Time", style: textStyleBodyText1.copyWith(fontSize: 16),),
            ],),
            const SizedBox(height: 20,),
            SizedBox(
            // height:100,
            width: MediaQuery.of(context).size.width,
            child:
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: trade.length,
                itemBuilder: (context, index) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    SizedBox(
                      height: 65,
                      width: 250,
                      child:
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    ),
                    width: 200,
                    child: DropdownButton(
                    onTap: null,
                    isExpanded: true,
                    underline: Container(),
                    value: trade[index],
                    items: trade
                    .map((value) => DropdownMenuItem(
                    value: value,
                    child: Padding(padding:const EdgeInsets.only(left: 10),child: Text(value,style: textStyleBodyText1,)),
                    ))
                    .toList(),
                    onChanged: null,
                    )
                      )
                    ),
                    Container(           
                      width: MediaQuery.of(context).size.width/7,
                      height: 55,
                      decoration :  BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(1),
                      ),],
                      ),
                      child:Center(child:
                      Text(_controllers3[index].text,
                      style: textStyleBodyText1,)
                      ),
                      )
                    ,]);
                    },
                    ),
                    ),
                  ])
          ]))])},
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
            Center(child: Text(debitToController.text.isEmpty?"":debitToController.text,style: textStyleBodyText1,),),
              const Icon(Icons.arrow_drop_down_outlined,size: 30,color: Colors.grey,)
            ])
          ),
          ])
            ),
          if(networkImage.text.isNotEmpty)
            Container(
              margin:const EdgeInsets.only(top: 20),
              child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Image.network('https://nodejs.hackerkernel.com/colab${networkImage.text}',height: 200,width: 100,),
            ],),),
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
            // ignore: equal_elements_in_set
            const SizedBox(height: 20,),
            }
          ]
        ),
      )
    );
  }
}
