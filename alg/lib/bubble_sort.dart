class BubbleSort<T extends num>{
  final List<T> list;

  BubbleSort({required this.list});

  List<T> sort() {
    int listLength = list.length;

    for (int i = 0; i < listLength; i++) {
      for (int j = 0; j < listLength - i - 1; j++) {
        if (list[j] > list[j + 1]) {
          T temp = list[j];
          list[j] = list[j + 1];
          list[j + 1] = temp;
        }
      }
    }

    return list;
  }
}