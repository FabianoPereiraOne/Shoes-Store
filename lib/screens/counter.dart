import 'package:flutter/material.dart';
import 'package:my_store/providers/counter.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Counter Page")),
      body: Column(
        children: [
          Text(CounterProvider.of(context)!.state.count),
          IconButton(
            onPressed: () {
              setState(() {
                CounterProvider.of(context)!.state.inc();
              });
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                CounterProvider.of(context)!.state.dec();
              });
            },
            icon: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
