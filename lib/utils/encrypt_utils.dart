import 'dart:convert';
import 'dart:typed_data';

class EncryptUtils {
  static const String _key = ']/4[([8WS8LNufO';

  static String xorEncryptDecrypt(String input) {
    final inputBytes = utf8.encode(input);
    final keyBytes = utf8.encode(_key);

    final outputBytes = Uint8List(inputBytes.length);

    for (int i = 0; i < inputBytes.length; i++) {
      outputBytes[i] = inputBytes[i] ^ keyBytes[i % keyBytes.length];
    }

    return base64Encode(outputBytes);
  }

  static String decryptXor(String encryptedText) {
    final encryptedBytes = base64Decode(encryptedText);
    final keyBytes = utf8.encode(_key);

    final outputBytes = Uint8List(encryptedBytes.length);

    for (int i = 0; i < encryptedBytes.length; i++) {
      outputBytes[i] = encryptedBytes[i] ^ keyBytes[i % keyBytes.length];
    }

    return utf8.decode(outputBytes);
  }
}
