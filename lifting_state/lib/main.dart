import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Root());
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return SharedDataWidget(
      sharedData: SharedData.initial(),
      child: MaterialApp(
        home: Scaffold(
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Builder(
                builder: (context) {
                  final shared = SharedDataWidget.of(context)!;
                  final data = shared.sharedData;
                  return Row(
                    children: [
                      Expanded(
                          child: SomeChild(
                        color: data.first.value,
                        onPressed: () {
                          shared.sharedData.secondColor = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1);
                        },
                      )),
                      Expanded(
                        child: ValueListenableBuilder(
                          valueListenable: data.second,
                          builder: (context, color, _) => SomeChild(
                            color: color,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SomeChild extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color color;

  const SomeChild({
    super.key,
    this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        color: color,
      ),
    );
  }
}

class SharedDataWidget extends InheritedWidget {
  final SharedData sharedData;

  const SharedDataWidget({super.key, required this.sharedData, required super.child});

  @override
  bool updateShouldNotify(SharedDataWidget oldWidget) {
    return oldWidget.sharedData != sharedData;
  }

  static SharedDataWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SharedDataWidget>();
  }
}

class SharedData {
  final ValueNotifier<Color> _firstColor;
  final ValueNotifier<Color> _secondColor;

  set firstColor(Color value) => _firstColor.value = value;
  set secondColor(Color value) => _secondColor.value = value;

  ValueListenable<Color> get first => _firstColor;
  ValueListenable<Color> get second => _secondColor;

  SharedData({required Color firstColor, required Color secondColor})
      : _firstColor = ValueNotifier<Color>(firstColor),
        _secondColor = ValueNotifier<Color>(secondColor);

  factory SharedData.initial() {
    return SharedData(
      firstColor: Colors.red,
      secondColor: Colors.blue,
    );
  }

  @override
  operator ==(Object other) {
    if (other is! SharedData) {
      return false;
    }

    return _firstColor.value == other.first.value && _secondColor.value == other.second.value;
  }

  @override
  int get hashCode => _firstColor.value.hashCode ^ _secondColor.value.hashCode;
}
