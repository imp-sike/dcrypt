/// [PlayFair] cipher is based on 5*5 grid of letter constructed using keywords
/// only works with uppercase, so all the input and the keywords are converted
/// into uppercase before encryption and decryption
abstract class PlayFair {
  /// [encrypt] gives out the cipher text  i.e. encrypted form
  String encrypt(String plainText, String keyword);

  /// [decrpyt] gives out the plaintext i.e.  decrypted form
  String decrypt(String cipherText, String keyword);

  static PlayFair getInstance() {
    return PlayFairImpl();
  }
}

class PlayFairImpl implements PlayFair {
  List<String> gridCache = [];

  List<String> construct5by5Grid(String keyword) {
    assert(keyword == keyword.toUpperCase(),
        "Keyword must be uppercased before passing to this method");
    List<String> grid = [];
    String constructedGridString = "";
    List<bool> alreadyUsedHmap = List.filled(26, false);

    // i and j are treated as same letter, so deal with it
    keyword = keyword.replaceAll("J", "I");
    keyword = keyword.replaceAll(" ", "");

    for (int i = 0; i < keyword.length; ++i) {
      if (!alreadyUsedHmap[(keyword[i]).codeUnitAt(0) - 65]) {
        constructedGridString += keyword[i];
        alreadyUsedHmap[(keyword[i]).codeUnitAt(0) - 65] = true;
      }
    }

    for (int i = 0; i < 26; ++i) {
      if (i != 9) {
        // escape the j because j = i
        if (!alreadyUsedHmap[i]) {
          constructedGridString += String.fromCharCode(i + 65);
          alreadyUsedHmap[i] = true;
        }
      }
    }

    for (int i = 0; i < constructedGridString.length; i += 5) {
      grid.add(constructedGridString.substring(i, i + 5));
    }

    return grid;
  }

  @override
  String decrypt(String cipherText, String keyword) {
    List<String> grid5by5 = construct5by5Grid(keyword);
    String pt = "";
    cipherText = cipherText.toUpperCase();

    // we take 2 character from the plain text initially
    for (int i = 0; i < cipherText.length; i += 2) {
      String firstChar = cipherText[i];
      String secondChar;
      try {
        secondChar = cipherText[i + 1];
      } on RangeError catch (_) {
        secondChar = "X";
      }

      pt += mapTwoChars(firstChar, secondChar, grid5by5, decrypt: true);
    }

    return pt;
  }

  @override
  String encrypt(String plainText, String keyword) {
    List<String> grid5by5 = construct5by5Grid(keyword);
    String ct = "";
    plainText = plainText.toUpperCase();

    // we take 2 character from the plain text initially
    for (int i = 0; i < plainText.length; i += 2) {
      String firstChar = plainText[i];
      String secondChar;
      try {
        secondChar = plainText[i + 1];
      } on RangeError catch (_) {
        secondChar = "X";
      }

      ct += mapTwoChars(firstChar, secondChar, grid5by5);
    }

    return ct;
  }

  String mapTwoChars(String first, String second, List<String> grid,
      {bool decrypt = false}) {
    assert(first != "J" || second != "M",
        "J must be resolved in earlier steps. This method does not support J");
    int ops = decrypt ? -1 : 1;
    String mapped = "";
    int firstElementGrid = 0;
    int firstElementIndex = 0;
    int secondElementGrid = 0;
    int secondElementIndex = 0;

    for (int i = 0; i < 5; ++i) {
      if (grid[i].contains(first) && grid[i].contains(second)) {
        // 2 on a same row
        int indexFirst = (grid[i].indexOf(first) + ops) % 5;
        int indexSecond = (grid[i].indexOf(second) + ops) % 5;

        mapped += grid[i][indexFirst] + grid[i][indexSecond];
        return mapped;
      } else {
        if (grid[i].contains(first)) {
          firstElementGrid = i;
          firstElementIndex = grid[i].indexOf(first);
        }
        if (grid[i].contains(second)) {
          secondElementGrid = i;
          secondElementIndex = grid[i].indexOf(second);
        }
      }
    }

    // we have both row and column of both the letter as of now
    if (firstElementIndex == secondElementIndex) {
      mapped += grid[(firstElementGrid + ops) % 5][firstElementIndex];
      mapped += grid[(secondElementGrid + ops) % 5][secondElementIndex];
    } else {
      // we have different row and column
      mapped += grid[firstElementGrid][secondElementIndex];
      mapped += grid[secondElementGrid][firstElementIndex];
    }

    return mapped;
  }
}
