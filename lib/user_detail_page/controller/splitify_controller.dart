import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splitify/modal/getuserdata.dart';
import 'package:splitify/modal/setuserdetail.dart';
import 'package:splitify/utiles/app_constant.dart';

import '../../sharedprafrance/shardprafrance.dart';

class SplitifyControler extends GetxController {
  RxBool userLogin = false.obs;
  RxString dropdownvalue = "0".obs;
  RxString userid = "".obs;
  RxList controllers = [].obs;
  RxList fields = [].obs;
  Rx<GetUserDetail> getUserDetail = GetUserDetail().obs;
  RxList<GetUserDetail> getUserDetailList = <GetUserDetail>[].obs;
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final phoneController = TextEditingController();
  final amountController = TextEditingController();
  final writeATripController = TextEditingController();
  final dateInput = TextEditingController();
  List<TextEditingController> addPersonControllerFirst =
  <TextEditingController>[];



  final formKey = GlobalKey<FormState>();
  final formKeySecondScreen = GlobalKey<FormState>();




  Future<void> insertUserDetail(adduserdetail data) async {

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
        print(/*"${FirebaseAuth.instance.currentUser?.uid}"*/
            "element==>>>  getUserDetailList : ${getUserDetailList.first.name1}");
      });
    });
  }
//final selected = "0".obs;

/* void setSelected(value){
    selected.value = value;
  }*/
/*  RxString journeyNm = "".obs;
  RxString date = "".obs;
  RxString person = "".obs;
  RxString uname = "".obs;
  void journey() {
    journeyNm.value = AppPreference.getString("journeyname");
    date.value = AppPreference.getString("date");
    person.value = AppPreference.getString("person");
    uname.value = AppPreference.getString("uname");
  }*/

/*void clearText() {
    field.clear();
  }*/
}
