import 'package:complex/complex.dart';
import 'dart:convert';

enum TokenType {
  numeric,
  iota,
  plus,
  minus,
}

class Token {
  late TokenType type;
  late dynamic value;

  Token(this.type, this.value);

  @override
  toString() {
    if (type == TokenType.numeric) {
      return value.toString();
    } else if (type == TokenType.plus) {
      return '+';
    } else if (type == TokenType.minus) {
      return '-';
    } else {
      return 'i';
    }
  }
}

Complex parseComplex(String str) {
  // A complex number can be provided in the following two forms
  // 1. x + iy
  // 2. iy + x
  // where x and y can be doubles and hence are always treated as such.
  // The position of i can also placed to be a prefix or suffix of the cofficient its associated with.

  str = str.trim();
  if (str.isEmpty) {
    throw "cannot conver empty string to Complex type";
  }

  var ptr = 0;
  var tokenList = [];
  Token token;
  while (ptr < str.length) {
    (token, ptr) = scanToken(str, ptr);
    tokenList.add(token);
  }

  if (tokenList.length > 4) {
    throw "error parsing complex '$str'";
  }
  print(tokenList);

  double? real, imag;
  bool parsNegNum = false;

  ptr = 0;
  while (ptr < tokenList.length) {
    if (tokenList[ptr].type == TokenType.numeric) {
      if (ptr == tokenList.length - 1 ||
          tokenList[ptr + 1].type == TokenType.plus ||
          tokenList[ptr + 1].type == TokenType.minus && real == null) {
        real = parsNegNum ? -1 * tokenList[ptr].value : tokenList[ptr].value;
        ptr += 1;
        parsNegNum = false;
      } else if (tokenList[ptr + 1].type == TokenType.iota && imag == null) {
        imag = parsNegNum ? -1 * tokenList[ptr].value : tokenList[ptr].value;
        ptr += 2;
        parsNegNum = false;
      } else {
        throw "invalid complex input string found '$str'";
      }
    } else if (tokenList[ptr].type == TokenType.minus) {
      parsNegNum = true;
      ptr++;
    } else if (tokenList[ptr].type == TokenType.plus) {
      ptr++;
    } else if (tokenList[ptr].type == TokenType.iota &&
        tokenList[ptr + 1].type == TokenType.numeric && imag == null) {
      imag =
          parsNegNum ? -1 * tokenList[ptr + 1].value : tokenList[ptr + 1].value;
      ptr += 2;
      parsNegNum = false;
    } else {
      throw "invalid complex input string found '$str'";
    }
  }

  return Complex(real ?? 0, imag ?? 0);
}

(Token, int) scanToken(String str, int ptr) {
  while (str[ptr] == ' ') {
    ptr++;
  }

  dynamic value;
  if (_isDigit(str[ptr])) {
    (value, ptr) = parseDouble(str, ptr);
    return (Token(TokenType.numeric, value), ptr);
  } else if (str[ptr] == '+') {
    return (Token(TokenType.plus, null), ptr + 1);
  } else if (str[ptr] == '-') {
    return (Token(TokenType.minus, null), ptr + 1);
  } else if (str[ptr] == 'i') {
    return (Token(TokenType.iota, null), ptr + 1);
  } else {
    throw "found invalid token '${str[ptr]}' in $str";
  }
}

bool _isDigit(String char) {
  var aval = ascii.encode(char)[0];
  var avalZero = ascii.encode("0")[0];
  return aval - avalZero >= 0 && aval - avalZero < 10;
}

(double, int) parseDouble(String str, int ptr) {
  String resStr = "";
  while (ptr < str.length && (_isDigit(str[ptr]) || str[ptr] == '.')) {
    resStr += str[ptr];
    ptr++;
  }
  double res = double.parse(resStr);

  return (res, ptr);
}
