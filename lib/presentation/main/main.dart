import 'package:coriander/presentation/login/login_page.dart';
import 'package:coriander/presentation/signup/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../book_list/book_list.dart';
import 'main_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // ここ大事！
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: ChangeNotifierProvider<MainModel>(
        create: (_) => MainModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('コリアンダー'),
          ),
          body: Consumer<MainModel>(builder: (context, model, child) {
            return Center(
              child: Column(
                children: [
                  Text(
                    model.kboyText,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  RaisedButton(
                    child: Text('本一覧'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BookListPage()),
                      );
                    },
                  ),
                  RaisedButton(
                    child: Text('新規登録'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                  ),
                  RaisedButton(
                    child: Text('ログイン'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
