import 'package:ecommerse/screens/authentication/view/screen_login.dart';
import 'package:ecommerse/screens/profile/view/screen_change_password.dart';
import 'package:ecommerse/utils/securestorage/secure_storage.dart';
import 'package:flutter/material.dart';

class ScreenProfileProvider with ChangeNotifier {
  void popPage(context) {
    Navigator.pop(context);
  }

  void navogationToChangePassword(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ScreenChangePassword(),
      ),
    );
  }

  void logOut(context) async {
    /* token  set as NULL  into secure storage   */

    await UserSecureStorage.setToken(null);

    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
      builder: (context) {
        return ScreenLogin();
      },
    ), (route) => false);
  }
}
