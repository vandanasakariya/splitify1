import 'package:cloud_firestore/cloud_firestore.dart';

class GetUserDetail {
  String? name1;
  String? userId;
  String? amount;

  /*String? name2;
  String? name3;
  String? name4;
  String? name5;
*/
  GetUserDetail({
    this.name1,
    this.userId,
    this.amount,
    /*this.name2,
    this.name3,
    this.name4,
    this.name5,*/
  });

  GetUserDetail.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    name1 = data['name1'] ?? '';
    userId = data['userId'] ?? '';
    amount = data['amount'] ?? '';
    /*name2 = data['name2'] ?? '';
    name3 = data['name3'] ?? '';
    name4 = data['name4'] ?? '';
    name5 = data['name5'] ?? '';*/
  }

  GetUserDetail.fromJson(Map<String, dynamic> json) {
    name1 = json['name1'] ?? '';
    userId = json['userId'] ?? '';
    amount = json['amount'] ?? '';
    /*name2 = json['name2'] ?? '';
    name3 = json['name3'] ?? '';
    name4 = json['name4'] ?? '';*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name1'] = name1;
    data['userId'] = userId;
    data['amount'] = amount;
    /*data['name2'] = name2;
    data['name3'] = name3;
    data['name4'] = name4;
    data['name5'] = name5;*/

    return data;
  }
}
