import 'package:flutter/material.dart';
import 'package:splitify/navigation-utils/size_utils.dart';
import 'package:splitify/theam/app_string.dart';
import 'package:splitify/user_detail_page/controller/splitify_controller.dart';
import 'package:get/get.dart';
import 'package:splitify/widget/custom_text.dart';
import '../../navigation-utils/navigation.dart';
import '../../navigation-utils/routes.dart';
import '../../theam/app_img.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final SplitifyControler splitifyController = Get.find();

  @override
  Widget build(BuildContext context) {
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
              padding:  EdgeInsets.only(top: SizeUtils.horizontalBlockSize*6),
              child: AppText(text: AppString.history,fontSize: SizeUtils.fSize_20()),
            ),
              Expanded(
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:  EdgeInsets.all(10),
                      child: Container(
                        height: SizeUtils.horizontalBlockSize * 23,
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
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(colors: [
                                      Colors.purple.shade200,
                                      Colors.deepPurple.shade200
                                    ])),
                                child: CircleAvatar(
                                  radius: SizeUtils.fSize_24(),
                                  backgroundColor: Colors.transparent,
                                  child: Text(
                                    "${splitifyController.writeATripController.text.toString().split("text").last.replaceAll(":", "").split("┤").last.split("├").first.substring(0, 1).toUpperCase()}",
                                    style: TextStyle(
                                        fontSize: SizeUtils.fSize_24(),
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: SizeUtils.verticalBlockSize * 2),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${splitifyController.writeATripController.text}",
                                        style: TextStyle(
                                            fontSize: SizeUtils.fSize_16())),
                                    SizedBox(
                                        height: SizeUtils.verticalBlockSize * 0.2),
                                    Text("${splitifyController.fields.length} Person",
                                        style: TextStyle(
                                            fontSize: SizeUtils.fSize_16(),color: Colors.grey.shade500)),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text("data"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
