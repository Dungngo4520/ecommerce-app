import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static String userIdKey = 'USERIDKEY';
  static String userNameKey = 'USERNAMEKEY';
  static String userDisplayNameKey = 'USERDISPLAYNAMEKEY';
  static String userEmailKey = 'USEREMAILKEY';
  static String userPhotoURLKey = 'USERPHOTOURLKEY';
  static String userPhoneNumberKey = 'USERPHONENUMBERKEY';
  static String userAddressKey = 'USERADDRESSKEY';
  static String signInEmailInputKey = 'SIGNINEMAILINPUTKEY';
  static String signInPasswordInputKey = 'SIGNINPASSWORDINPUTKEY';

// set
  Future<bool> saveUserId(String getUserId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(userIdKey, getUserId);
  }

  Future<bool> saveUserName(String getUserName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(userNameKey, getUserName);
  }

  Future<bool> saveUserDisplayName(String getUserDisplayName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(userDisplayNameKey, getUserDisplayName);
  }

  Future<bool> saveUserEmail(String getUserEmail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(userEmailKey, getUserEmail);
  }

  Future<bool> saveUserPhotoURL(String getUserPhotoURL) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(userPhotoURLKey, getUserPhotoURL);
  }

  Future<bool> saveUserPhoneNumber(String getUserPhoneNumber) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(userPhoneNumberKey, getUserPhoneNumber);
  }

  Future<bool> saveUserAddress(String getUserAddress) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(userAddressKey, getUserAddress);
  }

  Future<bool> saveSignInEmailInput(String getsignInEmailInput) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(signInEmailInputKey, getsignInEmailInput);
  }

  Future<bool> saveSignInPasswordInput(String getsignInPasswordInput) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(
        signInPasswordInputKey, getsignInPasswordInput);
  }

  // get
  Future<String> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userIdKey);
  }

  Future<String> getUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userNameKey);
  }

  Future<String> getUserDisplayName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userDisplayNameKey);
  }

  Future<String> getUserEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userEmailKey);
  }

  Future<String> getUserPhotoURL() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userPhotoURLKey);
  }

  Future<String> getUserPhoneNumber() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userPhoneNumberKey);
  }

  Future<String> getUserAddress() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userAddressKey);
  }

  Future<String> getSignInEmailInput() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(signInEmailInputKey);
  }

  Future<String> getSignInPasswordInput() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(signInPasswordInputKey);
  }
}
