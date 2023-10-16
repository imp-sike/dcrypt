import 'package:dcrypt/symmetric/caesar.dart';
import 'package:test/test.dart';

void main() {
  group("Caeser cipher encryption test", () {
    Caesar caesar = Caesar.getInstance();
    test('Caeser cipher encrption when everything is fine 1', () async {
      String ct = caesar.encrypt("Hello", 3);
      String ect = "Khoor";
      expect(ct, ect);
    });

    test('Caeser cipher encrption when there is single letter', () async {
      String ct = caesar.encrypt("a", 3);
      String ect = "d";
      expect(ct, ect);
    });

    test('Caeser cipher encrption when there is no letter', () async {
      String ct = caesar.encrypt(" ", 3);
      String ect = " ";
      expect(ct, ect);
    });

    test('Caeser cipher encrption when there is space and takeSpace is false',
        () async {
      // (caesar as CaesarImpl).takeSpace = false;
      String ct = caesar.encrypt("H e", 3);
      String ect = "K h";
      expect(ct, ect);
    });

    test('Caeser cipher encrption when there is space and takeSpace is true',
        () async {
      (caesar as CaesarImpl).takeSpace = true;
      String ct = caesar.encrypt("H e", 3);
      String ect = "K#h";
      expect(ct, ect);
    });
  });

  group("Caeser cipher decryption test", () {
    Caesar caesar = Caesar.getInstance();

    test('Caeser cipher decryption when everything is fine', () async {
      String ct = caesar.decrypt("Khoor", 3);
      String ect = "Hello";
      expect(ct, ect);
    });

    test('Caeser cipher decryption when there is single letter', () async {
      String ct = caesar.decrypt("d", 3);
      String ect = "a";
      expect(ct, ect);
    });

    test('Caeser cipher decryption when there is no letter', () async {
      String ct = caesar.decrypt(" ", 3);
      String ect = " ";
      expect(ct, ect);
    });

    test('Caeser cipher decryption when there is space and takeSpace is false',
        () async {
      // (caesar as CaesarImpl).takeSpace = false;
      String ct = caesar.decrypt("K h", 3);
      String ect = "H e";
      expect(ct, ect);
    });

    test('Caeser cipher decryption when there is space and takeSpace is true',
        () async {
      (caesar as CaesarImpl).takeSpace = true;
      String ct = caesar.decrypt("K#h", 3);
      String ect = "H e";
      expect(ct, ect);
    });
  });
}
