import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timebuddy/models/work_shift.dart';

import '../models/user.dart';

class FirestoreService {
  final _firestoreEmployeeDb = Firestore.instance.collection("employees");
  final _firestoreWorkShiftDb = Firestore.instance.collection("work_shift");

  Future createUser(String uid, User user) async {
    try {
      //set default profile image if null
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
          return User.fromData(userData.documentID, userData.data);
        }
        catch(e){
          print(e.toString());
          return null;
        }
      }

      Future<List<User>> getAllEmployees() async {
        print("fetching employees from database.");
        return (await _firestoreEmployeeDb.getDocuments())
        .documents
        .map( (ds) => User.fromData(ds.documentID, ds.data))
        .toList();
      }

      Future createWorkShift(WorkShift workShift) async {
        try{
          await _firestoreWorkShiftDb.document()
          .setData(workShift.toJson());

          return true;
        }
        catch(e){
          print(e.message);
          return false;
        }
      }
}