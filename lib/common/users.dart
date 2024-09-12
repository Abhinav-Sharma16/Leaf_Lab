import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = 'users';

  createUser(Map<String, dynamic> data) {
    _firestore
        .collection(ref)
        .doc(data['userId'])
        .set(data)
        .catchError((e) => {print(e.toString())});
  }
}
