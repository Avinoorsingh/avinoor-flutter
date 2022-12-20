import 'package:colab/network/client_project.dart';
import 'package:get/get.dart';
import '../../controller/signInController.dart';

class DependencyInjector {
  static final signInController = Get.put(SignInController());
  static final getClientController=Get.put(GetClientProject());
  static final getUserProfileNetwork=Get.put(GetUserProfileNetwork());
  static final getSnagData=Get.put(GetNewSnag());
  static final getOpenedSnagData=Get.put(GetOpenedSnag());
  static final getClosedSnagData=Get.put(GetClosedSnag());

  static void initializeControllers() {
    Get.put(SignInController());
    Get.put(GetClientProject());
    Get.put(GetUserProfileNetwork());
    Get.put(GetNewSnag());
    Get.put(GetOpenedSnag());
    Get.put(GetClosedSnag());
  }

   static void deleteControllers() {
    Get.deleteAll();
  }
}