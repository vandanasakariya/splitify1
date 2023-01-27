import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splitify/theam/app_img.dart';
import 'package:splitify/theam/app_string.dart';
import 'package:splitify/user_detail_page/controller/splitify_controller.dart';
import 'package:get/get.dart';
import 'package:splitify/utiles/app_constant.dart';
import 'package:splitify/widget/custom_text.dart';
import 'package:splitify/widget/custom_textfield.dart';
import '../../modal/setuserdetail.dart';
import '../../navigation-utils/size_utils.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final SplitifyControler splitifyController = Get.find()
    ..getOnBoardingDetail()
    ..insertUserDetail;
  late final AppConstant appConstant;

  bool isEditing = false;
  User? userId = FirebaseAuth.instance.currentUser;
  var data;
  var dropdownvalue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splitifyController.getOnBoardingDetail();
    splitifyController.amountController;
  }

  List<adduserdetail> addUser = [];

  @override
  Widget build(BuildContext context) {


/*    data = Get.arguments;
    List data2 = data["uname"];*/
    //log("data${data.toString()}");
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImage.bg),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: SizeUtils.verticalBlockSize * 3,
                    top: SizeUtils.horizontalBlockSize * 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${splitifyController.writeATripController.text}")
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _commonContainer(
                    height: SizeUtils.verticalBlockSize * 10,
                    width: SizeUtils.verticalBlockSize * 40,
                    // color: Colors.yellow.shade200,
                    color: Color(0xFFB3E5FC),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: SizeUtils.horizontalBlockSize * 3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppString.totalExpense,
                              style: TextStyle(
                                  fontSize: SizeUtils.fSize_17(),
                                  fontWeight: FontWeight.bold)),
                          //Text("500",style: TextStyle(fontSize: SizeUtils.fSize_16())),
                          GestureDetector(
                            child: Text(
                                "${splitifyController.amountController.toString().split("text").last.replaceAll(":", "").split("┤").last.split("├").first}"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: SizeUtils.verticalBlockSize * 2),
                height: SizeUtils.horizontalBlockSize * 28,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("userDetail")
                        .where("userId",
                            isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text("something wrong");
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CupertinoActivityIndicator(),
                        );
                      }
                      if (snapshot.data!.docs.isEmpty) {
                        return Text("no data found");
                      }
                      /* if (snapsh ot != null && snapshot.data != null) {*/
                      return Flexible(
                        flex: 1,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: splitifyController.controllers
                              .length /*snapshot.data!.docs
                                .length*/ /*splitifyController.controllers.length*/,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              width: SizeUtils.horizontalBlockSize * 27,
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
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            SizeUtils.verticalBlockSize * 1),
                                    child: Text(
                                      splitifyController.controllers[index]
                                          /*snapshot.data!.docs[index]["username"]*/
                                          .toString()
                                          .split("text")
                                          .last
                                          .replaceAll(":", "")
                                          .split("┤")
                                          .last
                                          .split("├")
                                          .first,
                                      style: TextStyle(
                                          fontSize: SizeUtils.fSize_16()),
                                    ),
                                  ),
                                  Text(
                                    splitifyController.controllers[index]
                                        /*snapshot.data!.docs[index]["username"]*/
                                        .toString()
                                        .split("text")
                                        .last
                                        .replaceAll(":", "")
                                        .split("┤")
                                        .last
                                        .split("├")
                                        .first
                                        .substring(0, 1)
                                        .toUpperCase(),
                                    style: TextStyle(
                                        fontSize: SizeUtils.fSize_25()),
                                  ),
                                  Text("${splitifyController.amountController.text}"),
                                  /* Text(
                                      "${snapshot.data![position].userName.toString().split("text").last.replaceAll(":", "").split("┤").last.split("├").first.substring(0, 1).toUpperCase()}",
                                      style: TextStyle(fontSize: SizeUtils.fSize_30()),
                                    ),*/
                                ],
                              ),
                            );
                          },
                        ),
                      );
                      //    }
                      return Container();
                    }),
              ),
              Expanded(flex: 30, child: _listView()),
              Spacer(),
              Form(
                key: splitifyController.formKeySecondScreen,
                child: GestureDetector(
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
                                Container(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const AppText(
                                            text: AppString.name,
                                          ),
                                          CustomTextField(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            height:
                                                SizeUtils.verticalBlockSize * 5,
                                            width:
                                                SizeUtils.horizontalBlockSize *
                                                    38,
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.purple.shade200,
                                                Colors.deepPurple.shade200
                                              ],

                                              // tileMode: TileMode.clamp
                                            ),
                                            contentPadding: EdgeInsets.fromLTRB(
                                                15, 0, 20, 11),
                                            controller: splitifyController
                                                .usernameController,
                                          ),
                                          /* StreamBuilder(
                                            stream: AppConstant
                                                .databaseReference
                                                .collection("userDetail")
                                                .snapshots(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<
                                                        QuerySnapshot<
                                                            Map<String,
                                                                dynamic>>>
                                                    snapshot) {
                                              return DropdownButton(
                                                items: snapshot.data!.docs
                                                    .map((DocumentSnapshot
                                                        document) {

                                                  return DropdownMenuItem(
                                                    value: dropdownvalue,
                                                    child:  Text("${document.data}"),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    dropdownvalue =
                                                        value as String;
                                                  });
                                                },
                                              );
                                            },
                                          ),*/
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: SizeUtils.verticalBlockSize *
                                                2),
                                        child: Container(
                                          child: Center(
                                              /* child: Text(
                                                  "${data["uname"].toString().split("text").last.replaceAll(":", "").split("┤").last.split("├").first.substring(0, 1).toUpperCase()}",
                                                  style: TextStyle(
                                                      fontSize: SizeUtils.fSize_25(),
                                                      fontWeight: FontWeight.bold)),*/
                                              ),
                                          /* Text(
                                                  "${splitifyController.usernameController.toString().split("text").last.replaceAll(":", "").split("┤").last.split("├").first.substring(0,1).toUpperCase()}") ,*/
                                          height:
                                              SizeUtils.verticalBlockSize * 8,
                                          width: SizeUtils.horizontalBlockSize *
                                              20,
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
                                          CustomTextField(
                                            keyboardType: TextInputType.number,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            height:
                                                SizeUtils.verticalBlockSize * 5,
                                            width:
                                                SizeUtils.horizontalBlockSize *
                                                    38,
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.purple.shade200,
                                                Colors.deepPurple.shade200
                                              ],

                                              // tileMode: TileMode.clamp
                                            ),
                                            contentPadding: EdgeInsets.fromLTRB(
                                                15, 0, 20, 11),
                                            controller: splitifyController
                                                .amountController,
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
                                          CustomTextField(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            height:
                                                SizeUtils.verticalBlockSize * 5,
                                            width:
                                                SizeUtils.horizontalBlockSize *
                                                    63,
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.purple.shade200,
                                                Colors.deepPurple.shade200
                                              ],

                                              // tileMode: TileMode.clamp
                                            ),
                                            contentPadding: EdgeInsets.fromLTRB(
                                                15, 0, 20, 11),
                                            controller: splitifyController
                                                .noteController,
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
                                    /*  amount: splitifyController
                                          .amountController.text.,*/
                                      note: splitifyController
                                          .noteController.text,
                                      username: splitifyController
                                          .usernameController.text,
                                      userId: FirebaseAuth
                                          .instance.currentUser?.uid,
                                    );
                                    await splitifyController
                                        .insertUserDetail(userDetail);
                                    SplitifyControler.updateChecklist(
                                        amount: splitifyController
                                            .amountController as int);
                                    //addOrEditUser();
                                    final field = Container(
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  gradient:
                                                      LinearGradient(colors: [
                                                    Colors.purple.shade200,
                                                    Colors.deepPurple.shade200
                                                  ])),
                                              child: CircleAvatar(
                                                radius: SizeUtils.fSize_24(),
                                                backgroundColor:
                                                    Colors.transparent,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      "${splitifyController.usernameController.toString().split("text").last.replaceAll(":", "").split("┤").last.split("├").first}",
                                                      style: TextStyle(
                                                          fontSize: SizeUtils
                                                              .fSize_16())),
                                                  Text(
                                                      "${splitifyController.noteController.toString().split("text").last.replaceAll(":", "").split("┤").last.split("├").first}",
                                                      style: TextStyle(
                                                          fontSize: SizeUtils
                                                              .fSize_16())),
                                                ],
                                              ),
                                            ),
                                            Spacer(),
                                            Column(
                                              children: [
                                                Text(
                                                  "${splitifyController.amountController as int}",
                                                  style: TextStyle(
                                                      fontSize:
                                                          SizeUtils.fSize_16()),
                                                ),
                                                Row(
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        // splitifyController.listcont.remove(splitifyController.fields);
                                                      },
                                                      icon: Icon(Icons.delete,
                                                          color: Colors.red),
                                                    ),
                                                    IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(
                                                          Icons
                                                              .edit_calendar_sharp,
                                                          color: Colors.grey,
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                    setState(() {

                                      splitifyController.listcont.add(field);
                                     /* i / splitifyController.controllers.length-i;
                                      splitifyController.listcont.remove(field);*/
                                    });
                                    Navigator.pop(context);
                                    /*final int i=splitifyController.amountController.text as int;
                                    i/splitifyController.controllers.length-i;*/
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
              ),
              SizedBox(
                height: SizeUtils.verticalBlockSize * 3,
              )
            ],
          ),
        ),
      ),
    );
  }

  _commonContainer({
    double? width,
    double? height,
    final Color? color,
    final Gradient? gradient,
    final String? text,
    final Widget? child,
  }) {
    return Container(
      width: width,
      height: height,
      child: child,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
    );
  }

  Widget _listView() {
    return Padding(
      padding: EdgeInsets.only(top: SizeUtils.horizontalBlockSize * 6),
      child: ListView.builder(
        itemCount: splitifyController.listcont.length,
        itemBuilder: (context, index) {
          return Container(
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
              margin: const EdgeInsets.all(8),
              child: splitifyController.listcont[index]);
        },
      ),
    );
  }

/* Widget _addTile() {
    return ListTile(
      onTap: () {},
    );
  }*/
/*  Widget userWidget() {
    return FutureBuilder(
      builder:
          (BuildContext context, AsyncSnapshot<List<adduserdetail>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, position) {
                return Dismissible(
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Icon(Icons.delete_forever),
                    ),
                    key: UniqueKey(),
                    onDismissed: (DismissDirection direction) async {
                      await SplitifyControler.deleteChecklist(

                          docId: FirebaseAuth.instance.currentUser?.uid);
                    },
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      */ /*onTap: () => populateFields(snapshot.data![position]), */ /*
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      "${snapshot.data![position].userId}",
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 6.0, 12.0, 12.0),
                                    child: Text(
                                      "${snapshot.data![position].amount.toString()}",
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black26,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "${snapshot.data![position].note.toString()}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            height: 2.0,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ));
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }*/

}
