import 'package:flutter/material.dart';

Future<dynamic> errorPopUpWidget(String error, BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(error.toString()),
      );
    },
  );
}
