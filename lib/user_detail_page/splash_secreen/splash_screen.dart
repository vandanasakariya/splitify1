import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splitify/theam/app_img.dart';
import 'package:splitify/user_detail_page/controller/splitify_controller.dart';
import '../../navigation-utils/navigation.dart';
import '../../navigation-utils/routes.dart';
import '../../navigation-utils/size_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplitifyControler splitifyControler = Get.put(SplitifyControler());

  @override
  void initState() {
    // TODO: implement initState
    Timer(
      const Duration(seconds: 3),
      () {
        // final credential = GoogleSign().signInWithGoogle();
        //log("credential-------${credential}");
        /*FirebaseAuth.instance.currentUser == null
            ? Navigation.pushNamed(Routes.signInPage)
            : Navigation.pushNamed(Routes.bottomPage);*/
        Navigation.pushNamed(Routes.bottomPage
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: SizeUtils.verticalBlockSize * 97,
          width: SizeUtils.horizontalBlockSize * 99.5,
          child: Image.asset(
            AppImage.splashScreen, //fit: BoxFit.fill,
            alignment: Alignment.center,
            // height: SizeUtils.verticalBlockSize * 100,
          ),
        ),
      ),
    );
  }
}
