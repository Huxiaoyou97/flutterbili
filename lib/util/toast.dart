import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showWarnToast(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    backgroundColor: const Color(0xFFFBE8C9),
    textColor: const Color(0xfff0a020),
  );
}

void showErrorToast(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    backgroundColor: const Color(0xFFF3CDD5),
    textColor: const Color(0xffd03050),
  );
}

void showSuccessToast(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    backgroundColor: const Color(0xFFC7E8D6),
    textColor: const Color(0xff18a058),
  );
}

void showToast(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    backgroundColor: const Color(0xFFE3E4E5),
    textColor: const Color(0xff767C82),
  );
}
