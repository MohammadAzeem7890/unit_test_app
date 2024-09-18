import 'package:flutter/material.dart';
import 'package:unit_testing_app/home_cubit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeCubit _cubit = HomeCubit();

  incrementCounter() {
    setState(() {
      _cubit.incrementCounter();
    });
  }

  decrementCounter() {
    setState(() {
      _cubit.decrementCounter();
    });
  }

  resetCounter() {
    setState(() {
      _cubit.resetCounter();
      _cubit.getPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${_cubit.getCounter}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              onPressed: incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: decrementCounter,
              tooltip: 'Decrement',
              child: const Icon(Icons.minimize),
            ),
            FloatingActionButton(
              onPressed: resetCounter,
              tooltip: 'Reset',
              child: const Icon(Icons.lock_reset_outlined),
            )
          ],
        ),
      ),
    );
  }
}
