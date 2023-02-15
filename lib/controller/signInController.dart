// ignore_for_file: file_names
import 'dart:async';
import 'package:colab/models/area_of_concern_model.dart';
import 'package:colab/models/category_list.dart';
import 'package:colab/models/clientEmployee.dart';
import 'package:colab/models/client_response.dart';
import 'package:colab/models/labour_attendance.dart';
import 'package:colab/models/location_list.dart';
import 'package:colab/models/ongoing_completed_progress_data.dart';
import 'package:colab/models/ongoing_process.dart';
import 'package:colab/models/ongoing_upcoming_progress.dart';
import 'package:colab/models/progress_contractor.dart';
import 'package:colab/models/progress_sublocation_data.dart';
import 'package:colab/models/quality_new_checklist.dart';
import 'package:colab/models/snag_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' hide Response;
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api_service.dart';
import '../constants/constants.dart';
import '../models/InEqualityProgess.dart';
import '../models/completedProgress.dart';
import '../models/labour_data_contractor_list.dart';
import '../models/labour_name_contractor_list.dart';
import '../models/labour_today_data_list.dart';
import '../models/login_response_model.dart';
import '../models/login_user.dart';
import '../models/ongoing_ongoing_progress_data.dart';
import '../models/progress_activityHead_data.dart';
import '../models/progress_location_data.dart';
import '../models/progress_subSublocation_data.dart';
import '../models/progress_trade_data.dart';
import '../models/section_detail.dart';
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
  late final getUserProjects = GetClientProject();
  late final getNewSnagData=GetNewSnag();
  late final getNewDeSnagData=GetNewDeSnag();
  late final getOpenedSnagData=GetOpenedSnag();
  late final getClosedSnagData=GetClosedSnag();
  LoginResponseModel? getClientProfile;
  ClientProfileData? getProjectData;
  List? getChartData;
  CategoryList? getCategoryList; 
  LocationList? getLocationList;
  ProgressLocationData? getProgressLocationList;
  ProgressContractor? getProgressContractorList;
  ProgressTrade? getProgressTradeList;
  LabourAttendance? getLabourAttendance;
  // ignore: prefer_typing_uninitialized_variables
  var getSubLocationList;
  ProgressSubLocationData? getProgressSubLocationData;
  ProgressSubSubLocationData? getProgressSubSubLocationData;
  // ignore: prefer_typing_uninitialized_variables
  var getActivityHeadList;
  ProgressActivityHeadData? getProgressActivityHeadApi;
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
  InEqualityProgress? getInEqualityProgressData;
  OnGoingProgress? getOnGoingProcessData;
  Checklist? getClosedCheckListData;
  SectionDetail? getSectionData;
  OnGoingCompletedProgress? getOnGoingCompletedData;
  OnGoingOnGoingProgress? getOnGoingOnGoingData;
  OnGoingUpcomingProgress? getOnGoingUpComingData;
  AreaOfConcern? getAreaOfConcData;
  LabourDataContractorList? getLabourDataContractorListData;
  LabourNameContractorList? getLabourDataOfSelectedContractor;
  LabourTodayDataList? getLabourByDate;

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