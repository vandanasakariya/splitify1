import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:splitify/modal/setuserdetail.dart';
import 'package:splitify/navigation-utils/size_utils.dart';
import 'package:splitify/theam/app_img.dart';
import 'package:splitify/theam/app_string.dart';
import 'package:splitify/user_detail_page/controller/splitify_controller.dart';
import 'package:splitify/widget/custom_text.dart';

import '../../navigation-utils/navigation.dart';
import '../../navigation-utils/routes.dart';
import '../../widget/custom_textfield.dart';

class UserDetail extends StatefulWidget {
  const UserDetail({Key? key}) : super(key: key);

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  final SplitifyControler splitifyControler = Get.find()..insertUserDetail;

  //DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    for (final controller in splitifyControler.controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  var textformFields = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          return exit(0);
        },
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImage.bg),
                fit: BoxFit.cover,
              ),
            ),
            child: Form(
              key: splitifyControler.formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeUtils.verticalBlockSize * 3,
                    vertical: SizeUtils.horizontalBlockSize * 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: SizeUtils.horizontalBlockSize * 5),
                      child: AppText(
                        text: AppString.letStartYourJourney,
                        fontWeight: FontWeight.bold,
                        fontSize: SizeUtils.fSize_24(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeUtils.horizontalBlockSize * 4),
                      child: const AppText(
                        text: AppString.someWordAboutTrip,
                      ),
                    ),
                    CustomTextField(
                      height: SizeUtils.verticalBlockSize * 5,
                      borderRadius: BorderRadius.circular(10),
                      controller: splitifyControler.writeATripController,
                      keyboardType: TextInputType.text,
                      hintText: AppString.writeTripNm,
                      contentPadding: EdgeInsets.fromLTRB(15, 0, 20, 11),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: SizeUtils.horizontalBlockSize * 3),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              const AppText(
                                text: AppString.date,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: SizeUtils.horizontalBlockSize * 5),
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFB3E5FC),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  height: SizeUtils.verticalBlockSize * 5,
                                  width: SizeUtils.horizontalBlockSize * 35,
                                  child: TextFormField(
                                    controller: splitifyControler.dateInput,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.fromLTRB(15, 0, 0, 8)),
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime(2101));
                                      if (pickedDate != null) {
                                        print(pickedDate);
                                        String formattedDate =
                                            DateFormat('dd-MM-yyyy')
                                                .format(pickedDate);
                                        print(formattedDate);
                                        setState(() {
                                          splitifyControler.dateInput.text =
                                              formattedDate;
                                        });
                                      } else {
                                        print("Date is not selected");
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              AppText(
                                text: AppString.person,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: SizeUtils.horizontalBlockSize * 5),
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFB3E5FC),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  height: SizeUtils.verticalBlockSize * 5,
                                  width: SizeUtils.horizontalBlockSize * 35,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: _listView()),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        Expanded(child: _addTile()),
                        GestureDetector(
                          onTap: () async {
                            adduserdetail userDetail = adduserdetail(
                              name1: splitifyControler.controllers.string,
                              userId: FirebaseAuth.instance.currentUser?.uid,
                            );
                            await splitifyControler
                                .insertUserDetail(userDetail);
                            print("controller${splitifyControler.controllers}");

                            // AppPreference.setString("journeyname", splitifyControler.writeATripController.text);
                            // AppPreference.setString("uname", splitifyControler.controllers.string);
                            FocusManager.instance.primaryFocus?.unfocus();

                            Navigation.pushNamed(Routes.userListPage, arg: {
                              "journeyname":
                                  splitifyControler.writeATripController.text,
                              "uname": splitifyControler.controllers,
                            });
                            // print("next${splitifyControler.controllers}");
                            //splitifyControler.controllers = "" as RxList;
                            // splitifyControler.controllers.clear();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: SizeUtils.verticalBlockSize * 17,
                            height: SizeUtils.horizontalBlockSize * 11,
                            decoration: BoxDecoration(
                              color: Color(0xF0033843),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: AppText(
                              text: AppString.next,
                              fontSize: SizeUtils.fSize_16(),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _listView() {
    return Padding(
      padding: EdgeInsets.only(top: SizeUtils.horizontalBlockSize * 6),
      child: ListView.builder(
        itemCount: splitifyControler.fields.length,
        itemBuilder: (context, index) {
          return Container(
            height: SizeUtils.verticalBlockSize * 5,
            decoration: BoxDecoration(
              color: Color(0xFFB3E5FC),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(8),
            child: splitifyControler.fields[index],
          );
        },
      ),
    );
  }

  Widget _addTile() {
    return ListTile(
      title: Container(
        alignment: Alignment.center,
        //width: SizeUtils.verticalBlockSize * 20,
        height: SizeUtils.horizontalBlockSize * 11,
        decoration: BoxDecoration(
          color: Color(0xF0033843),
          borderRadius: BorderRadius.circular(15),
        ),
        child: AppText(
          text: AppString.add,
          fontSize: SizeUtils.fSize_16(),
          color: Colors.white,
        ),
      ),

      onTap: () {
        final controller = TextEditingController();
        final field = CustomTextField(
          alignment: Alignment.center,
          borderRadius: BorderRadius.circular(8),
          suffixIcon: InkWell(
              child: Icon(Icons.delete),
              onTap: () {
                setState(() {
                  //splitifyControler.fields.removeAt(field);
                  print("controller${splitifyControler.controllers}");
                  // textformFields.remove(tagForm(controller));
                });
              }),
          controller: controller,
          keyboardType: TextInputType.text,
          contentPadding: EdgeInsets.fromLTRB(15, 20, 20, 11),
          hintText:
              "  ${splitifyControler.controllers.length + 1} Enter Name...",
        );

        setState(() {
          splitifyControler.controllers.add(controller);
          splitifyControler.fields.add(field);
        });
        /* setState(() {
          splitifyControler.controllers.add(controller);
          splitifyControler.fields.remove(field);
        });*/
      },
    );
  }

/* _commonTextField({
    FormFieldValidator<String>? validator,
    final TextEditingController? controller,
    GestureTapCallback? onTap,
    List<TextInputFormatter>? inputFormatters,
    final String? hintText,
    TextInputType? keyboardType,
  }) {
    return Container(
      height: SizeUtils.verticalBlockSize * 5,
      decoration: BoxDecoration(
        color: Colors.indigo.shade100,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        validator: validator,
        controller: controller,
        onTap: onTap,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: EdgeInsets.fromLTRB(15, 0, 20, 11),
        ),
      ),
    );
  }*/
}
