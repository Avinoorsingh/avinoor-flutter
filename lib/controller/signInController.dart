import 'dart:async';
import 'package:colab/models/activity_head.dart';
import 'package:colab/models/area_of_concern_model.dart';
import 'package:colab/models/category_list.dart';
import 'package:colab/models/clientEmployee.dart';
import 'package:colab/models/client_response.dart';
import 'package:colab/models/location_list.dart';
import 'package:colab/models/quality_new_checklist.dart';
import 'package:colab/models/snag_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' hide Response;
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api_service.dart';
import '../constants/constants.dart';
import '../models/completedProgress.dart';
import '../models/login_response_model.dart';
import '../models/login_user.dart';
import '../models/section_detail.dart';
import '../models/sub_location_list.dart';
import '../network/client_project.dart';
import '../services/helper/dependency_injector.dart';

class SignInController extends GetxController {
  RxBool isSignedIn = false.obs;
  RxString newUserId = ''.obs;
  var isBusiness = false.obs;
  RxString username = ''.obs;
  RxString updatedAt=''.obs;
  RxString password = ''.obs;
  RxString jwtToken = ''.obs;
  RxString userIdProvider = ''.obs;
  late final getUserProfile = GetUserProfileNetwork();
  late final getNewSnagData=GetNewSnag();
  late final getNewDeSnagData=GetNewDeSnag();
  late final getOpenedSnagData=GetOpenedSnag();
  late final getClosedSnagData=GetClosedSnag();
  LoginResponseModel? getClientProfile;
  ClientProfileData? getProjectData;
  CategoryList? getCategoryList; 
  LocationList? getLocationList;
  SubLocationList? getSubLocationList;
  ActivityHead? getActivityHeadList;
  ClientEmployee? getEmployeeList;
  SnagData? getSnagDataList;
  SnagData? getDeSnagDataList;
  SnagData? getSnagDataOpenedList;
  SnagData? getDeSnagDataOpenedList;
  SnagData? getSnagDataClosedList;
  SnagData? getDeSnagDataClosedList;
  Checklist? getCheckListData;
  Checklist? getOpenedCheckListData;
  CompletedProgress? getCompletedProgressData;
  Checklist? getClosedCheckListData;
  SectionDetail? getSectionData;
  AreaOfConcern? getAreaOfConcData;

  
  @override
  void onInit() {
    super.onInit();
  }

  onUserLogIn({
    required email,
    required signInPassword,
    required BuildContext context,
  }) async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      Timer(const Duration(seconds: 2), () {
      LoginUserModel model= LoginUserModel(userId: email, password: signInPassword);
      APIService.login(model).then((response) =>{
      if(response=="superadmin"){
        EasyLoading.dismiss(),
        sharedPreferences.setBool('isAdminSignedIn', true),
        isSignedIn.value=sharedPreferences.getBool('isAdminSignedIn')!,
        sharedPreferences.setString('userName', email),
        sharedPreferences.setString('password', signInPassword),
        DependencyInjector.initializeControllers(),
        context.goNamed('SPLASH'),
      },
      if(response=='clientLevel'){
      EasyLoading.dismiss(),
      sharedPreferences.setBool('isClientSignedIn', true),
      isSignedIn.value = sharedPreferences.getBool('isClientSignedIn')!,
      username.value=sharedPreferences.getString('name')!,
      updatedAt.value=sharedPreferences.getString('updated_at')!,
      sharedPreferences.setString('userName', email),
      sharedPreferences.setString('password', signInPassword),
      DependencyInjector.initializeControllers(),
      context.goNamed('SPLASH')
      },
      if(response=='projectLevel'){
      EasyLoading.dismiss(),
      sharedPreferences.setBool('isProjectSignedIn', true),
      isSignedIn.value = sharedPreferences.getBool('isProjectSignedIn')!,
      username.value=sharedPreferences.getString('name')!,
      updatedAt.value=sharedPreferences.getString('updated_at')!,
      sharedPreferences.setString('userName', email),
      sharedPreferences.setString('password', signInPassword),
      DependencyInjector.initializeControllers(),
      context.goNamed('SPLASH')
      }
      else if(response=="false"){
      errorAlertMessage("Invalid user.", context),
      EasyLoading.dismiss(),
      }
      });
      }
      );
    } catch (e) {
      EasyLoading.dismiss();
    }
  }
}