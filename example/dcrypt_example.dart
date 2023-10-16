import 'package:dcrypt/dcrypt.dart';

void main() {
  Caesar caesar = Caesar.getInstance();
  print(caesar.encrypt("Hello World", 4));

  PlayFair playFair = PlayFair.getInstance();
  print(playFair.encrypt("Hello World", "IMPSIKE"));

  Hill hill = Hill.getInstance();
  List<List<int>> key = [
    [3, 6],
    [1, 4]
  ];
  print(hill.encrypt("Hello", key));
}
