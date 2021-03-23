import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static String userIdKey = 'USERIDKEY';
  static String userNameKey = 'USERNAMEKEY';
  static String userDisplayNameKey = 'USERDISPLAYNAMEKEY';
  static String userEmailKey = 'USEREMAILKEY';
  static String userPhotoURL = 'USERPHOTOURL';
  static String userPhoneNumber = 'USERPHONENUMBER';
  static String userAddress = 'USERADDRESS';

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
    return preferences.setString(userPhotoURL, getUserPhotoURL);
  }

  Future<bool> saveUserPhoneNumber(String getUserPhoneNumber) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(userPhoneNumber, getUserPhoneNumber);
  }

  Future<bool> saveUserAddress(String getUserAddress) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(userAddress, getUserAddress);
  }

  // get
  Future<String> getUserId(String getUserId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userIdKey);
  }

  Future<String> getUserName(String getUserName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userNameKey);
  }

  Future<String> getUserDisplayName(String getUserDisplayName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userDisplayNameKey);
  }

  Future<String> getUserEmail(String getUserEmail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userEmailKey);
  }

  Future<String> getUserPhotoURL(String getUserPhotoURL) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userPhotoURL);
  }

  Future<String> getUserPhoneNumber(String getUserPhoneNumber) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userPhoneNumber);
  }

  Future<String> getUserAddress(String getUserAddress) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userAddress);
  }
}
