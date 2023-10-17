abstract class Railfence {
  String encrypt(String plaintext, int rail);
  String decrypt(String ciphertext, int rail);

  static Railfence getInstance() {
    return RailfenceImpl();
  }
}

class RailfenceImpl implements Railfence {
  @override
  String decrypt(String ciphertext, int rail) {
    assert(rail < ciphertext.length,
        "The rail must be small than the size of the ciphertext");

    String pt = "";
    ciphertext = ciphertext.toUpperCase();

    //
    List<String> partitions = [];
    int sizeOfPartition = (ciphertext.length / rail).ceil();

    for (int i = 0; i < ciphertext.length; i += sizeOfPartition) {
      partitions.add(ciphertext.substring(i, i + sizeOfPartition));
    }

    print(partitions);

    //
    for (int i = 0; i < sizeOfPartition; ++i) {
      for (int j = 0; j < partitions.length; ++j) {
        //
        pt += partitions[j][i];
      }
    }
    return pt;
  }

  @override
  String encrypt(String plaintext, int rail) {
    assert(rail < plaintext.length,
        "The rail must be small than the size of the plaintext");

    String ct = "";
    plaintext = plaintext.toUpperCase();

    //
    for (int j = 0; j < rail; j++) {
      for (int i = j; i < plaintext.length; i += rail) {
        ct += plaintext[i];
      }
    }

    return ct;
  }
}
