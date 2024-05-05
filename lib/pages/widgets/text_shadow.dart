import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

textshadow(
    {required String text,
    required double fontsize,
    required Color color,
    required FontWeight fontWeight}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: fontsize,
      color: color,
      fontWeight: fontWeight,
      shadows: const [
        Shadow(
          offset: Offset(2, 2),
          blurRadius: 10.0,
          color: Colors.black38,
        ),
      ],
    ),
  );
}
