import 'package:test/test.dart';
import 'package:cocalc/solver.dart';
import 'package:equations/equations.dart';

void main() {
  group("equation solver", () {
    test("partial pivot 2x2", () {
      final coffs = [
        [Complex(1, 2), Complex(2, 3)],
        [Complex(2, 3), Complex(1, 2)]
      ];
      expect(Solver.findPartialPivot(coffs, 0), equals(1));
      expect(Solver.findPartialPivot(coffs, 1), equals(1));
    });

    test("solve 2x2 equation", () {
      final coffs = [
        [Complex(1, 2), Complex(2, 3)],
        [Complex(2, 3), Complex(1, 2)]
      ];

      final consts = [Complex(3, 5), Complex(3, 5)];

      final solver = Solver(coffs, consts);
      expect(solver.solve(), equals([Complex(1, 0), Complex(1, 0)]));
    });
  });
}
