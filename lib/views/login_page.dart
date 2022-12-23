import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:colab/theme/text_field_styles.dart';
import 'package:colab/theme/text_styles.dart';
import 'package:colab/theme/theme.dart';
import '../constants/constants.dart';
import '../controller/signInController.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
 final signInController = Get.find<SignInController>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

   void goToHome()async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   if(sharedPreferences.getBool('isAdminSignedIn')==true){
    // ignore: use_build_context_synchronously
    context.goNamed('SUPERADMINPAGE');
   }
    if(sharedPreferences.getBool('isClientSignedIn')==true){
    // ignore: use_build_context_synchronously
    context.goNamed('CLIENTLEVELPAGE');
   }
    if(sharedPreferences.getBool('isProjectSignedIn')==true){
    // ignore: use_build_context_synchronously
    context.goNamed('PROJECTLEVELPAGE');
   }
  }

   @override
  void initState() {
    super.initState();
    goToHome();
    validateLoggedInUser();
  }

    bool isDynamic = true;
    validateLoggedInUser() async {
    //SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // signInController.isSignedIn.value =
    //     sharedPreferences.getBool('isSignedIn') ?? false;
    // signInController.isBusinessSignedIn.value =
    //     sharedPreferences.getBool('isBusinessSignedIn') ?? false;
    // signInController.jwtToken.value =
    //     sharedPreferences.getString('jwtToken') ?? '';
    // signInController.userIdProvider.value =
    //     sharedPreferences.getString('userIdProvider') ?? '';
    // getProfile.getUserProfile(
    //     token: signInController.jwtToken.value, context: context);
    // if (signInController.isBusinessSignedIn.value) {
    //   getProfile.getBusinessUserProfile(
    //       token: signInController.jwtToken.value, context: context);
    // }
    // chatNetwork.updateFcmNotification(
    //     token: signInController.jwtToken.value,
    //     fcmToken: signInController.fcmTokenProvider.value.trim());
  }

  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
    return Scaffold(
      // appBar: appBarJustBack(context, false),
      body: Padding(
        padding: const EdgeInsets.all(12),
        // alignment: Alignment.center,
        child:
        Align(
          alignment: Alignment.center,
          child:
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          shadowColor: Colors.black, 
          elevation: 5,
          child: Padding(padding: const EdgeInsets.all(12),child: 
         ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
          //  signInUpHeader(context, true, false,title: 'The social network for travel'),
            const SizedBox(height: 20),
            Center(child: Text("Login",style: textStyleBodyText1.copyWith(fontSize: 32),),),
             const SizedBox(height: 50,),
            Row(children: const [Text("Username",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w300,color: Colors.grey),)],),
            TextField(
              style: const TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.normal),
              controller: emailController,
              decoration: lightTextInputDecoration.copyWith(
                hintText: 'Username',
              ),
            ),
            const SizedBox(height: 20),
            Row(children: const [Text("Password",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w300,color: Colors.grey),)],),
            TextField(
              style: const TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.normal),
              controller: passwordController,
              decoration: lightTextInputDecoration.copyWith(
                hintText: '*******'
              ),
              obscureText: true,
            ),
            const SizedBox(height: 30),
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
                    colors: [Color.fromRGBO(49,140,231, 0.7),Color.fromRGBO(21, 96, 198, 2.0)],
                    stops: [0.0, 1.0],
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100)),),
                    backgroundColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
                    shadowColor: Colors.transparent,
                  ),

                  onPressed: ()async{
                    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
                      signInController.onUserLogIn(
                        email: emailController.text.trim(), 
                        signInPassword: passwordController.text.trim(), 
                        context: context);
                    }else{
                      errorAlertMessage("Enter correct parameters.", context);
                    }
                  },

                  child: const Center(
                    child: Text(
                      'LOGIN',
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
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Text("Forgot Password?",style: textStyleBodyText1.copyWith(fontSize: 18),),
            InkWell(
              onTap: () {},
              child: Text(
                ' Reset',
                style: textStyleBodyText1.copyWith(color: fontColor,fontWeight: FontWeight.bold,fontSize: 18),
              ),
            ),]),
            const SizedBox(height: 60),
            Column(
              children: [
                Text("Powered By",style: textStyleBodyText1.copyWith(color: fontColor,fontSize: 18),),
                const Image(
                        image: AssetImage('assets/images/logo.jpeg'),
                        // height: 24,
                        width: 200,
                      ),
              ],
            )
          ],
        ),
        ),
        ),
        ),
      ),
    );
  }
}
