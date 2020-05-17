import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class WorkShiftService {
  final db = Firestore.instance;

  //get all work shifts for the given month
  Future<QuerySnapshot> getAllWorkShiftsByMonth(DateTime date) async {
    final period = DateFormat("yyyyMM").format(date);
    return await db.collection("work_shift")
    .where("period", isEqualTo: period)
    .getDocuments();
  }

  //get user workshifts by month
  Future<QuerySnapshot> getUserWorkShiftsByMonth(String userId, DateTime date) async {
    print("user work shifts of the month loaded");
    final period = DateFormat("yyyyMM").format(date);
     
     return await db.collection("work_shift")
    .where("employeeId", isEqualTo: userId)
    .where("period", isEqualTo: period)
    .getDocuments();
  }

  Future<QuerySnapshot> getWorkShiftsByDay(DateTime date) async {
     return await db.collection("work_shift")
    .where("date", isEqualTo: DateFormat("yyyyMMdd").format(date))
    .getDocuments();
  }

  void getUsersByIds(){
    db.collection("employees").where("uid", arrayContains: ['0a7UY5KXDV5V3Gmmtiip', '6yEitexpEhuZd3ac3TBW']).getDocuments()
    .then((doc) => print(doc.documents))
    .catchError((error) => print(error));
  }
}