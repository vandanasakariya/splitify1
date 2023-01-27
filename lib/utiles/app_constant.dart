
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppConstant {
  static final FirebaseFirestore databaseReference = FirebaseFirestore.instance;
  static final FirebaseAuth kFirebaseAuth = FirebaseAuth.instance;
  static final CollectionReference _collectionReference =
  databaseReference.collection('userDetail');

}

// class FirebaseHelper {
//   static FirebaseFirestore collectionReference = FirebaseFirestore.instance;
//   static final FirebaseHelper _firebaseService = FirebaseHelper._internal();
//   factory FirebaseHelper() {
//     return _firebaseService;
//   }
//   FirebaseHelper._internal();
// }
