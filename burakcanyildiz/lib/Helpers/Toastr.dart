import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toastr {
  Future<void> show(String text, bool state) {
    if (state) {
      Fluttertoast.showToast(
          msg: text,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: text,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}

class FontSize {
  double XXSmall(context) {
    return MediaQuery.of(context).size.width / 32;
  }

  double XSmall(context) {
    return MediaQuery.of(context).size.width / 28;
  }

  double Small(context) {
    return MediaQuery.of(context).size.width / 20;
  }

  double Medium(context) {
    return MediaQuery.of(context).size.width / 16;
  }

  double Large(context) {
    return MediaQuery.of(context).size.width / 11;
  }

  double XLarge(context) {
    return MediaQuery.of(context).size.width / 9;
  }
}
