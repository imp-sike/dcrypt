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

3. Hill Cipher

```dart
import 'package:dcrypt/dcrypt.dart';

Hill hill = Hill.getInstance();
List<List<int>> key = [
    [3, 6],
    [1, 4]
];
print(hill.encrypt("Hello", key));
```

4. Vignere Cipher

```dart
import 'package:dcrypt/dcrypt.dart';

Vigenere vigenere = Vigenere.getInstance();
print(vigenere.encrypt("Hello World", "vig"));
print(vigenere.decrypt("ajkol", "vig"));
```
