import 'package:dcrypt/symmetric/railfence.dart';
import 'package:test/test.dart';

void main() {
  group('railfence cipher test', () {
    group("railfence cipher test encryption", () {
      Railfence railfence = Railfence.getInstance();
      test("Railfence encryption when input is correct", () {
        String pt = railfence.encrypt("Tesula", 2);
        expect(pt, "TSLEUA");
      });

      test("Railfence encryption when input is correct", () {
        String pt = railfence.encrypt("Tesula", 3);
        expect(pt, "TUELSA");
      });

      test("Railfence encryption when rail is greater than plaintext length",
          () {
        expect(() {
          railfence.encrypt("hello", 8);
        }, throwsA(isA<AssertionError>()));
      });
    });

    group("railfence cipher test decryption", () {
      Railfence railfence = Railfence.getInstance();
      test("Railfence decryption when input is correct", () {
        String pt = railfence.decrypt("TSLEUA", 3);
        expect(pt, "TESULA");
      });

      test("Railfence decryption when rail  is 3", () {
        String pt = railfence.decrypt("TUELSA", 2);
        // TESULA   TU    EL    SA
        // TSL  EUA
        expect(pt, "TESULA");
      });

      test("Railfence decryption when rail is greater than plaintext length",
          () {
        expect(() {
          railfence.decrypt("hello", 8);
        }, throwsA(isA<AssertionError>()));
      });
    });
  });
}
