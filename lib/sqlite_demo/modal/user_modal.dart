/*class UserModal {
  String? tripName;
  String? userName;
  String? amount;


  UserModal({
    this.tripName,
    this.userName,
    this.amount,


  });

 */ /* UserModal.fromDocumentSnapshot(
      DocumentSnapshot documentSnapshot,
      ) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    tripName = data['tripName'] ?? '';
    userName = data['userName'] ?? '';
    amount = data['amount'] ?? '';

  }*/ /*

  UserModal.fromJson(Map<String, dynamic> json) {
    tripName = json['tripName'] ?? '';
    userName = json['userName'] ?? '';
    amount = json['amount'] ?? '';

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tripName'] = tripName;
    data['userName'] = userName;
    data['amount'] = amount;

    return data;
  }
}*/

class User {
  int? id;
  String tripName;
  int amount;
  String userName;

  User(
      {this.id,
      required this.tripName,
      required this.amount,
      required this.userName});

  User.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        tripName = res["tripName"],
        amount = res["amount"],
        userName = res["userName"];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'tripName': tripName,
      'amount': amount,
      'userName': userName
    };
  }
}
