import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // 社員コードでユーザーを取得
  Future<Map<String, dynamic>?> getEmployee(String employeeCode) async {
    final doc = await _db.collection('employees').doc(employeeCode).get();

    if (doc.exists) {
      return doc.data();
    } else {
      return null;
    }
  }
}
