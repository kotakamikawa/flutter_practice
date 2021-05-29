import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Book {
  Book(DocumentSnapshot doc) {
    docId = doc.id;
    title = doc['title'];
    imageURL = doc['imageURL'];
  }

  String docId;
  String title;
  String imageURL;
}
