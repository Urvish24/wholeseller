
import 'package:bwc/models/LoginModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StorageUtil {
  static StorageUtil _storageUtil;
  static SharedPreferences _preferences;

  static Future getInstance() async {
    if (_storageUtil == null) {
      // keep local instance till it is fully initialized.
      var secureStorage = StorageUtil._();
      await secureStorage._init();
      _storageUtil = secureStorage;
    }
    return _storageUtil;
  }
  StorageUtil._();
  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }


  // get string
  static String getString(String key, {String defValue = ''}) {
    if (_preferences == null) return defValue;
    return _preferences.getString(key) ?? defValue;
  }
  // put string
  static Future putString(String key, String value) {
    if (_preferences == null) return null;
    return _preferences.setString(key, value);
  }
  /*static Future putModel(String key, LoginModel value) {
    if (_preferences == null) return null;
    String user = jsonEncode(value.toJson());
    return _preferences.setString(key, user);
  }*/
  /*static Future getModel(String key, {String defValue = ''}) {
    if (_preferences == null) return null;
    return _preferences.getString(key) ?? defValue;
  }*/

  static int getInt(String key, {int defValue = 0}) {
    if (_preferences == null) return defValue;
    return _preferences.getInt(key) ?? defValue;
  }
  // put string
  static Future putInt(String key, int value) {
    if (_preferences == null) return null;
    return _preferences.setInt(key, value);
  }

  static bool getBoolen(String key, {bool defValue = false}) {
    if (_preferences == null) return defValue;
    return _preferences.getBool(key) ?? defValue;
  }
  // put string
  static Future putBool(String key, bool value) {
    if (_preferences == null) return null;
    return _preferences.setBool(key, value);
  }

  static Future clearpreferences() {
    if (_preferences == null) return null;
    return _preferences.clear();
  }
}