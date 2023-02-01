import 'package:colab/constants/colors.dart';
import 'package:colab/router.dart';
import 'package:colab/services/helper/dependency_injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
GlobalKey<NavigatorState> contextKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: AppColors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  DependencyInjector.initializeControllers();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final router = CustomRouter();

  

  @override
  Widget build(BuildContext context) {
     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  statusBarColor: AppColors.primary,
));
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp]); //Forcing orientation to Portrait.
    return MaterialApp(
      color: AppColors.primary,
      navigatorKey: contextKey,
      debugShowCheckedModeBanner: false,
      home: MaterialApp.router(
        theme: lightThemeData,
        debugShowCheckedModeBanner: false,
        scrollBehavior: const ScrollBehavior()
            .copyWith(physics: const BouncingScrollPhysics()),
        routerDelegate: router.goRouter.routerDelegate,
        routeInformationParser: router.goRouter.routeInformationParser,
        // home: AccountPageTraveller(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
