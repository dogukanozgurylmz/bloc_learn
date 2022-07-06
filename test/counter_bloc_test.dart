import 'package:bloc_learn/counter_bloc/counter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('CounterBloc', () {
    late CounterBloc counterBloc;

    setUp(
      () {
        counterBloc = CounterBloc();
      },
    );

    test(
      "initial state is 0",
      () {
        expect(counterBloc.state, 0);
      },
    );

    blocTest(
      "emits [1] when CounterIncrementPressed is added",
      build: () => counterBloc,
      act: (Bloc bloc) => bloc.add(CounterIncrementPressed()),
      expect: () => [1],
    );

    blocTest(
      "emits [-1] when CounterDecrementPressed is added",
      build: () => counterBloc,
      act: (Bloc bloc) => bloc.add(CounterDecrementPressed()),
      expect: () => [-1],
    );
  });
}
