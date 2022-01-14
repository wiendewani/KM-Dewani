import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_suitmedia_application/theme/theme.dart';
// import 'package:flutter/services.dart';
import 'package:test_suitmedia_application/view/ThirsScreenPage.dart';

class SecondScreenPage extends StatefulWidget {
  final String nameUser;
  final bool isName;

  SecondScreenPage({required this.isName, required this.nameUser});

  @override
  State<SecondScreenPage> createState() =>
      _SecondScreenPageState(nameUser: nameUser, isName: isName);
}

class _SecondScreenPageState extends State<SecondScreenPage> {
  late String nameUser = "Selected User Name";
  bool isName;
  String nameText = 'test';
  String defaultName = "Selected User Name";

  _SecondScreenPageState({required this.nameUser, required this.isName});

  @override
  void initState() {
    super.initState();
    _nameRetriever();
    if (isName == false) {
      nameUser =defaultName;
    } else {
      setState(() {
        nameUser = nameUser;
      });
    }
  }


  _nameRetriever() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nameText = prefs.getString('nama') ?? '';
      print(nameText);
    });
  }

  @override
  Widget build(BuildContext context) {
    navigateTo(context, target) {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => target,
        ),
      );
    }

    PreferredSizeWidget appBar() {
      return PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          // systemOverlayStyle: const SystemUiOverlayStyle(
          //   // Navigation bar
          //   statusBarColor: Colors.white, // Status bar
          // ),
          backgroundColor: bgColor,
          elevation: 0.5,
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Image.asset('assets/Back_press_area.png')),
          centerTitle: true,
          title: Text(
            'Second Screen',
            style:
                primaryTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
          ),
        ),
      );
    }

    Widget header() {
      return Container(
        margin: const EdgeInsets.only(top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome",
              style: primaryTextStyle.copyWith(fontSize: 12),
            ),
            Text(
              nameText,
              style:
                  primaryTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
            ),
          ],
        ),
      );
    }

    Widget content() {
      return Expanded(
        child: Align(
            alignment: Alignment.center,
            child: Text(
              nameUser,
              style:
                  primaryTextStyle.copyWith(fontSize: 24, fontWeight: semiBold),
            )),
      );
    }

    Widget button() {
      return Container(
        margin: const EdgeInsets.only(bottom: 32),
        height: 41,
        width: double.infinity,
        child: TextButton(
          onPressed: () {
            navigateTo(context, ThirdScreenPage());
          },
          style: TextButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0))),
          child: Text(
            "Choose a User",
            style: whiteTextStyle.copyWith(fontWeight: medium),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBar(),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [header(), content(), button()],
        ),
      ),
    );
  }
}
