import 'package:colab/network/client_project.dart';
import 'package:get/get.dart';
import '../../controller/signInController.dart';

class DependencyInjector {
  static final signInController = Get.put(SignInController());
  static final getClientController=Get.put(GetClientProject());
  static final getUserProfileNetwork=Get.put(GetUserProfileNetwork());
  static final getSnagData=Get.put(GetNewSnag());
  static final getDeSnagData=Get.put(GetNewDeSnag());
  static final getOpenedSnagData=Get.put(GetOpenedSnag());
  static final getOpenedDeSnagData=Get.put(GetOpenedDeSnag());
  static final getClosedSnagData=Get.put(GetClosedSnag());
  static final getClosedDeSnagData=Get.put(GetClosedDeSnag());

  static void initializeControllers() {
    Get.put(SignInController());
    Get.put(GetClientProject());
    Get.put(GetUserProfileNetwork());
    Get.put(GetNewSnag());
    Get.put(GetNewDeSnag());
    Get.put(GetOpenedSnag());
    Get.put(GetOpenedDeSnag());
    Get.put(GetClosedSnag());
    Get.put(GetClosedDeSnag());
  }

   static void deleteControllers() {
    Get.deleteAll();
  }
}