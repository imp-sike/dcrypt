/// [Hill] is a cipher algorithm that does encryption and decryption
/// using Matrix Multiplication. Lets see how i do it.
abstract class Hill {
  String encrypt(String plaintext, List<List<int>> key);
  String decrypt(String ciphertext, List<List<int>> key);

  static Hill getInstance() {
    return HillImpl();
  }
}

class HillImpl implements Hill {
  List<List<int>> findInverse(List<List<int>> matrix) {
    int determinant =
        (matrix[0][0] * matrix[1][1] - matrix[0][1] * matrix[1][0]);

    assert(determinant != 0, "Matrix is not invertible");

    double inverseDeterminant = 1.0 / determinant;

    List<List<int>> inverse = [
      [
        (matrix[1][1] * inverseDeterminant).toInt(),
        (-matrix[0][1] * inverseDeterminant).toInt()
      ],
      [
        (-matrix[1][0] * inverseDeterminant.toInt()).toInt(),
        (matrix[0][0] * inverseDeterminant).toInt()
      ],
    ];

    return inverse;
  }

  @override
  String decrypt(String ciphertext, List<List<int>> key) {
    assert(key[0].length == 2 && key.length == 2,
        "The matrix must be a 2 * 2 matrix");
    String pt = "";

    key = findInverse(key);
    if (ciphertext.length.isOdd) {
      ciphertext += "Z";
    }
    ciphertext = ciphertext.toUpperCase();

    //
    for (int l = 0; l < ciphertext.length; l += 2) {
      String firstLetter = ciphertext[l];
      String secondLetter = ciphertext[l + 1];

      List plainTextMatrix = [
        [firstLetter.codeUnitAt(0) - 65, secondLetter.codeUnitAt(0) - 65]
      ];

      // Create the result matrix with the same dimensions as the product
      List<List<double>> result = List.generate(plainTextMatrix.length,
          (i) => List.generate(key[0].length, (j) => 0.0));

      // Check if the matrices can be multiplied
      assert(plainTextMatrix[0].length == key.length,
          "Matrix multiplication is not possible.");

      // matrix multiplication
      for (int i = 0; i < plainTextMatrix.length; i++) {
        for (int j = 0; j < key[0].length; j++) {
          for (int k = 0; k < key.length; k++) {
            result[i][j] += plainTextMatrix[i][k] * key[k][j];
          }
        }
      }

      // Print the result matrix
      for (int o = 0; o < result.length; o++) {
        for (int p = 0; p < result[0].length; p++) {
          pt += String.fromCharCode((result[o][p].toInt() % 26) + 65);
        }
      }
    }

    return pt;
  }

  @override
  String encrypt(String plaintext, List<List<int>> key) {
    assert(key[0].length == 2 && key.length == 2,
        "The matrix must be a 2 * 2 matrix");
    String ct = "";
    if (plaintext.length.isOdd) {
      plaintext += "Z";
    }
    plaintext = plaintext.toUpperCase();

    //
    for (int l = 0; l < plaintext.length; l += 2) {
      String firstLetter = plaintext[l];
      String secondLetter = plaintext[l + 1];

      List plainTextMatrix = [
        [firstLetter.codeUnitAt(0) - 65, secondLetter.codeUnitAt(0) - 65]
      ];

      // Create the result matrix with the same dimensions as the product
      List<List<double>> result = List.generate(plainTextMatrix.length,
          (i) => List.generate(key[0].length, (j) => 0.0));

      // Check if the matrices can be multiplied
      assert(plainTextMatrix[0].length == key.length,
          "Matrix multiplication is not possible.");

      // matrix multiplication
      for (int i = 0; i < plainTextMatrix.length; i++) {
        for (int j = 0; j < key[0].length; j++) {
          for (int k = 0; k < key.length; k++) {
            result[i][j] += plainTextMatrix[i][k] * key[k][j];
          }
        }
      }

      // Print the result matrix
      for (int o = 0; o < result.length; o++) {
        for (int p = 0; p < result[0].length; p++) {
          ct += String.fromCharCode((result[o][p].toInt() % 26) + 65);
        }
      }
    }

    return ct;
  }
}
