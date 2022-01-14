import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_suitmedia_application/providers/UsersProvider.dart';

import 'package:test_suitmedia_application/view/FirstScreenPage.dart';
import 'package:test_suitmedia_application/view/SecondScreenPage.dart';
import 'package:test_suitmedia_application/view/ThirsScreenPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider (
      create: (context) => UsersProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FirstScreenPage(),
      ),
    );
  }
}


