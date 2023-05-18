import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/counter_provider.dart';

var counter = 0;

class Counter extends StatelessWidget {
  const Counter({Key? key}) : super(key: key);

  void _incrementCounterHere() {
    counter++;
  }

  void _decrementCounterHere() {
    counter--;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Counter")),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Counter global variable: $counter"),
            // Text("Counter: ${context.watch<CounterProvider>().count} ")),
            Consumer<CounterProvider>(
                builder: (context, counterProvider, _) =>
                    Text("Counter: ${counterProvider.count}")),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () =>
                    Provider.of<CounterProvider>(context, listen: false)
                        .increment(),
                child: const Text("Increment")),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () =>
                    Provider.of<CounterProvider>(context, listen: false)
                        .decrement(),
                child: const Text("Decrement")),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: _incrementCounterHere,
                child: const Text("Increment here")),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: _decrementCounterHere,
                child: const Text("Decrement here")),
          ],
        ),
      ),
    );
  }
}
