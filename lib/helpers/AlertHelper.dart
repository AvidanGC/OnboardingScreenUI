import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AlertsHelper {

  //region Properties
  static var loader;
  //endregion

  static showSnackBar(context, title) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(title),
    ));
  }

  static showToast(title, {time: 5}) {
    Fluttertoast.showToast(
        msg: title,
        timeInSecForIosWeb: time,
        gravity: ToastGravity.TOP,
    );
  }

}