import 'package:colab/views/activity_progress.dart';
import 'package:colab/views/add_area_of_concern.dart';
import 'package:colab/views/add_snag.dart';
import 'package:colab/views/area_of_concern_detail.dart';
import 'package:colab/views/areas_of_concern.dart';
import 'package:colab/views/client_level.dart';
import 'package:colab/views/completed_particular_progress.dart';
import 'package:colab/views/completed_particular_progress_detail.dart';
import 'package:colab/views/de_snags.dart';
import 'package:colab/views/logout_screen.dart';
import 'package:colab/views/my_profile_page.dart';
import 'package:colab/views/new_progress_entry.dart';
import 'package:colab/views/new_snags.dart';
import 'package:colab/views/post_login_page.dart';
import 'package:colab/views/project_level_page.dart';
import 'package:colab/views/login_page.dart';
import 'package:colab/views/quality_check_detail.dart';
import 'package:colab/views/quality_checklist.dart';
import 'package:colab/views/snag.dart';
import 'package:colab/views/snag_detail.dart';
import 'package:colab/views/sub_location.dart';
import 'package:colab/views/super_admin_page.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart';

class CustomRouter {

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
        name: 'QUALITYCHECKLIST',
        path: qualityChecklist,
        builder: (context, state) => QualityCheckList(
          key: state.pageKey,
        ),
      ),
      GoRoute(
        name: 'ACTIVITIES',
        path: activities,
        builder: (context, state) => ActivitiesProgress(
          key: state.pageKey,
        ),
      ),
      GoRoute(
        name: 'COMPLETEDPARTICULARPROGRESS',
        path: completedParticularProgress,
        builder: (context, state) => CompletedParticularProgress(
          key: state.pageKey,
          from: state.queryParams["from"],
          snagModel: state.extra,
        ),
      ),
      GoRoute(
        name: 'AREASOFCONCERN',
        path: areaOfConcern,
        builder: (context, state) => AreasOfConcern(
          key: state.pageKey,
        ),
      ),
      GoRoute(
        name: 'NEWSNAG',
        path: newSnags,
        builder: (context, state) => NewSnag(
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
      GoRoute(
        name:'NEWPROGRESSENTRY',
        path: newProgressEntry,
        builder: (context, state) => NewProgressEntry(
          key: state.pageKey,
          from: state.queryParams["from"],
          snagModel: state.extra,
        ),
      ),
      GoRoute(
        name: 'AREAOFCONCERNDETAIL',
        path: areaOfConcernDetail,
        builder: (context, state) => AreaOfConcernDetail(
          key: state.pageKey,
          from: state.queryParams["from"],
          concernModel: state.extra,
        ),
      ),
       GoRoute(
        name: 'COMPLETEDSITEPROGRESSDETAIL',
        path: completedParticularProgressDetail,
        builder: (context, state) => CompletedParticularProgressDetail(
          key: state.pageKey,
          from: state.queryParams["from"],
          concernModel: state.extra,
        ),
      ),
      GoRoute(
        name: 'QUALITYCHECKDETAIL',
        path: qualityCheckDetail,
        builder: (context, state) => QualityCheckDetail(
          key: state.pageKey,
          from: state.queryParams["from"],
          qualityModel: state.extra,
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
        name: 'ADDAREAOFCONCERN',
        path: addAreaOfConcern,
        builder: (context, state) => AddAreaOfConcern(
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
