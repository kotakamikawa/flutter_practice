import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'book.dart';

class BookListModel extends ChangeNotifier {
  List<Book> books = [];

  Future fetchBooks() async {
    final snapShots =
        await FirebaseFirestore.instance.collection('books').get();
    final books = snapShots.docs.map((doc) => Book(doc['title'])).toList();
    this.books = books;
    notifyListeners();
  }
}
