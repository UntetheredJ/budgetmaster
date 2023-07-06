import 'dart:math';

import 'package:flutter/cupertino.dart';

String randomDigits(int length) {
  final random = Random();
  String result = '';
  for (int i = 0; i < length; i++) {
    int digit = random.nextInt(10);
    result += digit.toString();
  }
  return result;
}

String convertDate(DateTime fecha) {
  String fechaPostgres = "${fecha.year}/${fecha.month}/${fecha.day}";
  return fechaPostgres;
}