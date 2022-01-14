import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_suitmedia_application/theme/theme.dart';
import 'dart:io';

import 'package:test_suitmedia_application/view/SecondScreenPage.dart';

class FirstScreenPage extends StatefulWidget {
  @override
  State<FirstScreenPage> createState() => _FirstScreenPageState();
}

class _FirstScreenPageState extends State<FirstScreenPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController polindromeController = TextEditingController();
  @override
  void initState() {
    _nameSaver();
    super.initState();
  }
  _nameSaver() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('nama', nameController.text);
    print(nameController.text);
  }

  isPolindrome() {
    String original = polindromeController.text;
    String? reverse = original.split('').reversed.join('');
    if (original == "") {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text(
            'Input Word Please',
          ),
        ),
      );

    } else if (original == reverse) {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text(
            'Is Palindrome',
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text(
            'Not Palindrome',
          ),
        ),
      );
    }
  }

  Widget header() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.only(top: 142.0),
        child: Image.asset(
          'assets/btn_add_photo .png',
          width: 116.0,
        ),
      ),
    );
  }

  Widget inputField(String title, TextEditingController controller) {
    return Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: TextFormField(
            controller: controller,
            style: primaryTextStyle,
            decoration: InputDecoration.collapsed(
                hintText: title,
                hintStyle:
                    thirdTextStyle.copyWith(fontSize: 16, fontWeight: medium)),
          ),
        ));
  }

  Widget button(String title, VoidCallback onPressed) {
    return SizedBox(
      height: 41,
      width: double.infinity,
      child: TextButton(
        onPressed: () => onPressed(),
        style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0))),
        child: Text(
          title,
          style: whiteTextStyle.copyWith(fontWeight: medium),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    navigateTo(context, target) {
      _nameSaver();
      Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => target,
          ),
      );
    }

    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background.png"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: transparentColor,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  header(),
                  const SizedBox(
                    height: 51,
                  ),
                  inputField("Name", nameController),
                  const SizedBox(
                    height: 15,
                  ),
                  inputField("Palindrome", polindromeController),
                  const SizedBox(
                    height: 45,
                  ),
                  button("CHECK", () {
                    isPolindrome();
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  button("NEXT", () {
                    navigateTo(context, SecondScreenPage(isName: false,nameUser: "",));
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
