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

      Future<User> getUser (String uid) async {
        try{
          final userData = await _firestoreEmployeeDb.document(uid).get();
          print(userData.data);
          return User.fromData(userData.data);
        }
        catch(e){
          print(e.toString());
          return null;
        }
      }

      Future<List<User>> getAllEmployees() async {
        return (await _firestoreEmployeeDb.getDocuments())
        .documents
        .map( (ds) => User.fromData(ds.data))
        .toList();
      }
}