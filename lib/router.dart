import 'package:colab/views/activity_progress.dart';
import 'package:colab/views/add_area_of_concern.dart';
import 'package:colab/views/add_labour_data.dart';
import 'package:colab/views/add_progress_entry.dart';
import 'package:colab/views/add_snag.dart';
import 'package:colab/views/area_of_concern_detail.dart';
import 'package:colab/views/areas_of_concern.dart';
import 'package:colab/views/client_level.dart';
import 'package:colab/views/completed_particular_progress.dart';
import 'package:colab/views/completed_particular_progress_detail.dart';
import 'package:colab/views/de_snags.dart';
import 'package:colab/views/drawing_master.dart';
import 'package:colab/views/drawing_master_pdf.dart';
import 'package:colab/views/edit_progress_entry.dart';
import 'package:colab/views/get_completed_site_progress.dart';
import 'package:colab/views/labour_data.dart';
import 'package:colab/views/logout_screen.dart';
import 'package:colab/views/my_profile_page.dart';
import 'package:colab/views/new_progress_entry.dart';
import 'package:colab/views/new_progress_entry2.dart';
import 'package:colab/views/new_snags.dart';
import 'package:colab/views/offline/progress/activity_progress_offline.dart';
import 'package:colab/views/offline/progress/add_progress_offline.dart';
import 'package:colab/views/offline/progress/ongoing_screens/edit_progress_entry_offline.dart';
import 'package:colab/views/offline/progress/ongoing_screens/ongoing_ongoing_offline.dart';
import 'package:colab/views/offline/progress/ongoing_screens/upcoming_progress_entry_offline.dart';
import 'package:colab/views/offline/snags/add_snag_offline.dart';
import 'package:colab/views/offline/snags/snag_detail_offline.dart';
import 'package:colab/views/offline/snags/snagsoffline.dart';
import 'package:colab/views/ongoing_ongoing.dart';
import 'package:colab/views/post_login_page.dart';
import 'package:colab/views/project_level_offline.dart';
import 'package:colab/views/project_level_page.dart';
import 'package:colab/views/login_page.dart';
import 'package:colab/views/quality_check_detail.dart';
import 'package:colab/views/quality_checklist.dart';
import 'package:colab/views/snag.dart';
import 'package:colab/views/snag_detail.dart';
import 'package:colab/views/snag_detail2.dart';
import 'package:colab/views/sub_location.dart';
import 'package:colab/views/super_admin_page.dart';
import 'package:colab/views/three_sixty_image.dart';
import 'package:colab/views/three_sixty_image_add.dart';
import 'package:colab/views/three_sixty_image_view.dart';
import 'package:colab/views/upcoming_progress_entry.dart';
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
        name: 'PROJECTOFFLINE',
        path: projectOffline,
        builder: (context, state) => ProjectLevelOffline(
          key: state.pageKey,
        ),
      ),
      GoRoute(
        name: 'SNAGSOFFLINE',
        path: snagsOffline,
        builder: (context, state) => SnagsOffline(
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
        name: 'ONGOINGHOMESCREEN',
        path: onGoingScreen,
        builder: (context, state) => OnGoingOnGoingScreen(
          key: state.pageKey,
          cID: state.queryParams['cID'],
          pID: state.queryParams['pID'],
          locID: state.queryParams['locID'],
          subLocID: state.queryParams['subLocID'],
          subSubLocID: state.queryParams['subSubLocID'],
          locationName: state.queryParams['loc'],
          subLocationName: state.queryParams['subLoc'],
          subSubLocationName: state.queryParams['subSubLoc'],
        ),
      ),
      GoRoute(
        name: 'ONGOINGHOMESCREENOFFLINE',
        path: onGoingOfflineScreen,
        builder: (context, state) => OnGoingOnGoingOfflineScreen(
          key: state.pageKey,
          cID: state.queryParams['cID'],
          pID: state.queryParams['pID'],
          locID: state.queryParams['locID'],
          subLocID: state.queryParams['subLocID'],
          subSubLocID: state.queryParams['subSubLocID'],
          locationName: state.queryParams['loc'],
          subLocationName: state.queryParams['subLoc'],
          subSubLocationName: state.queryParams['subSubLoc'],
        ),
      ),
      GoRoute(
        name: 'COMPLETEDPARTICULARPROGRESS',
        path: completedParticularProgress,
        builder: (context, state) => CompletedParticularProgress(
          key: state.pageKey,
          from: state.queryParams["from"],
          completedModel: state.extra,
          cID: state.queryParams['cID'],
          pID: state.queryParams['pID'],
          locId: state.queryParams['locID'],
          subLocId: state.queryParams['subLocID'],
          subSubLocId: state.queryParams['subSubLocID'],
          locationName: state.queryParams['loc'],
          subLocationName: state.queryParams['subLoc'],
          subSubLocationName: state.queryParams['subSubLoc'],
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
        name: 'SNAGDETAILOFFLINE',
        path: snagDetailOffline,
        builder: (context, state) => SnagDetailOffline(
          key: state.pageKey,
          from: state.queryParams["from"],
          snagModel: state.extra,
        ),
      ),
      GoRoute(
        name: 'SNAGDETAIL2',
        path: snagDetail2,
        builder: (context, state) => SnagDetail2(
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
        name:'NEWPROGRESSENTRY2',
        path: newProgressEntry2,
        builder: (context, state) => NewProgressEntry2(
          key: state.pageKey,
          from: state.queryParams["from"],
          snagModel: state.extra,
          locName: state.queryParams['locName'],
          subLocName:state.queryParams['subLocName'],
          subSubLocName:state.queryParams['subSubLocName'],
        ),
      ),
      GoRoute(
        name:'ADDPROGRESSENTRY',
        path: addProgressEntry,
        builder: (context, state) => AddProgressEntry(
          key: state.pageKey,
        ),
      ),
      GoRoute(
        name:'ADDPROGRESSOFFLINE',
        path: addProgressEntryOffline,
        builder: (context, state) => AddProgressEntryOffline(
          key: state.pageKey,
        ),
      ),
      GoRoute(
        name:'UPCOMINGPROGRESSENTRY',
        path: upcomingProgressEntry,
        builder: (context, state) => UpComingEntry(
          key: state.pageKey,
          from: state.queryParams["from"],
          editModel: state.extra,
        ),
      ),
      GoRoute(
        name:'UPCOMINGPROGRESSENTRYOFFLINE',
        path: upcomingProgressEntryOffline,
        builder: (context, state) => UpComingEntryOffline(
          key: state.pageKey,
          from: state.queryParams["from"],
          editModel: state.extra,
        ),
      ),
      GoRoute(
        name:'EDITPROGRESSENTRY',
        path: editProgressEntry,
        builder: (context, state) => EditProgressEntry(
          key: state.pageKey,
          from: state.queryParams["from"],
          editModel: state.extra,
        ),
      ),
      GoRoute(
        name:'EDITPROGRESSENTRYOFFLINE',
        path: editProgressEntryOffline,
        builder: (context, state) => EditProgressEntryOffline(
          key: state.pageKey,
          from: state.queryParams["from"],
          editModel: state.extra,
        ),
      ),
       GoRoute(
        name:'LABOURDATA',
        path: labourData,
        builder: (context, state) => LabourData(
          key: state.pageKey,
        ),
      ),
      GoRoute(
        name:'ADDLABOURDATA',
        path: addLabourData,
        builder: (context, state) => AddLabourData(
          key: state.pageKey,
        ),
      ),
      GoRoute(
        name:'360IMAGE',
        path: addThreeSixtyImage,
        builder: (context, state) => ThreeSixtyImage(
          key: state.pageKey,
        ),
      ),
      GoRoute(
        name:'DRAWING',
        path: drawingMaster,
        builder: (context, state) => DrawingMaster(
          key: state.pageKey,
        ),
      ),
       GoRoute(
        name:'PDFSCREEN',
        path: pdfScreen,
        builder: (context, state) => PDFScreen(
          key: state.pageKey,
          path:state.queryParams["path"],
        )
      ),
       GoRoute(
        name:'ADD360IMAGE',
        path: addingThreeSixtyImage,
        builder: (context, state) => AddThreeSixtyImage(
          key: state.pageKey,
          locId:state.queryParams["locId"],
          subLocId:state.queryParams["subLocId"] ,
          subSubLocId:state.queryParams["subSubLocId"],
          locName:state.queryParams["locName"] ,
          subLocName: state.queryParams["subLocName"],
          subSubLocName: state.queryParams["subSubLocName"],
        ),
      ),
       GoRoute(
        name:'VIEW360IMAGE',
        path: viewThreeSixtyImage,
        builder: (context, state) => ThreeSixtyImageView(
          key: state.pageKey,
          viewpointID: state.queryParams["viewpointID"],
          masterImage: state.queryParams["masterImage"],
        ),
      ),
      GoRoute(
        name:'GETCOMPLETEDPROGRESSENTRY',
        path: getCompletedProgressEntry,
        builder: (context, state) => GetCompletedSiteProgress(
          key: state.pageKey,
          from: state.queryParams["from"],
          editModel: state.extra,
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
          index:state.queryParams['index'],
        ),
      ),
       GoRoute(
        name: 'ADDSNAGOFFLINE',
        path: addSnagsOffline,
        builder: (context, state) => AddSnagOffline(
          key: state.pageKey,
        ),
      ),
       GoRoute(
        name: 'ACTIVITIESOFFLINE',
        path: progressOffline,
        builder: (context, state) => ActivityProgressOffline(
          key: state.pageKey,
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
