import 'package:dcrypt/symmetric/vigenere.dart';
import 'package:test/test.dart';

void main() {
  group("Vigenere Cipher test", () {
    group("Vigenere Cipher Encryption Test", () {
      Vigenere vigenere = Vigenere.getInstance();

      test("Vigenere Cipher Encryption when key is empty", () {
        expect(() {
          vigenere.encrypt("The boy has the ball", "");
        }, throwsA(isA<AssertionError>()));
      });

      test("Vigenere Cipher Encryption when key and plaintext is correct", () {
        String ct = vigenere.encrypt("Theboyhastheball", "vig");

        expect(ct, "OPKWWECIYOPKWIRG");
      });
    });

    group("Vigenere Cipher Decryption Test", () {
      Vigenere vigenere = Vigenere.getInstance();

      test("Vigenere Cipher Decryption when key is empty", () {
        expect(() {
          vigenere.decrypt("The boy has the ball", "");
        }, throwsA(isA<AssertionError>()));
      });

      test("Vigenere Cipher Decryption when key and plaintext is correct", () {
        String ct = vigenere.decrypt("OPKWWECIYOPKWIRG", "vig");

        expect(ct, "Theboyhastheball".toUpperCase());
      });
    });
  });
}
