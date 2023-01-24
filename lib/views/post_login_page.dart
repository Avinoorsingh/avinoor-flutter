import 'dart:async';
import 'package:colab/constants/colors.dart';
import 'package:colab/network/area_of_concern_network.dart';
import 'package:colab/network/labourData/labour_data_network.dart';
import 'package:colab/network/progress_network.dart';
import 'package:colab/network/quality_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/signInController.dart';
import '../network/client_project.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, this.from}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final from;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final signInController = Get.find<SignInController>();
  final getProfile = GetUserProfileNetwork();
  final getSnagData=GetNewSnag();
  final getProjectSnagData=Get.find<GetNewSnag>();
  final getLabourDataContractorList=GetLabourDataContractor();
  final getLabourDataContractorListData=Get.find<GetLabourDataContractor>();
  final getLabourDataOfSelectedContractorList=GetSelectedContractorData();
  final getLabourDataOfSelectedContractorListData=Get.find<GetSelectedContractorData>();
  final getLabourDataToday=GetLabourDataToday();
  final getLabourDataTodayListData=Get.find<GetLabourDataToday>();
  final getCompletedSiteProgress =GetCompletedSiteProgress();
  final getCompletedSiteProgressData=Get.find<GetCompletedSiteProgress>();
  final getInQualitySiteProgress =GetInEqualitySiteProgress();
  final getInQualitySiteProgressData=Get.find<GetInEqualitySiteProgress>();
  final getOnGoingSiteProgress =GetOnGoingSiteProgress();
  final getOnGoingSiteProgressData=Get.find<GetOnGoingSiteProgress>();
  final getNewQualityData=GetNewCheckList();
  final getProjectNewQualityData=Get.find<GetNewCheckList>();
  final getAreaOfConcernData=GetAreaOfConcern();
  final getProjectAreaOfConcernData=Get.find<GetAreaOfConcern>();
  final getOpenedQualityData=GetOpenedCheckList();
  final getProjectOpenedQualityData=Get.find<GetOpenedCheckList>();
  final getClosedQualityData=GetClosedCheckList();
  final getProjectClosedQualityData=Get.find<GetClosedCheckList>();
  final getDeSnagData=GetNewDeSnag();
  final getProjectDeSnagData=Get.find<GetNewDeSnag>();
  final getOpenedSnag=GetOpenedSnag();
  final getOpenedSnagData=Get.find<GetOpenedSnag>();
  final getOpenedDeSnag=GetOpenedDeSnag();
  final getOpenedDeSnagData=Get.find<GetOpenedDeSnag>();
  final getClosedSnag=GetClosedSnag();
  final getClosedSnagData=Get.find<GetClosedSnag>();
  final getClosedDeSnag=GetClosedDeSnag();
  final getClosedDeSnagData=Get.find<GetClosedDeSnag>();
  final getClientProjectsController = Get.find<GetClientProject>();
  final getClientProfileController = Get.find<GetUserProfileNetwork>();
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
   else if(sharedPreferences.getBool('isProjectSignedIn')!=true && sharedPreferences.getBool('isAdminSignedIn')!=true&&sharedPreferences.getBool('isClientSignedIn')!=true){
    // ignore: use_build_context_synchronously
    context.goNamed('LOGINPAGE');
   }
  }
  double logoHeight = 160;
  double logoWidth = 160;

  @override
  void initState() {
    super.initState();
    EasyLoading.show(maskType: EasyLoadingMaskType.black,status: "");
   // validateLoggedInUser();
  }

  bool isDynamic = true;

  // validateLoggedInUser() async {
  //    EasyLoading.show(maskType: EasyLoadingMaskType.black);
  // }

  @override
  Widget build(BuildContext context) {
     EasyLoading.show(maskType: EasyLoadingMaskType.black);
    Timer waitNavigate =
        Timer(Duration(milliseconds: isDynamic ? 2100 : 0), () {
      if (mounted && isDynamic) {
        goToHome();
      }
    });

    waitNavigate;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 40),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors:  [AppColors.primary,AppColors.primary,],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Stack(children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              '',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: AppColors.white),
            ),
          ),
        ]),
      ),
    );
  }
}
