// import 'dart:developer';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:splitify/user_detail_page/controller/splitify_controller.dart';
//
// class GoogleSign {
//   final SplitifyControler splitifyControler = Get.find();
//
//   Future<UserCredential> signInWithGoogle() async {
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//     log("googleUser--------googleUser :$googleUser");
//     final GoogleSignInAuthentication? googleAuth =
//         await googleUser?.authentication;
//     splitifyControler.userid.value = googleUser?.id ?? "";
//     log("googleUser--------googleAuth :${googleUser?.id}");
//     log("googleUser--------googleAuth :${googleUser?.email}");
//     log("googleUser--------googleAuth :${googleUser?.photoUrl}");
//     log("googleUser--------googleAuth :${googleUser?.displayName}");
//     log("googleUser--------googleAuth :$googleAuth");
//
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth?.accessToken,
//       idToken: googleAuth?.idToken,
//     );
//     log("googleUser--------credential :$credential");
//
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   }
// }
