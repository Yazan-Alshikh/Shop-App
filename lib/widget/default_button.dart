import 'dart:ui';

import 'package:flutter/material.dart';

Widget DefaultButton({
  @required Function onpressed,
  @required String label,
  double width,
}) =>
    Container(
      child: ElevatedButton(
          onPressed: onpressed, child: Text(label.toUpperCase())),
      width: width,
      height: 40,
    );
