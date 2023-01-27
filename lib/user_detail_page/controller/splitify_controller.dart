import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splitify/modal/getuserdata.dart';

import '../../modal/setuserdetail.dart';
import '../../utiles/app_constant.dart';

class SplitifyControler extends GetxController {
  RxBool userLogin = false.obs;
  RxString dropdownvalue = "0".obs;
  RxString userid = "".obs;
  RxList controllers = [].obs;
  RxList fields = [].obs;
  RxList listcont = [].obs;
  RxList historycount = [].obs;
  Rx<GetUserDetail> getUserDetail = GetUserDetail().obs;
  RxList<GetUserDetail> getUserDetailList = <GetUserDetail>[].obs;
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final phoneController = TextEditingController();
  // final amountController = TextEditingController();

  final  amountController = TextEditingController() ;
  final noteController = TextEditingController();
  final usernameController = TextEditingController();
  final writeATripController = TextEditingController();
  final dateInput = TextEditingController();
  List<TextEditingController> addPersonControllerFirst =
      <TextEditingController>[];
  final formKey = GlobalKey<FormState>();
  final formKeySecondScreen = GlobalKey<FormState>();
  late adduserdetail addUser;

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
        //print("element==>>>${element.data().length}");
        getUserDetail.value = GetUserDetail.fromDocumentSnapshot(element);
        // onBoardingModal.value.add(onBoardingModal.value);
        getUserDetailList.add(getUserDetail.value);
         print("${FirebaseAuth.instance.currentUser?.uid}"
            "element==>>>  getUserDetailList : ${getUserDetailList.first
                .amount}");
      });
    });
  }

  static final CollectionReference _collectionReference =
      AppConstant.databaseReference.collection('userDetail');

  static Future<void> addCheckList({
    required String tripName,
  }) async {
    DocumentReference documentReferencer = _collectionReference.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "tripName": tripName,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Checklist added"))
        .catchError((e) => print(e));
  }

  static Future<void> updateChecklist({
    String? tripName,
    String? userName,
    int? amount,
    String? docId,
  }) async {
    DocumentReference documentReferencer =
        AppConstant.databaseReference.collection('userDetail').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "tripName": tripName,
      "userName": userName,
      "amount": amount,
    };
    await documentReferencer
        .update(data)
        .whenComplete(() => print("Checklist Updated"))
        .catchError((e) => print(e));
  }

  static String userId = "";

  static Future<void> deleteChecklist({
    String? docId,
  }) async {
    DocumentReference documentReferencer =
        _collectionReference.doc(userId).collection('checklist').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Checklist Deleted'))
        .catchError((e) => print(e));
  }
}
