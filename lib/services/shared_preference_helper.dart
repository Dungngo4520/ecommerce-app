import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static final String signInEmailInputKey = 'SIGNINEMAILINPUTKEY';
  static final String signInPasswordInputKey = 'SIGNINPASSWORDINPUTKEY';
  static final String isOpenedKey = "ISOPENEDKEY";

// set

  Future<bool> saveSignInEmailInput(String getsignInEmailInput) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(signInEmailInputKey, getsignInEmailInput);
  }

  Future<bool> saveSignInPasswordInput(String getsignInPasswordInput) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(
        signInPasswordInputKey, getsignInPasswordInput);
  }

  Future<bool> saveIsOpened(bool isOpened) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setBool(isOpenedKey, isOpened);
  }

  // get

  Future<String?> getSignInEmailInput() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(signInEmailInputKey);
  }

  Future<String?> getSignInPasswordInput() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(signInPasswordInputKey);
  }

  Future<bool?> getIsOpened() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(isOpenedKey);
  }
}
