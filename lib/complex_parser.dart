import 'package:equations/equations.dart';
import 'dart:convert';

enum TokenType {
  numeric,
  iota,
  plus,
  minus,
}

enum Sign {
  pos,
  neg,
  unset,
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
  // The position of i can also placed to be a prefix or suffix of the
  // cofficient its associated with.

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

  double? real, imag;
  Sign signNow = Sign.pos;

  ptr = 0;
  while (ptr < tokenList.length) {
    if (tokenList[ptr].type == TokenType.numeric) {
      if (real == null &&
          (ptr == tokenList.length - 1 ||
              (ptr + 1 < tokenList.length &&
                      tokenList[ptr + 1].type == TokenType.plus ||
                  tokenList[ptr + 1].type == TokenType.minus))) {
        if (signNow == Sign.pos) {
          real = tokenList[ptr].value;
        } else if (signNow == Sign.neg) {
          real = -1 * (tokenList[ptr].value as double);
        } else {
          throw "invalid complex input string found '$str'";
        }
        ptr += 1;
        signNow = Sign.unset;
      } else if (imag == null &&
          ptr + 1 < tokenList.length &&
          tokenList[ptr + 1].type == TokenType.iota) {
        if (signNow == Sign.pos) {
          imag = tokenList[ptr].value;
        } else if (signNow == Sign.neg) {
          imag = -1 * (tokenList[ptr].value as double);
        } else {
          throw "invalid complex input string found '$str'";
        }
        ptr += 2;
        signNow = Sign.unset;
      } else {
        throw "invalid complex input string found '$str'";
      }
    } else if (tokenList[ptr].type == TokenType.minus) {
      signNow = Sign.neg;
      ptr++;
    } else if (tokenList[ptr].type == TokenType.plus) {
      signNow = Sign.pos;
      ptr++;
    } else if (tokenList[ptr].type == TokenType.iota && imag == null) {
      if (ptr + 1 < tokenList.length &&
          tokenList[ptr + 1].type == TokenType.numeric) {
        imag = tokenList[ptr + 1].value;
        ptr += 2;
      } else {
        imag = 1;
        ptr += 1;
      }
      if (signNow == Sign.neg) {
        imag = imag != null ? imag *= -1 : null;
      } else if (signNow != Sign.pos) {
        throw "invalid complex input string found '$str'";
      }
      signNow = Sign.unset;
    } else {
      throw "invalid complex input string found '$str'";
    }
  }

  if (signNow != Sign.unset) {
    throw "invalid complex input string found '$str'";
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
