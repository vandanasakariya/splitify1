import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splitify/navigation-utils/size_utils.dart';
import 'navigation-utils/routes.dart';

class Rupee extends StatefulWidget {
  const Rupee({Key? key}) : super(key: key);

  @override
  State<Rupee> createState() => _RupeeState();
}

class _RupeeState extends State<Rupee> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        //backgroundColor: Colors.blue.shade100,
        inputDecorationTheme: const InputDecorationTheme(),
        switchTheme: const SwitchThemeData(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade900,
          titleTextStyle: TextStyle(fontSize: SizeUtils.fSize_13()),
        ),
      ),
      initialRoute: Routes.splashscreen,
      getPages: Routes.pages,
      initialBinding: AppBidding(),
      // home: const WelcomePage(),
    );
  }
}

void hideKeyboard(BuildContext context) {
  var currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}

class AppBidding implements Bindings {
  @override
  void dependencies() {
    print("1-------vvv-----");

   // Get.put(SpleshController());

  }
}
