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

2. Playfair Cipher

```dart
import 'package:dcrypt/dcrypt.dart';

PlayFair playFair = PlayFair.getInstance();
print(playFair.encrypt("Hello World", "SARAH"));
print(playFair.decrypt("KHYFFLHPOI", "SARAH"));
```
