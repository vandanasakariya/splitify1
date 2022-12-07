import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:splitify/theam/app_img.dart';
import 'package:splitify/theam/app_string.dart';
import 'package:splitify/user_detail_page/controller/splitify_controller.dart';
import 'package:get/get.dart';
import 'package:splitify/widget/custom_text.dart';
import '../../modal/setuserdetail.dart';
import '../../navigation-utils/size_utils.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

//String value = "";

class _UserListPageState extends State<UserListPage> {
  final SplitifyControler splitifyController = Get.find()
    ..getOnBoardingDetail();
  var data;
  var dropdownvalue = 0;
  int i = 0;

  //final items = List<String>.generate(20, (i) => "Item ${i + 1}");
  final items = List<String>.generate(0, (i) => "${i + 1}");

  @override
  Widget build(BuildContext context) {
    data = Get.arguments;
    List data2 = data!["uname"];
    log("data${data.toString()}");
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeUtils.verticalBlockSize * 2,
                vertical: SizeUtils.horizontalBlockSize * 2),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: SizeUtils.verticalBlockSize * 3,
                      top: SizeUtils.horizontalBlockSize * 4),
                  child: Text(
                    data["journeyname"],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: SizeUtils.fSize_20(), color: Colors.black),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _commonContainer(
                      height: SizeUtils.verticalBlockSize * 12,
                      width: SizeUtils.horizontalBlockSize * 43,
                      color: Colors.yellow.shade200,
                      text: AppString.moneyIn,
                    ),
                    _commonContainer(
                      height: SizeUtils.verticalBlockSize * 12,
                      width: SizeUtils.horizontalBlockSize * 43,
                      color: Colors.lightBlueAccent.shade100,
                      text: AppString.moneyOut,
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: SizeUtils.verticalBlockSize * 2),
                  height: SizeUtils.horizontalBlockSize * 27,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: splitifyController.controllers.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        /*  final data =
                            splitifyController.getUserDetailList[index];*/
                        return Container(
                          margin: EdgeInsets.all(5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2,
                                offset: Offset(1, 1),
                              )
                            ],
                          ),

                          width: SizeUtils.horizontalBlockSize * 27,
                          child: Column(
                            children: [
                              Text(
                                "${data["uname"][index].toString().split("text").last.replaceAll(":", "").split("┤").last.split("├").first}",
                                style:
                                    TextStyle(fontSize: SizeUtils.fSize_16()),
                              ),
                              SizedBox(
                                  height: SizeUtils.horizontalBlockSize * 3),
                              Text(
                                "${data["uname"][index].toString().split("text").last.replaceAll(":", "").split("┤").last.split("├").first.substring(0, 1).toUpperCase()}",
                                style:
                                    TextStyle(fontSize: SizeUtils.fSize_30()),
                              ),
                            ],
                          ),
                          //  color: Colors.blue,
                        );
                      }),
                ),
                  /* ListView.builder(
                     scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Dismissible(
                      onDismissed: (direction) {
                        // Removes that item the list on swipwe
                        setState(() {
                          items.removeAt(index);
                        });
                        // Shows the information on Snackbar
                      },
                      background: Container(color: Colors.red),
                      key: Key(item),
                      child: ListTile(
                        title: Column(children: []),
                      ),
                    );
                  },
                ),*/

                Spacer(),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          content: Container(
                            height: SizeUtils.verticalBlockSize * 30,
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const AppText(
                                          text: AppString.name,
                                        ),
                                        Container(
                                          height:
                                              SizeUtils.verticalBlockSize * 5,
                                          width: SizeUtils.horizontalBlockSize *
                                              38,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.purple.shade200,
                                                Colors.deepPurple.shade200
                                              ],
                                              // tileMode: TileMode.clamp
                                            ),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 2,
                                                  offset: Offset(2, 3)),
                                            ],
                                            color: Colors.white,
                                          ),
                                          child: DropdownButton(
                                            items: data2
                                                .map(
                                                  (e) => DropdownMenuItem(
                                                    value:e,
                                                    child: Text(
                                                      "${e.toString().split("text").last.replaceAll(":", "").split("┤").last.split("├").first}",
                                                      style: TextStyle(
                                                          fontSize: SizeUtils
                                                              .fSize_16()),
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                //print("e${e}");
                                                dropdownvalue =
                                                    newValue as int;
                                                print(
                                                    "dropdownvalue${dropdownvalue}");
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                      // DropdownMenuItem(
                                      //         value: "${data["uname"]}",
                                      //         child: Text(
                                      //           "${data["uname"].toString().split("text").last.replaceAll(":", "").split("┤").last.split("├").first}",
                                      //           style: TextStyle(
                                      //               fontSize:
                                      //                   SizeUtils.fSize_16()),
                                      //         ),
                                      //       ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left:
                                              SizeUtils.verticalBlockSize * 2),
                                      child: Container(
                                        height: SizeUtils.verticalBlockSize * 8,
                                        width:
                                            SizeUtils.horizontalBlockSize * 20,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 2,
                                                offset: Offset(1, 2)),
                                          ],
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: SizeUtils.horizontalBlockSize * 4),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const AppText(
                                            text: AppString.amount,
                                          ),
                                          Container(
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(
                                                          15, 0, 20, 11),
                                                  border: InputBorder.none),
                                            ),
                                            height:
                                                SizeUtils.verticalBlockSize * 5,
                                            width:
                                                SizeUtils.horizontalBlockSize *
                                                    38,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.purple.shade200,
                                                  Colors.deepPurple.shade200
                                                ],

                                                // tileMode: TileMode.clamp
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    blurRadius: 2,
                                                    offset: Offset(2, 3)),
                                              ],
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: SizeUtils.verticalBlockSize *
                                                2),
                                        child: Container(
                                          height:
                                              SizeUtils.verticalBlockSize * 8,
                                          width: SizeUtils.horizontalBlockSize *
                                              20,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 2,
                                                  offset: Offset(1, 2)),
                                            ],
                                            color: Colors.black,
                                          ),
                                          child: Image.asset(AppImage.rupee),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: SizeUtils.horizontalBlockSize * 3),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const AppText(
                                            text: AppString.note,
                                          ),
                                          Container(
                                            height:
                                                SizeUtils.verticalBlockSize * 5,
                                            width:
                                                SizeUtils.horizontalBlockSize *
                                                    63,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.purple.shade200,
                                                  Colors.deepPurple.shade200
                                                ],

                                                // tileMode: TileMode.clamp
                                              ),
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    blurRadius: 2,
                                                    offset: Offset(2, 3)),
                                              ],
                                              color: Colors.white,
                                            ),
                                            child: TextFormField(
                                              decoration: const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(
                                                          15, 0, 20, 11),
                                                  border: InputBorder.none),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    adduserdetail userDetail = adduserdetail(
                                      amount: splitifyController
                                          .amountController.text,
                                      userId: FirebaseAuth
                                          .instance.currentUser?.uid,
                                    );
                                    await splitifyController
                                        .insertUserDetail(userDetail);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Add"),
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              SizeUtils.verticalBlockSize * 5,
                                          vertical:
                                              SizeUtils.horizontalBlockSize *
                                                  3),
                                      primary: Colors.red,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18))),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancel"),
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              SizeUtils.verticalBlockSize * 4,
                                          vertical:
                                              SizeUtils.horizontalBlockSize *
                                                  3),
                                      primary: Colors.green,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18))),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: CircleAvatar(
                    child: Icon(Icons.add,
                        size: SizeUtils.horizontalBlockSize * 10),
                    backgroundColor: Colors.grey.shade200,
                    maxRadius: SizeUtils.horizontalBlockSize * 8,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _commonContainer({
    double? width,
    double? height,
    final Color? color,
    final String? text,
    final Gradient? gradient,
  }) {
    print("Df");
    return Container(
      width: width,
      alignment: Alignment.center,
      height: height,
      child: Text(text!),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
    );
  }

/* Widget _addTile() {
    return ListTile(
      title: Container(
        width: SizeUtils.horizontalBlockSize * 85,
        height: SizeUtils.verticalBlockSize * 10,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2,
              offset: Offset(1, 1),
            )
          ],
        ),
      ),
      onTap: () {
        final list = Container(
          child: Row(
            children: [
              CircleAvatar(
                maxRadius: SizeUtils.verticalBlockSize * 5,
                backgroundColor: Colors.blue,
              ),
              Text("Sf")
            ],
          ),
        );

      },
    );
  }*/
}
