import 'package:dcrypt/symmetric/playfair.dart';
import 'package:test/test.dart';

void main() {
  group("Playfair test", () {
    group("Plyfair grid test", () {
      PlayFair playFair = PlayFair.getInstance();
      test('Playfair grid under normal conditions', () async {
        List<String> grid =
            (playFair as PlayFairImpl).construct5by5Grid("HELLO");
        expect(grid.length, 5);
        expect(grid, ["HELOA", "BCDFG", "IKMNP", "QRSTU", "VWXYZ"]);
      });

      test('Playfair grid when keyword is empty', () async {
        List<String> grid = (playFair as PlayFairImpl).construct5by5Grid("");
        expect(grid.length, 5);
        expect(grid, ["ABCDE", "FGHIK", "LMNOP", "QRSTU", "VWXYZ"]);
      });

      test('Playfair grid when keywoord does not contain i and j', () async {
        List<String> grid =
            (playFair as PlayFairImpl).construct5by5Grid("ABCDI");
        expect(grid.length, 5);
        expect(grid, ["ABCDI", "EFGHK", "LMNOP", "QRSTU", "VWXYZ"]);
      });

      test('Playfair grid when keyword contains j', () async {
        List<String> grid =
            (playFair as PlayFairImpl).construct5by5Grid("ABCJJ");
        expect(grid.length, 5);
        expect(grid, ["ABCID", "EFGHK", "LMNOP", "QRSTU", "VWXYZ"]);
      });

      test('Playfair grid when keyword contains i', () async {
        List<String> grid =
            (playFair as PlayFairImpl).construct5by5Grid("ABCIJ");
        expect(grid.length, 5);
        expect(grid, ["ABCID", "EFGHK", "LMNOP", "QRSTU", "VWXYZ"]);
      });

      test('Playfair grid when keyword contains blank letters', () async {
        List<String> grid =
            (playFair as PlayFairImpl).construct5by5Grid("ABC IJ");
        expect(grid.length, 5);
        expect(grid, ["ABCID", "EFGHK", "LMNOP", "QRSTU", "VWXYZ"]);
      });

      test(
          'Playfair grid when keyword is smallcase must throw an assert exception',
          () async {
        expect(() {
          (playFair as PlayFairImpl).construct5by5Grid("lowercase");
        }, throwsA(isA<AssertionError>()));
      });

      test('Playfair grid when keyword is uppercase must return normally',
          () async {
        expect(() {
          (playFair as PlayFairImpl).construct5by5Grid("UPPERCASE");
        }, returnsNormally);
      });
    });

    group("Playfair mapper test for encryption", () {
      PlayFair playFair = PlayFair.getInstance();

      List<String> grid5by5 =
          (playFair as PlayFairImpl).construct5by5Grid("SARAH");

      test("Playfair mapper when same row for first row", () {
        String mc = playFair.mapTwoChars("S", "H", grid5by5);
        expect(mc, "AB");
      });

      test("Playfair mapper when same row for second row", () {
        String mc = playFair.mapTwoChars("D", "E", grid5by5);
        expect(mc, "EF");
      });

      test("Playfair mapper when same row for third row", () {
        String mc = playFair.mapTwoChars("K", "M", grid5by5);
        expect(mc, "LN");
      });

      test("Playfair mapper when same row for fourth row", () {
        String mc = playFair.mapTwoChars("O", "Q", grid5by5);
        expect(mc, "PT");
      });

      test("Playfair mapper when same row for fifth row", () {
        String mc = playFair.mapTwoChars("V", "Z", grid5by5);
        expect(mc, "WV");
      });

      test("Playfair mapper when same row for third rowin case of j", () {
        expect(() {
          playFair.mapTwoChars("J", "M", grid5by5);
        }, throwsA(isA<AssertionError>()));
      });

      test("Playfair mapper when same column for first row", () {
        String mc = playFair.mapTwoChars("S", "O", grid5by5);
        expect(mc, "CV");
      });

      test("Playfair mapper when same column for second row", () {
        String mc = playFair.mapTwoChars("D", "W", grid5by5);
        expect(mc, "KA");
      });

      test("Playfair mapper when same column for third row", () {
        String mc = playFair.mapTwoChars("R", "Q", grid5by5);
        expect(mc, "EX");
      });

      test("Playfair mapper when same column for fourth row", () {
        String mc = playFair.mapTwoChars("F", "M", grid5by5);
        expect(mc, "MT");
      });

      test("Playfair mapper when same column for fifth row", () {
        String mc = playFair.mapTwoChars("U", "Z", grid5by5);
        expect(mc, "ZB");
      });

      test("Playfair mapper when different row and column", () {
        String mc = playFair.mapTwoChars("S", "Q", grid5by5);
        expect(mc, "RO");
      });

      test("Playfair mapper when different row and column 2", () {
        String mc = playFair.mapTwoChars("E", "M", grid5by5);
        expect(mc, "FL");
      });
    });

    group("Playfair encrypton test", () {
      PlayFair playFair = PlayFair.getInstance();

      test("Playfair encryption under normal", () {
        String encrypt = playFair.encrypt("mathematics", "SARAH");
        expect(encrypt, "KHYFFLHPOIRV");
      });

      test("Playfair encryption under normal 2", () {
        String encrypt = playFair.encrypt("mathematic", "SARAH");
        expect(encrypt, "KHYFFLHPOI");
      });
    });

    group("Playfair mapper test for decyption", () {
      PlayFair playFair = PlayFair.getInstance();

      List<String> grid5by5 =
          (playFair as PlayFairImpl).construct5by5Grid("SARAH");

      test("Playfair mapper when same row for first row", () {
        String mc = playFair.mapTwoChars("S", "H", grid5by5, decrypt: true);
        expect(mc, "BR");
      });

      test("Playfair mapper when same row for second row", () {
        String mc = playFair.mapTwoChars("D", "E", grid5by5, decrypt: true);
        expect(mc, "CD");
      });

      test("Playfair mapper when same row for third row", () {
        String mc = playFair.mapTwoChars("K", "M", grid5by5, decrypt: true);
        expect(mc, "IL");
      });

      test("Playfair mapper when same row for fourth row", () {
        String mc = playFair.mapTwoChars("O", "Q", grid5by5, decrypt: true);
        expect(mc, "UP");
      });

      test("Playfair mapper when same row for fifth row", () {
        String mc = playFair.mapTwoChars("V", "Z", grid5by5, decrypt: true);
        expect(mc, "ZY");
      });

      test("Playfair mapper when same row for third row in case of j", () {
        expect(() {
          playFair.mapTwoChars("J", "M", grid5by5, decrypt: true);
        }, throwsA(isA<AssertionError>()));
      });

      test("Playfair mapper when same column for first row", () {
        String mc = playFair.mapTwoChars("S", "O", grid5by5, decrypt: true);
        expect(mc, "VI");
      });

      test("Playfair mapper when same column for second row", () {
        String mc = playFair.mapTwoChars("D", "W", grid5by5, decrypt: true);
        expect(mc, "AP");
      });

      test("Playfair mapper when same column for third row", () {
        String mc = playFair.mapTwoChars("R", "Q", grid5by5, decrypt: true);
        expect(mc, "XL");
      });

      test("Playfair mapper when same column for fourth row", () {
        String mc = playFair.mapTwoChars("F", "M", grid5by5, decrypt: true);
        expect(mc, "HF");
      });

      test("Playfair mapper when same column for fifth row", () {
        String mc = playFair.mapTwoChars("U", "Z", grid5by5, decrypt: true);
        expect(mc, "NU");
      });

      test("Playfair mapper when different row and column", () {
        String mc = playFair.mapTwoChars("S", "Q", grid5by5);
        expect(mc, "RO");
      });

      test("Playfair mapper when different row and column 2", () {
        String mc = playFair.mapTwoChars("E", "M", grid5by5, decrypt: true);
        expect(mc, "FL");
      });
    });

    group("Playfair decryption test", () {
      PlayFair playFair = PlayFair.getInstance();

      test("Playfair decryption under normal", () {
        String encrypt = playFair.decrypt("KHYFFLHPOIRVA", "SARAH");
        expect(encrypt, "MATHEMATICSXRW");
      });

      test("Playfair decryption under normal 2", () {
        String encrypt = playFair.decrypt("KHYFFLHPOI", "SARAH");
        expect(encrypt, "MATHEMATIC");
      });
    });
  });
}
