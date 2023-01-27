
import 'package:cloud_firestore/cloud_firestore.dart';

class GetUserDetail {
  String? tripName;
  String? userId;
  int? amount;
  String? note;
  String? username;

  GetUserDetail({
    this.tripName,
    this.userId,
    this.amount,
    this.note,
    this.username,

  });

  GetUserDetail.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    tripName = data['tripName'] ?? '';
    userId = data['userId'] ?? '';
    amount = data['amount'] ?? 0;
    note = data['note'] ?? '';
    username = data['username'] ?? '';

  }

  GetUserDetail.fromJson(Map<String, dynamic> json) {
    tripName = json['tripName'] ?? '';
    userId = json['userId'] ?? '';
    amount = json['amount'] ?? 0;
    note = json['note'] ?? '';
    username = json['username'] ?? '';

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tripName'] = tripName;
    data['userId'] = userId;
    data['amount'] = amount;
    data['note'] = note;
    data['username'] = username;

    return data;
  }
}
