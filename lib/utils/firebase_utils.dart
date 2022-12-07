import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

var db = FirebaseFirestore.instance;

storeData(steps) {
  var date = DateFormat().add_yMMMMd().format(DateTime.now());
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user != null) {
      db
          .collection("users")
          .doc(user.email)
          .collection(date)
          .doc("steps")
          .set({"steps": steps});
    }
  });
}
