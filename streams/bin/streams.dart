import 'dart:async';

Stream<int> countStream(int to) async* {
  for (int i = 1; i <= to; i++) {
    await Future.delayed(const Duration(milliseconds: 500));
    yield i;
  }
}

void main(List<String> arguments) {
  final stream = countStream(10).asBroadcastStream();

  // Подписываемся на поток данных
  stream.listen((value) {
    print('Value: $value');
  });

  // Получаем первое значение
  stream.first.then((value) {
    print('First value: $value');
  });

  // Получаем единственное значение потока
  // если в потоке больше одного значения, то будет ошибка
  // stream.single.then((value) {
  //   print('Single value: $value');
  // });

  // последнее значение потока,
  // как только оно становится доступным
  // так же можно получить последнее значение которое было
  // перед ошибкой в потоке
  stream.last.then((value) {
    print('Last value: $value');
  });

  // проверяем есть ли в потоке значения
  print('Stream is empty: ${stream.isEmpty}');

  // Пример использования where
  stream.where((value) => value % 2 == 0).listen((value) {
    print('Even value: $value');
  });

  // Пример использования map
  stream.map((value) => value * 2).listen((value) {
    print('Mapped value: $value');
  });

  // расширяем поток данных
  stream.expand((value) => [value, value * 2, value * 3]).listen((value) {
    print('Expand value: $value');
  });

  // получаем n первых значений
  stream.take(3).listen((value) {
    print('Take value: $value');
  });

  // пропускаем n первых значений
  stream.skip(3).listen((value) {
    print('Skipped 3 value: $value');
  });

  // пропускаем повторяющиеся значения
  stream.map((value) => value == 2 ? 2 : 1).distinct((a, b) => a == b).listen((value) {
    print('no repetitions: $value');
  });

  // получаем и обрабатываем каждое значение
  // отличие от слушателя в том,
  // что тут фьюче и можно подождать окончания стрима
  stream.forEach((value) => print('for value: $value')).then((_) => print('stream ended'));

  /// ждем окончания стрима как фьюче
  /// можно вернуть результат окончания как специфичный параметр
  stream.drain<bool>(true).then((e) => e ? print('stream ended') : print('stream not ended'));

  // перенаправляем поток
  final streamConsumer = Consumer();
  stream.pipe(streamConsumer).then((value) => 'pipe result: $value');

  // преобразуем поток
  stream.transform(SquareTransformer()).listen((value) {
    print('Transformed value: $value');
  });

  // обрабатываем последовательно все значения стрима
  // в данном случае находим сумму всех элементов
  stream.reduce((previous, current) => previous + current).then((value) => print('reduced value: $value'));

  // проверяем соответствует ли хотябы одно значение условию
  stream.any((e) => e > 100).then((v)=> print('contains value > 100: $v'));

  // проверяем что все события потока числа
  // ignore: unnecessary_type_check
  stream.every((e) => e is num).then((v)=> print('all values is numeric: $v'));

  // объедением все события пока в строку
  stream.join(',').then((value) => print('joined values: $value'));

  // можем добавить обработку
  // если между событиями в потоке прошло
  // меньше указанного времени
  stream.timeout(Duration(microseconds: 1), onTimeout: (_){
    print('timeout error');
  }).listen((v)=> print('value with timeout: $v'));
}

class Consumer implements StreamConsumer<int> {
  @override
  Future addStream(Stream<int> stream) {
    return stream.listen(print).asFuture();
  }

  @override
  Future close() {
    return Future.value();
  }
}

class SquareTransformer extends StreamTransformerBase<int, int> {
  @override
  Stream<int> bind(Stream<int> stream) {
    return stream.map((value) => value * value);
  }
}
