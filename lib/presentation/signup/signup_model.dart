import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coriander/domain/book.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpModel extends ChangeNotifier {
  String mail = '';
  String password = '';
  Future signUp() async {
    if (mail.isEmpty) {
      throw ('メールアドレスを入力してください');
    }

    if (password.isEmpty) {
      throw ('パスワードを入力してください');
    }

    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: mail, password: password);

    FirebaseFirestore.instance
        .collection('users')
        .add({'email': mail, 'createdAt': Timestamp.now()});
  }
}
