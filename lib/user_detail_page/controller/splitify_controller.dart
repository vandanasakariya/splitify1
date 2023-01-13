
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splitify/modal/getuserdata.dart';


class SplitifyControler extends GetxController {
  RxBool userLogin = false.obs;
  RxString dropdownvalue = "0".obs;
  RxString userid = "".obs;
  RxList controllers = [].obs;
  RxList fields = [].obs;
  /*Rx<GetUserDetail> getUserDetail = GetUserDetail().obs;
  RxList<GetUserDetail> getUserDetailList = <GetUserDetail>[].obs;*/
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final phoneController = TextEditingController();
  final amountController = TextEditingController();
  final noteController = TextEditingController();
  final usernameController = TextEditingController();
  final writeATripController = TextEditingController();
  final dateInput = TextEditingController();
  List<TextEditingController> addPersonControllerFirst =
  <TextEditingController>[];


  final formKey = GlobalKey<FormState>();
  final formKeySecondScreen = GlobalKey<FormState>();


 /* Future<void> insertUserDetail(adduserdetail data) async {
    try {
      await AppConstant.databaseReference
          .collection("userDetail")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set(
        data.toJson(),
        SetOptions(merge: true),
      );
      // Navigation.popAndPushNamed(Routes.signInScreen);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getOnBoardingDetail() async {
    await AppConstant.databaseReference
        .collection("userDetail")
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> value) {
      value.docs.forEach((element) {
        print("element==>>>${element.data()}");
        getUserDetail.value = GetUserDetail.fromDocumentSnapshot(element);
        // onBoardingModal.value.add(onBoardingModal.value);
        getUserDetailList.add(getUserDetail.value);
        print(*//*"${FirebaseAuth.instance.currentUser?.uid}"*//*
            "element==>>>  getUserDetailList : ${getUserDetailList.first
                .name1}");
      });
    });
  }*/
}
