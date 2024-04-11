class BinarySearch<T extends num> {
  final List<T> items;

  BinarySearch({required this.items});

  int? findItem(T item) {
    int start = 0;
    int end = items.length - 1;

    while (start <= end) {
      int middleIndex = ((start + end) / 2).ceil();
      T itm = items[middleIndex];
      if (itm == item) {
        return middleIndex;
      }

      if (itm > item) {
        end = --middleIndex;
      } else {
        start = ++middleIndex;
      }
    }
    return null;
  }
}

