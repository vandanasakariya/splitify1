import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:splitify/user_detail_page/controller/splitify_controller.dart';
import '../../modal/setuserdetail.dart';
import '../../navigation-utils/navigation.dart';
import '../../navigation-utils/routes.dart';
import '../../navigation-utils/size_utils.dart';
import 'firebase_auth.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);
  final SplitifyControler splitifyControler = Get.put(SplitifyControler());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.all(SizeUtils.verticalBlockSize * 2),
        child: Form(
          key: splitifyControler.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: splitifyControler.emailController,
                validator: (val) =>
                    val!.isEmpty || !val.contains("@") || !val.contains(".")
                        ? "enter a valid eamil"
                        : null,
                decoration: InputDecoration(
                  labelText: "Enter Email Id",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  //hintText: hintText,
                ),
              ),
              SizedBox(height: SizeUtils.verticalBlockSize * 2),
              TextFormField(
                controller: splitifyControler.passController,
                validator: (pass) {
                  if (pass!.isEmpty) {
                    return "Please Enter Password";
                  } else if (pass.length < 8) {
                    return "Password must be atleast 8 characters long";
                  }
                },
                decoration: InputDecoration(
                  labelText: "Enter password",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // hintText: hintText,
                ),
              ),
              SizedBox(height: SizeUtils.verticalBlockSize * 2),
              TextFormField(
                controller: splitifyControler.phoneController,
                validator: (mono) {
                  if (mono == null) {
                    return "Enter Mobile No";
                  } else if (mono.length <= 9) {
                    return "Enter valid number";
                  }
                },
                keyboardType: TextInputType.number,
                inputFormatters: [LengthLimitingTextInputFormatter(10)],
                decoration: InputDecoration(
                  labelText: "Enter phone no",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  //hintText: hintText,
                ),
              ),
              SizedBox(height: SizeUtils.verticalBlockSize * 2),
              ElevatedButton(
                onPressed: () async {
                  try {
                    FirebaseHelper.signUp(
                      email: splitifyControler.emailController.text,
                      password: splitifyControler.passController.text,
                    );
                  } catch (e) {
                    print("error$e");
                  }

                  if (splitifyControler.formKey.currentState!.validate()) {
                    adduserdetail userDetail = adduserdetail(
                      userId: FirebaseAuth.instance.currentUser?.uid,
                    );
                    await splitifyControler.insertUserDetail(userDetail);

                    Navigation.pushNamed(Routes.bottomPage);

                    print("aaa--");
                  }
                  // Navigation.pushNamed(Routes.bottomPage);
                },
                child: Text("Sign Up"),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
