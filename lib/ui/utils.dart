import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String numToIdr(dynamic number) {
  NumberFormat currencyFormatter =
      NumberFormat.currency(locale: 'id', symbol: '', decimalDigits: 0);
  String toIdr = currencyFormatter.format(number);
  return toIdr;
}

Size displaySize(BuildContext context) {
  //debugPrint('Size = ${MediaQuery.of(context).size}');
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  //debugPrint('height = ${displaySize(context).height}');
  return displaySize(context).height;
}

double displayHeightBody(BuildContext context) {
  double displayBodyHeight = displaySize(context).height -
      AppBar().preferredSize.height -
      MediaQuery.of(context).padding.top;
  // debugPrint(displayBodyHeight.toString());
  return displayBodyHeight;
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
