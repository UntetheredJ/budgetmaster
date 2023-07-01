import 'dart:math';

String randomDigits(int length) {
  final random = Random();
  String result = '';
  for (int i = 0; i < length; i++) {
    int digit = random.nextInt(10);
    result += digit.toString();
  }
  return result;
}