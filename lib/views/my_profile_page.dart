import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sweetalert/sweetalert.dart';
import '../controller/signInController.dart';
import '../network/client_project.dart';
import '../services/helper/dependency_injector.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final fullNameController = TextEditingController();
  final emergencyContactPersonController = TextEditingController();
  final emergencyContactMobileNumberController = TextEditingController();
  final emergencyAlternateMobileNumberController= TextEditingController();

  File? image;
  CroppedFile? croppedFile;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  croppedFile = await ImageCropper().cropImage(
    sourcePath: image!.path,
    aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
    ],
    uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Edit Image',
          toolbarColor: Colors.white,
          toolbarWidgetColor: const Color.fromRGBO(255, 192, 0, 1),
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      IOSUiSettings(
        title: 'Edit Image',
      ),
      WebUiSettings(
        context: context,
      ),
    ],
  );
  var imageTemp = File(croppedFile!.path);
setState(() => this.image = imageTemp);
    } catch(e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
  }
  
    @override
  void initState() {
    super.initState(); 
    DependencyInjector.initializeControllers();
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
  }
 
   void clearCache()async{
    EasyLoading.show();
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.clear();
       // ignore: use_build_context_synchronously
       context.pushNamed('LOGINPAGE');
      }

  bool iconPressed=false;
  @override
  Widget build(BuildContext context) {
     return 
      GetBuilder<GetUserProfileNetwork>(builder: (_){
        final signInController=Get.find<SignInController>();
        fullNameController.text=signInController.getClientProfile?.name??"";
        emergencyContactPersonController.text=signInController.getClientProfile?.emergencyname??"";
        emergencyAlternateMobileNumberController.text=signInController.getClientProfile?.altmobileno??"";
        emergencyContactMobileNumberController.text=signInController.getClientProfile?.emergencymobileno??"";
        EasyLoading.dismiss();
        return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: const Color.fromRGBO(255, 192, 0, 1),
      title: Text("My Profile",style: textStyleHeadline3.copyWith(color: Colors.black,fontWeight: FontWeight.w400),),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Card(
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            ),
            shadowColor: Colors.black,
            margin: const EdgeInsets.only(left: 20,right: 20,top: 15),
            elevation: 5,
            child: 
             Column(
              children: [
                const Padding(padding: EdgeInsets.all(10)),
                Center(child: Text("Profile",style: textStyleHeadline2,),),
                const SizedBox(height: 10,),
                Padding(padding: const EdgeInsets.only(left: 10,right: 10),
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text("Personal Detail",style: textStyleHeadline3.copyWith(fontWeight: FontWeight.normal),),
                  IconButton(onPressed: (){
                    setState(() {
                      iconPressed=true;
                    });
                  }, 
                  icon: const Icon(Icons.edit_sharp, color: Colors.blue,size: 28,)),
                ],),
                ),
                const Divider(color: Colors.blueGrey,),
                Center(
                  child:
                  Stack(children: [
                   Material(
                    borderRadius: BorderRadius.circular(100),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                      onTap: iconPressed==true?() {pickImage();}:(){},
                      child: image==null?
                       Image.network("https://nodejs.hackerkernel.com/colab${signInController.getClientProfile?.userimage}",
                       height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                            errorBuilder: (BuildContext? context, Object? exception, StackTrace? stackTrace) {
                            EasyLoading.dismiss();
                            return const Image(image: AssetImage('assets/images/user_fill.png'),
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover);}):
                          Image.file(image!,height: 60,width: 60,),
                    ),
                  ),
                  if(iconPressed==true)...{
                  const Positioned(
                    bottom: -12,
                    right: -7,
                    child:CircleAvatar(foregroundColor: Colors.grey,backgroundColor: Colors.white,child: Icon(Icons.camera_alt,),)
                  ),
                  }
                  ]
                  )
                ),
                  const SizedBox(height: 15,),
            Container(
                    margin:const EdgeInsets.all(10),
                    child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
             Row(
                children: 
                [
                Text("Full Name",
                style: TextStyle(fontSize:iconPressed==true?18:14,fontWeight:FontWeight.w400,color: Colors.black),),
                ],
                ),
                const SizedBox(height: 5,),
                if(iconPressed==true)...{
                TextField(
                readOnly: true,
                controller: fullNameController,
                decoration:const InputDecoration( 
                  contentPadding: EdgeInsets.all(10),
                  disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1,color: Colors.grey)),
                  fillColor: Color.fromARGB(255, 212, 208, 208),
                hintText: "",
                focusedBorder:OutlineInputBorder(
                borderSide: BorderSide(
                      width:1, color:Color.fromARGB(255, 212, 208, 208)), //<-- SEE HERE
                    ) ,
                enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                      width: 1, color:Color.fromARGB(255, 212, 208, 208)), //<-- SEE HERE
                    ),
                  ),
               style: const TextStyle(fontSize:14,color: Colors.black,fontWeight: FontWeight.normal),
              //  controller: emailController,
            ),
                },
              if(iconPressed==false)...{
                Row(children: [
                Text(fullNameController.text,style: const TextStyle(fontWeight: FontWeight.bold,fontSize:16),)
                ])
              },
              const SizedBox(height: 15,),
             Row(
                  children: 
                [
                Text("Emergency Contact Person",
              style: TextStyle(fontSize:iconPressed==true?18:14,fontWeight:FontWeight.w400,color: Colors.black),),
                ],
                ),
               const SizedBox(height: 5,),
              if(iconPressed==true)...{
              TextField(
                controller: emergencyContactPersonController,
                decoration:const InputDecoration( 
                  contentPadding: EdgeInsets.all(10),
                  disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1,color: Colors.grey)),
                  fillColor: Color.fromARGB(255, 212, 208, 208),
                hintText: "Emergency Contact Person",
                focusedBorder:OutlineInputBorder(
                borderSide: BorderSide(
                      width: 1, color:Color.fromARGB(255, 212, 208, 208)), //<-- SEE HERE
                    ) ,
                enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                      width:1, color:Color.fromARGB(255, 212, 208, 208)), //<-- SEE HERE
                    ),
                  ),
               style: const TextStyle(fontSize:14,color: Colors.black,fontWeight: FontWeight.normal),
              //  controller: emailController,
            ),
              },
               if(iconPressed==false)...{
                Row(children: [
                Text(emergencyContactPersonController.text,style: const TextStyle(fontWeight: FontWeight.bold,fontSize:16),)
                ])
              },
              const SizedBox(height: 15,),
             Row(
                children: 
                 [
                Text("Emergency Contact Mobile Number",
                style: TextStyle(fontSize:iconPressed==true?18:14,fontWeight:FontWeight.w400,color: Colors.black),),
                ],
                ),
               const SizedBox(height: 5,),
               if(iconPressed==true)...{
                TextField(
                controller: emergencyContactMobileNumberController,
                keyboardType: TextInputType.phone,
                decoration:const InputDecoration( 
                  contentPadding: EdgeInsets.all(10),
                  disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1,color: Colors.grey)),
                  fillColor: Color.fromARGB(255, 212, 208, 208),
                hintText: "Emergency Contact Mobile Number",
                focusedBorder:OutlineInputBorder(
                borderSide: BorderSide(
                      width:1, color:Color.fromARGB(255, 212, 208, 208)), //<-- SEE HERE
                    ) ,
                enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                      width: 1, color:Color.fromARGB(255, 212, 208, 208)), //<-- SEE HERE
                    ),
                  ),
               style: const TextStyle(fontSize:14,color: Colors.black,fontWeight: FontWeight.normal),
              //  controller: emailController,
            ),
               },
                if(iconPressed==false)...{
                Row(children: [
                Text(emergencyContactMobileNumberController.text,style: const TextStyle(fontWeight: FontWeight.bold,fontSize:16),)
                ])
              },
              const SizedBox(height: 15,),
             Row(
                  children: 
                 [
                Text("Emergency Alternate Mobile Number",
                style: TextStyle(fontSize:iconPressed==true?18:14,fontWeight:FontWeight.w400,color: Colors.black),),
                ],
                ),
               const SizedBox(height: 5,),
               if(iconPressed==true)...{
               TextField(
                controller: emergencyAlternateMobileNumberController,
                keyboardType: TextInputType.phone,
                decoration:const InputDecoration( 
                  contentPadding: EdgeInsets.all(10),
                  disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1,color: Colors.grey)),
                  fillColor: Color.fromARGB(255, 212, 208, 208),
                hintText: "Emergency Alternate Mobile Number",
                 focusedBorder:OutlineInputBorder(
                borderSide: BorderSide(
                      width:1, color:Color.fromARGB(255, 212, 208, 208)), //<-- SEE HERE
                    ) ,
                enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                      width: 1, color:Color.fromARGB(255, 212, 208, 208)), //<-- SEE HERE
                    ),
                  ),
               style: const TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.normal),
              //  controller: emailController,
            ),
               },
             if(iconPressed==false)...{
                Row(children: [
                Text(emergencyAlternateMobileNumberController.text,style: const TextStyle(fontWeight: FontWeight.bold,fontSize:16),)
                ])
              },
            if(iconPressed==true)...{
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: const LinearGradient(
                    begin: Alignment(-0.95, 0.0),
                    end: Alignment(1.0, 0.0),
                    colors: [Color.fromARGB(173, 57, 54, 54),Color.fromARGB(250, 19, 14, 14)],
                    stops: [0.0, 1.0],
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100)),),
                    backgroundColor: Colors.transparent,
                      disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
                      shadowColor: Colors.transparent,
                  ),
                  onPressed: ()async{
                    setState(() {
                      iconPressed=false;
                    });
                  },
                  child: const Center(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xffffffff),
                        letterSpacing: -0.3858822937011719,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: const LinearGradient(
                    begin: Alignment(-0.95, 0.0),
                    end: Alignment(1.0, 0.0),
                    colors: [Color.fromARGB(174, 218, 108, 108),Color.fromARGB(251, 236, 85, 85)],
                    stops: [0.0, 1.0],
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100)),),
                    backgroundColor: Colors.transparent,
                      disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
                      shadowColor: Colors.transparent,
                  ),
                  onPressed: ()async{},
                  child: const Center(
                    child: Text(
                      'Update Profile',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xffffffff),
                        letterSpacing: -0.3858822937011719,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              ],
            )
            }
              ],
            ),
            ),
          ]),
          ),
          const SizedBox(height: 10,),
          Card(
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            ),
            shadowColor: Colors.black, 
            margin: const EdgeInsets.only(left: 20,right: 20),
            elevation: 5,
            child: Column(
              children:  [
                const SizedBox(height: 10,),
                Text("Change Password",style: textStyleHeadline2,),
                const SizedBox(height: 10,),
                const Divider(color: Colors.blueGrey,),
                  Container(
                  margin:const EdgeInsets.all(10),
                  child: Column(
                    children: [
                Row(
                  children: 
                const [
                Text("Current Password",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.black),),
                Text("*",
                style: TextStyle(color: Colors.red,fontSize: 18),)
                ],
                ),
               const TextField(
                decoration:InputDecoration( 
                  contentPadding: EdgeInsets.all(10),
                  disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1,color: Colors.grey)),
                  fillColor: Color.fromARGB(255, 212, 208, 208),
                hintText: "Current Password",
                focusedBorder:OutlineInputBorder(
                borderSide: BorderSide(
                      width: 1, color: Color.fromARGB(255, 212, 208, 208),), //<-- SEE HERE
                    ) ,
                enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                      width: 1, color:  Color.fromARGB(255, 212, 208, 208)), //<-- SEE HERE
                    ),
                  ),
               style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.normal),
              //  controller: emailController,
              obscureText: true,
            ),
            const SizedBox(height: 15,),
             Row(
                  children: 
                const [
                Text("New Password",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.black),),
                Text("*",
                style: TextStyle(color: Colors.red,fontSize: 18),)
                ],
                ),
               const TextField(
                decoration:InputDecoration( 
                  contentPadding: EdgeInsets.all(10),
                  disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1,color: Colors.grey)),
                  fillColor: Color.fromARGB(255, 212, 208, 208),
                hintText: "New Password",
                focusedBorder:OutlineInputBorder(
                borderSide: BorderSide(
                      width: 1, color: Color.fromARGB(255, 212, 208, 208),), //<-- SEE HERE
                    ) ,
                enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                      width: 1, color:  Color.fromARGB(255, 212, 208, 208)), //<-- SEE HERE
                    ),
                  ),
               style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.normal),
              //  controller: emailController,
              obscureText: true,
            ),
            const SizedBox(height: 15,),
             Row(
                  children: 
                const [
                Text("Confirm Password",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.black),),
                Text("*",
                style: TextStyle(color: Colors.red,fontSize: 18),)
                ],
                ),
               const TextField(
                decoration:InputDecoration( 
                  contentPadding: EdgeInsets.all(10),
                  disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1,color: Colors.grey)),
                  fillColor: Color.fromARGB(255, 212, 208, 208),
                hintText: "Confirm Password",
                focusedBorder:OutlineInputBorder(
                borderSide: BorderSide(
                      width: 1, color: Color.fromARGB(255, 212, 208, 208),), //<-- SEE HERE
                    ) ,
                enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                      width: 1, color:  Color.fromARGB(255, 212, 208, 208)), //<-- SEE HERE
                    ),
                  ),
               style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.normal),
              //  controller: emailController,
              obscureText: true,
            ),
            const SizedBox(height: 10,),
            Align(
                child: SizedBox(
                      width: 180,
              child: 
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: const LinearGradient(
                    begin: Alignment(-0.95, 0.0),
                    end: Alignment(1.0, 0.0),
                    colors: [Color.fromARGB(174, 218, 108, 108),Color.fromARGB(251, 236, 85, 85)],
                    stops: [0.0, 1.0],
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100)),),
                    backgroundColor: Colors.transparent,
                      disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
                      shadowColor: Colors.transparent,
                  ),
                  onPressed: ()async{},
                  child: const Center(
                    child: Text(
                      'Update Password',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xffffffff),
                        letterSpacing: -0.3858822937011719,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
                ),
            ),
              ],
            ),
          ),
        ]),
      ),
      Padding(
      padding:  const EdgeInsets.only(left: 20,right: 20,top: 10),
      child:
       Container(
       decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(10),
       gradient: const LinearGradient(
                begin: Alignment(-0.95, 0.0),
                end: Alignment(1.0, 0.0),
                colors: [Color.fromARGB(175, 246, 39, 39),Color.fromARGB(253, 253, 0, 0)],
                stops: [0.0, 1.0],
              ),
            ),
       child:
        MaterialButton(
        height: 50,
        minWidth: MediaQuery.of(context).size.width,  
        onPressed: (){
          SweetAlert.show(context,
                      title: "Are you sure?",
                      subtitle: "You want to Logout",
                      style: SweetAlertStyle.confirm,
                      showCancelButton: true, onPress: (bool isConfirm){
                      if (isConfirm) {
                       clearCache();
                      }
                      return true;
                  });
        },
        elevation: 5,
        child: Text("LOGOUT",style: textStyleBodyText1.copyWith(fontSize: 20,color: Colors.white),),
      ),
       ),
      )
    ])));
  });
}
}