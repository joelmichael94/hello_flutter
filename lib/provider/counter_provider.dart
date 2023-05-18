import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier {
  var count = 0;

  void increment() {
    count++;
    notifyListeners();
  }

  void decrement() {
    count--;
    notifyListeners();
  }
}
