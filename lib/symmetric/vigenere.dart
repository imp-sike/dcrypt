/// [Vigenere] is a newer form of Caeser Cipher
/// It has key = SOMETHING and plaintext = HEHE
/// The key is appended with itself for the size of plain text
abstract class Vigenere {
  String encrypt(String plaintext, String key);
  String decrypt(String plaintext, String key);

  static Vigenere getInstance() {
    return VigenereImpl();
  }
}

class VigenereImpl implements Vigenere {
  @override
  String decrypt(String ciphertext, String key) {
    assert(key.isNotEmpty, "Key must be valid");
    String pt = "";

    for (int i = 0; i < ciphertext.length; i++) {
      pt += String.fromCharCode(
        ((ciphertext[i].toUpperCase().codeUnitAt(0) -
                        65 -
                        key[i % key.length].toUpperCase().codeUnitAt(0) -
                        65) %
                    26)
                .toInt() +
            65,
      );
    }

    return pt;
  }

  @override
  String encrypt(String plaintext, String key) {
    assert(key.isNotEmpty, "Key must be valid");
    String ct = "";

    for (int i = 0; i < plaintext.length; i++) {
      ct += String.fromCharCode(
        ((plaintext[i].toUpperCase().codeUnitAt(0) -
                        65 +
                        key[i % key.length].toUpperCase().codeUnitAt(0) -
                        65) %
                    26)
                .toInt() +
            65,
      );
    }

    return ct;
  }
}
