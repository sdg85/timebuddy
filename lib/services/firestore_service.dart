import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class FirestoreService {
  final _firestoreEmployeeDb = Firestore.instance.collection("employees");

  Future createUser(String uid, User user) async {
    try {
      await _firestoreEmployeeDb.document(uid).setData(user.toJson());

    } catch (e) {
      print("create user data in firestore service: "+e.toString());
      return null;
    }
  }
}
