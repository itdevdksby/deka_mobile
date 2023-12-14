import 'dart:math';

String generateRandomId() {
  final random = Random();
  const length = 11;
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final id = StringBuffer();

  for (var i = 0; i < length; i++) {
    id.write(chars[random.nextInt(chars.length)]);
  }

  return id.toString();
}

String generateCode(int lastCode) {
  final random = Random();
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final id = StringBuffer();

  for (var i = 0; i < lastCode; i++) {
    id.write(chars[random.nextInt(chars.length)]);
  }

  return id.toString();
}
