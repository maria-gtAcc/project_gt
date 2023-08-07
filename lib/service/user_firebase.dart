import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference userCollection =
    FirebaseFirestore.instance.collection('users');
FirebaseFirestore userFirestore = FirebaseFirestore.instance;

Future addUserData(
    String firstName, String lastName, String userId, String email) async {
  Map<String, dynamic> userData = {
    'first name': firstName,
    'last name': lastName,
    'user id': userId,
    'email': email,
  };
  await userCollection.doc(userId).set(userData);
}
