import 'package:test/test.dart';
import 'package:cocalc/solver.dart';
import 'package:complex/complex.dart';

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
  });
}
