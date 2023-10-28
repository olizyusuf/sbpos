import 'package:flutter/material.dart';

Size displaySize(BuildContext context) {
  //debugPrint('Size = ${MediaQuery.of(context).size}');
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  //debugPrint('height = ${displaySize(context).height}');
  return displaySize(context).height;
}

double displayWidth(BuildContext context) {
  //debugPrint('width = ${displaySize(context).width}');
  return displaySize(context).width;
}

void customSnackbar(
    BuildContext context, String title, Color color, Duration duration) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(title),
      backgroundColor: color,
      duration: duration,
    ),
  );
}
