import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:test_suitmedia_application/config/globalConfig.dart';
import 'package:test_suitmedia_application/model/Users.dart';
import 'package:http/http.dart' as http;

class UsersProvider with ChangeNotifier {
  late Users responseUser;

  Future<int> getUser() async {
    String url = CONFIG.USER;

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        responseUser = usersFromJson(response.body);
        notifyListeners();
      }

      return response.statusCode;
    } on TimeoutException catch (_) {
      return 500;
    }
  }
}
