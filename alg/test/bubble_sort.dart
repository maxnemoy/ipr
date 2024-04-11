
import 'package:alg/lib.dart';
import 'package:test/test.dart';

void main() {
  late List<int> listInt;
  late BubbleSort<int> sorter;

  setUpAll(() {
    listInt = List.generate(100, (index) => index);
    sorter = BubbleSort<int>(list: listInt.reversed.toList());
  });

  group("Bubble Sort", () {
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
