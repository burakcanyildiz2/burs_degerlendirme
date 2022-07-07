import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Token {
  static const String sharedSecret = ',_:W9Z=nxxM}ph=8';
  static const tokenKey = 'akrein';

  saveValue(String key, String value) async {
    var storage = FlutterSecureStorage();
    await storage.write(key: key, value: value);
  }

  Future<String> ReadValue(String key) async {
    try {
      var storage = FlutterSecureStorage();
      var value = await storage.read(key: key);

      return value;
    } catch (e) {
      return null;
    }
  }

  deleteToken(String key) async {
    var storage = FlutterSecureStorage();
    await storage.delete(key: key);
  }

  getDate() {
    String ay;
    String gun;
    String saat;
    String dk;
    String sn;
    DateTime.now().month <= 9
        ? ay = "0" + DateTime.now().month.toString()
        : ay = DateTime.now().month.toString();
    DateTime.now().day <= 9
        ? gun = "0" + DateTime.now().day.toString()
        : gun = DateTime.now().day.toString();
    DateTime.now().hour <= 9
        ? saat = "0" + DateTime.now().hour.toString()
        : saat = DateTime.now().hour.toString();
    DateTime.now().minute <= 9
        ? dk = "0" + DateTime.now().minute.toString()
        : dk = DateTime.now().minute.toString();
    DateTime.now().second <= 9
        ? sn = "0" + DateTime.now().second.toString()
        : sn = DateTime.now().second.toString();

    return DateTime.now().year.toString() +
        "-" +
        ay +
        "-" +
        gun +
        "T" +
        saat +
        ":" +
        dk +
        ":" +
        sn;
  }

  formatDate(DateTime date) {
    String ay;
    String gun;
    String saat;
    String dk;
    String sn;
    date.month <= 9
        ? ay = "0" + date.month.toString()
        : ay = date.month.toString();
    date.day <= 9 ? gun = "0" + date.day.toString() : gun = date.day.toString();
    date.hour <= 9
        ? saat = "0" + date.hour.toString()
        : saat = date.hour.toString();
    date.minute <= 9
        ? dk = "0" + date.minute.toString()
        : dk = date.minute.toString();
    date.second <= 9
        ? sn = "0" + date.second.toString()
        : sn = date.second.toString();

    return date.year.toString() +
        "-" +
        ay +
        "-" +
        gun +
        "T" +
        saat +
        ":" +
        dk +
        ":" +
        sn;
  }
}
