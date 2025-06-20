// This package provides the Solver class to solve a system of linear equations
// that specifically involve terms in the complex domain.
//
// The solver uses the Guassian Elimination method with partial pivots to ensure
// numerical stability throughout the iterations
//
// This code is directly inspired from the
// [equations](https://github.com/albertodev01/equations) package originally
// written by Alberto (@albertodev01) and contributors and licensed under the
// MIT License
//
// However this package is made specifically to work with numbers in the complex
// domain where the original was meant to work with only real numbers.
// It also implicitly handles truncating the resulting values based on the set
// precision

import 'package:equations/equations.dart';
import 'dart:math';

class Solver {
  final ComplexMatrix coffs;
  final List<Complex> consts;
  double precision;

  Solver.fromComplexMatrix(
      {required this.coffs, required this.consts, this.precision = 1e-10}) {
    if (!coffs.isSquareMatrix) {
      throw "cofficient matrix is non-square matrix";
    }
    if (coffs.rowCount != consts.length) {
      throw "cofficient matrix row count does not match constants matrix";
    }
  }

  Solver(List<List<Complex>> coffs, List<Complex> consts)
      : this.fromComplexMatrix(
            coffs: ComplexMatrix.fromData(
                rows: coffs.length, columns: coffs[0].length, data: coffs),
            consts: consts);

  List<Complex> solve() {
    final A = coffs.toListOfList();
    final b = consts.toList();

    for (int col = 0; col < coffs.columnCount - 1; col++) {
      final max = findPartialPivot(A, col);

      final tcf = A[max];
      A[max] = A[col];
      A[col] = tcf;
      final tcn = b[max];
      b[max] = b[col];
      b[col] = tcn;

      if (A[col][col].abs() <= precision) {
        throw "the matrix is either singular or nearly singular";
      }

      for (var i = col + 1; i < coffs.columnCount; i++) {
        final alpha = A[i][col] / A[col][col];
        b[i] -= alpha * b[col];
        for (var j = col; j < coffs.columnCount; j++) {
          A[i][j] -= alpha * A[col][j];
        }
      }
    }

    var compRes = backSubstitution(A, b);
    List<Complex> result = [];

    for (int i = 0; i < compRes.length; i++) {
      var real = double.parse(compRes[i]
          .real
          .toStringAsFixed((-1 * log(precision) / log(10)).floor()));
      var imag = double.parse(compRes[i]
          .imaginary
          .toStringAsFixed((-1 * log(precision) / log(10)).floor()));
      result.add(Complex(real, imag));
    }

    return result;
  }

  static List<Complex> backSubstitution(
    List<List<Complex>> source,
    List<Complex> vector,
  ) {
    final size = vector.length;
    final solutions =
        List<Complex>.generate(size, (_) => Complex(0, 0), growable: false);

    for (var i = size - 1; i >= 0; --i) {
      solutions[i] = vector[i];
      for (var j = i + 1; j < size; ++j) {
        solutions[i] = solutions[i] - source[i][j] * solutions[j];
      }
      solutions[i] = solutions[i] / source[i][i];
    }

    return solutions;
  }

  static int findPartialPivot(List<List<Complex>> A, int col) {
    var max = col;
    for (int row = col + 1; row < A[0].length; row++) {
      if (A[row][col].abs() > A[max][col].abs()) {
        max = row;
      }
    }
    return max;
  }
}
