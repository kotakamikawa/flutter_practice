import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coriander/domain/book.dart';
import 'package:flutter/material.dart';

class BookListModel extends ChangeNotifier {
  List<Book> books = [];

  Future fetchBooks() async {
    final snapShots =
        await FirebaseFirestore.instance.collection('books').get();
    final books = snapShots.docs.map((doc) => Book(doc)).toList();
    this.books = books;
    notifyListeners();
  }

  Future deleteBook(Book book) async {
    await FirebaseFirestore.instance
        .collection('books')
        .doc(book.docId)
        .delete();
  }
}
