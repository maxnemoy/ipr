import 'package:alg/lib.dart';

void main() {
  final list = List.generate(20000, (index) => index)..remove(0)..shuffle();

  final bubbleSortTimer = Stopwatch()..start();
  BubbleSort(list: list).sort();
  bubbleSortTimer.stop();
  print('bubble sort time: ${bubbleSortTimer.elapsedMilliseconds} ms');

  list.shuffle();

  final selectionSortTimer = Stopwatch()..start();
  SelectionSort(list: list).sort();
  selectionSortTimer.stop();
  print('selection sort time: ${selectionSortTimer.elapsedMilliseconds} ms');

  list.shuffle();
  final defaultSortTimer = Stopwatch()..start();
  list.sort();
  defaultSortTimer.stop();
  print('default sort time: ${defaultSortTimer.elapsedMilliseconds} ms');

  final binarySerachTimer = Stopwatch()..start();
  final index = BinarySearch(items: list).findItem(333);
  binarySerachTimer.stop();
  print('bin search index: $index time: ${binarySerachTimer.elapsedMicroseconds} mcs');

  final indexAtTimer = Stopwatch()..start();
  final i = list.indexOf(333);
  indexAtTimer.stop();
  print('default search index: $i time: ${indexAtTimer.elapsedMicroseconds} mcs');
}

/// выглядит так, что сортировки самому писать не стоит =)
/// bubble sort time: 957 ms
// selection sort time: 421 ms
// default sort time: 16 ms

// bin search index: 332 time: 567 mcs
// default search index: 332 time: 84 mcs