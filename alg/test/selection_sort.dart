import 'package:alg/lib.dart';
import 'package:test/test.dart';

void main() {
  late List<int> listInt;
  late SelectionSort<int> sorter;

  setUpAll(() {
    listInt = List.generate(100, (index) => index);
    sorter = SelectionSort<int>(list: listInt.reversed.toList());
  });

  group("Selection Sort", () {
    group("Find smallest", () {
      test('Item is searched', () {
        expect(sorter.findSmallest(), sorter.list.length - 1);
      });
    });
    group("Sort", () {
      test('List is not sorted', () {
        expect(sorter.list.first == 99, isTrue);
      });
      test('List is sorted', () {
        sorter.sort();
        expect(sorter.list.first == 0, isTrue);
      });
    });
  });
}