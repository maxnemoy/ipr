import 'package:alg/lib.dart';
import 'package:test/test.dart';
import 'dart:math';

void main() {
  late List<int> listInt;
  late List<double> listDouble;
  late BinarySearch<int> searcher;
  late BinarySearch<double> searcherDouble;
  late Random rand;

  setUpAll(() {
    rand = Random();
    listInt = List.generate(100, (index) => index);
    listDouble = [1.32, 1.54, 5.4, 24.4];
    searcher = BinarySearch<int>(items: listInt);
    searcherDouble = BinarySearch<double>(items: listDouble);
  });

  group("Binary search", () {
    group("Int type", () {
      test('Item is searched', () {
        int someValue = rand.nextInt(100);
        expect(searcher.findItem(someValue), listInt.indexOf(someValue));
      });
      test('Item is out of range', () {
        expect(searcher.findItem(101), isNull);
      });
      test('Item is out of range (negative)', () {
        expect(searcher.findItem(-1), isNull);
      });
    });
    group("Double type", () {
      test('Item is searched', () {
        expect(searcherDouble.findItem(5.4), listDouble.indexOf(5.4));
      });
      test('Item is out of range', () {
        expect(searcherDouble.findItem(1.2), isNull);
      });
      test('Item is out of range (negative)', () {
        expect(searcherDouble.findItem(-1.1), isNull);
      });
    });

    // group("Unsupported type", () {
    //   BinarySearch s = BinarySearch(items: [true]);
    //   test('Unsupported list', () {
    //     expect(() => s.findItem(false), throwsA(isA<UnsupportedTypeError>()));
    //   });
    // });
  });
}
