import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Database {
  Future addUserInfo(Map<String, dynamic> userInfoMap, String Id) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Id)
        .set(userInfoMap);
  }

  Future addUserExpense(Map<String, dynamic> userExpense, String Id) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Id)
        .collection('Expenses')
        .add(userExpense);
  }

  Future addUserIncome(Map<String, dynamic> userIncome, String Id) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Id)
        .collection('Incomes')
        .add(userIncome);
  }

  // get form DB
  Future getUserDetails(String id) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = snapshot.get('name') ?? '';
    String userEmail = snapshot.get('email') ?? '';

    prefs.setString("userName", userName);
    prefs.setString("userEmail", userEmail);
  }

  Future getUserExpense(String id) async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance
                .collection('users')
                .doc(id)
                .collection('Expenses')
                .get()
            as QuerySnapshot;

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<List<Map<String, dynamic>>> getUserExpenseByCategory(
    String id,
    String category,
  ) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('Expenses')
        .where('category', isEqualTo: category)
        .get();

    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }
}
