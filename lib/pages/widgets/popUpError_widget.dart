import 'package:flutter/material.dart';

Future<dynamic> errorPopUpWidget(
    String error, BuildContext context, void Function()? onpressed) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(
          error.toString(),
          style: const TextStyle(fontSize: 18),
        ),
        actions: [
          TextButton(
              onPressed: onpressed,
              child: const Text(
                "Ok",
                style: TextStyle(fontSize: 18),
              ))
        ],
      );
    },
  );
}
