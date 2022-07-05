import 'package:bloc/bloc.dart';
import 'package:bloc_learn/counter_bloc/counter_bloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _increment() async {
    BlocOverrides.runZoned(
      () {
        CounterBloc()
          ..add(CounterIncrementPressed())
          ..close();
      },
      blocObserver: SimpleBlocObserver(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _increment();
          },
          child: const Text("data"),
        ),
      ),
    );
  }
}
