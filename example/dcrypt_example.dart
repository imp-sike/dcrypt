import 'package:dcrypt/dcrypt.dart';

void main() {
  Caesar caesar = Caesar.getInstance();
  print(caesar.encrypt("Hello World", 4));
}
