import 'package:coriander/domain/book.dart';
import 'package:coriander/presentation/add_book/add_book_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'book_list_model.dart';

class BookListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetchBooks(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('本一覧'),
        ),
        body: Consumer<BookListModel>(builder: (context, model, child) {
          final books = model.books;
          final listTiles = books
              .map((book) => ListTile(
                    leading: Image.network(book.imageURL),
                    title: Text(book.title),
                    trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddBookPage(book: book),
                              fullscreenDialog: true,
                            ),
                          );
                          model.fetchBooks();
                        }),
                    onLongPress: () async {
                      await showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('${book.title}削除しますか？'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  await deleteBook(context, model, book);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ))
              .toList();
          return ListView(
            children: listTiles,
          );
        }),
        floatingActionButton:
            Consumer<BookListModel>(builder: (context, model, child) {
          return FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBookPage(),
                  fullscreenDialog: true,
                ),
              );
              model.fetchBooks();
            },
          );
        }),
      ),
    );
  }

  Future deleteBook(
      BuildContext context, BookListModel model, Book book) async {
    try {
      await model.deleteBook(book);
      //await _showDialog(context, '削除しました');
      await model.fetchBooks();
    } catch (e) {
      //await _showDialog(context, e.toString());
    }
  }

  Future _showDialog(BuildContext context, String title) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
