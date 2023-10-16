# dcrypt
A Cryptography library for dart.

### Supports
1. Caeser Cipher
```dart
import 'package:dcrypt/dcrypt.dart';

Caesar caesar = Caesar.getInstance();

print(caesar.encrypt("Hello World", 4));

print(caesar.decrypt(".", 4));
```