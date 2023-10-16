/// [Caesar] cipher is a simple shift monoalphabetic classical cipher where each
///  letter is replaced by a letter [shift] position ahead in UTF order
abstract class Caesar {
  /// [encrypt] gives out the cipher text  i.e. encrypted form
  String encrypt(String plainText, int shift);

  /// [decrpyt] gives out the plaintext i.e.  decrypted form
  String decrypt(String cipherText, int shift);

  static Caesar getInstance({bool takeSpace = false}) {
    return CaesarImpl(takeSpace: takeSpace);
  }
}

class CaesarImpl implements Caesar {
  bool takeSpace;

  CaesarImpl({this.takeSpace = false});

  @override
  String decrypt(String cipherText, int shift) {
    String pt = "";

    for (int i = 0; i < cipherText.length; ++i) {
      if (cipherText[i] == " " && !takeSpace) {
        pt += " ";
      } else {
        int utfCode = cipherText[i].codeUnitAt(0);
        utfCode -= shift;
        pt += String.fromCharCode(utfCode);
      }
    }

    return pt;
  }

  @override
  String encrypt(String plainText, int shift) {
    String ct = "";

    for (int i = 0; i < plainText.length; ++i) {
      if (plainText[i] == " " && !takeSpace) {
        ct += " ";
      } else {
        int utfCode = plainText[i].codeUnitAt(0);
        utfCode += shift;
        ct += String.fromCharCode(utfCode);
      }
    }

    return ct;
  }
}
