import 'package:flutter/widgets.dart';

class CounterState {
  int value = 0;
  void inc() => value++;
  void dec() => value--;

  String get count => value.toString();

  bool diff(CounterState old) {
    return old.value != value;
  }
}

class CounterProvider extends InheritedWidget {
  final CounterState state = CounterState();

  CounterProvider({required Widget child, super.key}) : super(child: child);

  static CounterProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

  @override
  bool updateShouldNotify(covariant CounterProvider oldWidget) {
    return state.diff(oldWidget.state);
  }
}
