import 'package:colab/views/addSnag.dart';
import 'package:colab/views/client_level.dart';
import 'package:colab/views/de_snags.dart';
import 'package:colab/views/logout_screen.dart';
import 'package:colab/views/my_profile_page.dart';
import 'package:colab/views/post_login_page.dart';
import 'package:colab/views/project_level_page.dart';
import 'package:colab/views/login_page.dart';
import 'package:colab/views/snag.dart';
import 'package:colab/views/snag_detail.dart';
import 'package:colab/views/sub_location.dart';
import 'package:colab/views/super_admin_page.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart';

class CustomRouter {
  // static final signInController = Get.find<SignInController>();

  GoRouter goRouter = GoRouter(
    urlPathStrategy: UrlPathStrategy.path,
    initialLocation: splash,
    routes: [
      GoRoute(
        name: 'SPLASH',
        path: splash,
        builder: (context, state) => SplashScreen(
          key: state.pageKey,
        ),
      ),
      GoRoute(
        name: 'LOGINPAGE',
        path: loginPage,
        builder: (context, state) => LogInPage(
          key: state.pageKey,
        ),
      ),
      GoRoute(
        name: 'SNAGS',
        path: snags,
        builder: (context, state) => Snags(
          key: state.pageKey,
        ),
      ),
       GoRoute(
        name: 'DESNAGS',
        path: desnags,
        builder: (context, state) => DeSnags(
          key: state.pageKey,
        ),
      ),
        GoRoute(
        name: 'SUBLOCATION',
        path: subLocation,
        builder: (context, state) => SubLocation(
          key: state.pageKey,
        ),
      ),
       GoRoute(
        name: 'SNAGDETAIL',
        path: snagDetail,
        builder: (context, state) => SnagDetail(
          key: state.pageKey,
          from: state.queryParams["from"],
          snagModel: state.extra,
        ),
      ),
      //   GoRoute(
      //   name: 'SNAGS',
      //   path: subSubLocation,
      //   builder: (context, state) => Snags(
      //     key: state.pageKey,
      //   ),
      // ),
      GoRoute(
        name: 'ADDSNAG',
        path: addSnags,
        builder: (context, state) => AddSnag(
          key: state.pageKey,
        ),
      ),
       GoRoute(
        name: 'MYPROFILEPAGE',
        path: myProfilePage,
        builder: (context, state) => MyProfilePage(
          key: state.pageKey,
        ),
      ),
       GoRoute(
        name: 'PROJECTLEVELPAGE',
        path: homePage,
        builder: (context, state) => ProjectLevelPage(
        clientData: state.extra,
          from: state.queryParams["from"],
        ),
        //builder: (context, state) => const ProjectLevelPage(),
      ),
       GoRoute(
        name: 'CLIENTLEVELPAGE',
        path: clientLevel,
        builder: (context, state) => const ClientLevelPage(),
      ),
        GoRoute(
        name: 'SUPERADMINPAGE',
        path: superAdmin,
        builder: (context, state) => const SuperAdminPage(),
      ),
       GoRoute(
        name: 'LOGOUT',
        path: logout,
        builder: (context, state) => const LogoutScreen(),
      ),
    ],
  );
}
