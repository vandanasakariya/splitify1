import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splitify/sharedprafrance/shardprafrance.dart';
import 'package:splitify/user_detail_page/controller/splitify_controller.dart';
import 'navigation-utils/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  AppPreference.initMySharedPreferences();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  //late AppLifecycleReactor _appLifecycleReactor;
  /*@override
  void initState() {
    super.initState();
    AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
    _appLifecycleReactor =
        AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
    _appLifecycleReactor.listenToAppStateChanges();
    print("r");
  }*/

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashscreen,
      getPages: Routes.pages,
      initialBinding: AppBidding(),
    );
  }
}

class AppBidding implements Bindings {
  @override
  void dependencies() {
    Get.put(SplitifyControler());

    //Get.put(FestivalController());
  }
}
/*class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashscreen,
      getPages: Routes.pages,
    );
  }
}*/
