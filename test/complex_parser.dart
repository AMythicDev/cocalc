import 'package:test/test.dart';
import 'package:cocalc/complex_parser.dart';
import 'package:equations/equations.dart';

void main() {
  group("parse doubles", () {
    test("parse x type", () {
      expect(parseDouble('123', 0).$1, equals(123));
    });
    test("parse x.y type", () {
      expect(parseDouble('123.45', 0).$1, equals(123.45));
    });
    test("parse .y type", () {
      expect(parseDouble('.45', 0).$1, equals(.45));
    });
  });

  group("parse complex", () {
    test("parse x", () {
      expect(parseComplex('2'), equals(Complex(2, 0)));
    });
    test("parse iy", () {
      expect(parseComplex('i2'), equals(Complex(0, 2)));
    });
    test("parse +x", () {
      expect(parseComplex('+2'), equals(Complex(2, 0)));
    });
    test("parse +iy", () {
      expect(parseComplex('+i2'), equals(Complex(0, 2)));
    });
    test("parse -x", () {
      expect(parseComplex('-2'), equals(Complex(-2, 0)));
    });
    test("parse -iy", () {
      expect(parseComplex('-i2'), equals(Complex(0, -2)));
    });
    test("parse yi", () {
      expect(parseComplex('2i'), equals(Complex(0, 2)));
    });
    test("parse x + iy", () {
      expect(parseComplex('2 + i3'), equals(Complex(2, 3)));
    });
    test("parse x + yi", () {
      expect(parseComplex('2 + 3i'), equals(Complex(2, 3)));
    });
    test("parse ix + y", () {
      expect(parseComplex('i2 + 3'), equals(Complex(3, 2)));
    });
    test("parse xi + y", () {
      expect(parseComplex('2i + 3'), equals(Complex(3, 2)));
    });
    test("parse i", () {
      expect(parseComplex('i'), equals(Complex(0, 1)));
    });
    test("parse x + i", () {
      expect(parseComplex('2 + i'), equals(Complex(2, 1)));
    });
    test("parse i + x", () {
      expect(parseComplex('i + 2'), equals(Complex(2, 1)));
    });
    test("error on xi + yi", () {
      expect(() => parseComplex('2i + 3i'), throwsA(isA<String>()));
    });
    test("error on xi yi", () {
      expect(() => parseComplex('2i 3i'), throwsA(isA<String>()));
    });
    test("error on xii y", () {
      expect(() => parseComplex('2ii 3'), throwsA(isA<String>()));
    });
    test("error on x yi", () {
      expect(() => parseComplex('2 3i'), throwsA(isA<String>()));
    });
    test("error on xi y", () {
      expect(() => parseComplex('2i 3'), throwsA(isA<String>()));
    });
    test("error on x + y", () {
      expect(() => parseComplex('2 + 3'), throwsA(isA<String>()));
    });
    test("error on ai + bi", () {
      expect(() => parseComplex('ai + bi'), throwsA(isA<String>()));
    });
    test("error on x +", () {
      expect(() => parseComplex('2 +'), throwsA(isA<String>()));
    });
    test("error on xi +", () {
      expect(() => parseComplex('2i +'), throwsA(isA<String>()));
    });
  });
}
