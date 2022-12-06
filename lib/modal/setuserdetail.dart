import 'package:cloud_firestore/cloud_firestore.dart';

class adduserdetail {
  String? name1;
  String? userId;
  String? amount;

  adduserdetail({
    this.name1,
    this.userId,
    this.amount,
  }) {}

  adduserdetail.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    name1 = data["name1"] ?? '';
    userId = data["userId"] ?? '';
    amount = data["amount"] ?? '';

  }

  adduserdetail.fromJson(Map<String, dynamic> json) {
    name1 = json["name1"] ?? '';
    userId = json["userId"] ?? '';
    amount = json["amount"] ?? '';

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name1'] = name1;
    data['userId'] = userId;
    data['amount'] = amount;

    return data;
  }
}
