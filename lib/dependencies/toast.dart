//import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/foundation.dart';

void showToast({required String msg}) {
  //Fluttertoast.showToast(msg: msg, gravity: ToastGravity.BOTTOM);
  if (kDebugMode) {
    print("Hi");
  }
}
