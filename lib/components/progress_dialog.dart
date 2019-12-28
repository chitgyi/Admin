import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

ProgressDialog dialog(BuildContext context) {
  ProgressDialog pr = ProgressDialog(context, type: ProgressDialogType.Normal);
  pr.style(message: "Loading...");
  pr.style(
    message: 'Please wait...',
    borderRadius: 10.0,
    backgroundColor: Colors.white,
    progressWidget: CircularProgressIndicator(),
    elevation: 10.0,
    insetAnimCurve: Curves.easeInOut,
    progressTextStyle: TextStyle(
        color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
    messageTextStyle: TextStyle(
        color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
  );
  return pr;
}
