import 'package:dcrypt/symmetric/hill.dart';
import 'package:test/test.dart';

void main() {
  group("Hill Cipher tests", () {
    group("Hill Cipher encryption test", () {
      Hill hill = Hill.getInstance();
      List<List<int>> key = [
        [3, 6],
        [1, 5]
      ];

      test("Hill cipher encryption when normal", () {
        String ct = hill.encrypt("mo", key);
        expect(ct, "YM");
      });

      test("Hill cipher encryption when normal 2", () {
        String ct = hill.encrypt("om", key);
        expect(ct, "CO");
      });

      test("Hill cipher encryption when length is 4", () {
        String ct = hill.encrypt("moom", key);
        expect(ct, "YMCO");
      });

      test("Hill cipher encryption when length is 3", () {
        String ct = hill.encrypt("moo", key);
        expect(ct, "YMPB");
      });

      test("Hill cipher encryption with odd length, padding added", () {
        String ct = hill.encrypt("moa", key);
        expect(ct, "YMZV");
      });

      test("Hill cipher encryption with empty plaintext", () {
        String ct = hill.encrypt("", key);
        expect(ct, "");
      });

      test("Hill cipher encryption with key matrix size not 2x2", () {
        List<List<int>> invalidKey = [
          [1, 2, 3],
          [4, 5, 6]
        ];
        expect(() => hill.encrypt("mo", invalidKey),
            throwsA(isA<AssertionError>()));
      });
    });

    group("Hill Cipher decryption test", () {
      Hill hill = Hill.getInstance();
      List<List<int>> key = [
        [3, 6],
        [1, 4]
      ];

      test("Hill cipher decryption when normal", () {
        String pt = hill.decrypt("YM", key);
        expect(pt, "AC");
      });

      test("Hill cipher decryption when normal 2", () {
        String pt = hill.decrypt("CO", key);
        expect(pt, "AY");
      });

      test("Hill cipher decryption when length is 4", () {
        String pt = hill.decrypt("YMCO", key);
        expect(pt, "ACAY");
      });

      test("Hill cipher decryption when length is 3", () {
        String pt = hill.decrypt("YMPB", key);
        expect(pt, "ACAL");
      });

      test("Hill cipher decryption with odd length, padding added", () {
        String pt = hill.decrypt("YMCB", key);
        expect(pt, "ACAY");
      });

      test("Hill cipher decryption with empty ciphertext", () {
        String pt = hill.decrypt("", key);
        expect(pt, "");
      });

      test("Hill cipher decryption with key matrix size not 2x2", () {
        List<List<int>> invalidKey = [
          [1, 2, 3],
          [4, 5, 6]
        ];
        expect(() => hill.decrypt("YM", invalidKey),
            throwsA(isA<AssertionError>()));
      });

      test("Hill cipher decryption with non-invertible key matrix", () {
        List<List<int>> nonInvertibleKey = [
          [1, 2],
          [2, 4]
        ];
        expect(() => hill.decrypt("YM", nonInvertibleKey),
            throwsA(isA<AssertionError>()));
      });

      test("Hill cipher decryption when ciphertext length is odd", () {
        String pt = hill.decrypt("YMA", key);
        expect(pt, "ACAA");
      });
    });
  });
}
