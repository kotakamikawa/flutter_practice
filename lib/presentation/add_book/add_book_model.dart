import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coriander/domain/book.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddBookModel extends ChangeNotifier {
  String bookTitle = '';
  File imageFile;
  bool isLoading = false;

  startLoading() {
    isLoading = true;
    notifyListeners();
  }

  endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future showImagePicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    imageFile = File(pickedFile.path);
    notifyListeners();
  }

  Future addBookToFirebase() async {
    if (bookTitle.isEmpty) {
      throw ('タイトルを入力してください');
    }
    final imageURL = await _uploadImage();

    CollectionReference books = FirebaseFirestore.instance.collection('books');
    books
        .add({
          'title': bookTitle,
          'imageURL': imageURL,
          'createdAt': Timestamp.now()
        })
        .then((value) => {print("book Added")})
        .catchError((error) => print("Failed to add book: $error"));
  }

  Future updateBook(Book book) async {
    final imageURL = _uploadImage();
    final doc = FirebaseFirestore.instance.collection('books').doc(book.docId);
    await doc.update({
      'title': bookTitle,
      'imageURL': imageURL,
      'updateAt': Timestamp.now()
    });
  }

  Future<String> _uploadImage() async {
    await firebase_storage.FirebaseStorage.instance
        .ref('books/$bookTitle')
        .putFile(imageFile);
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref('books/$bookTitle')
        .getDownloadURL();
    return downloadURL;
  }
}
