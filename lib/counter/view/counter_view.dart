import 'package:bloc_learn/counter/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterView extends StatelessWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter"),
      ),
      body: _body(context),
      floatingActionButton: _fabs(context),
    );
  }

  Column _fabs(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          onPressed: () {
            context.read<CounterCubit>().increment();
          },
          child: const Icon(Icons.add),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: FloatingActionButton(
            onPressed: () {
              context.read<CounterCubit>().decrement();
            },
            child: const Icon(Icons.remove),
          ),
        ),
      ],
    );
  }

  Center _body(context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: BlocBuilder<CounterCubit, int>(
        builder: (context, state) {
          return Text('$state', style: textTheme.headline2);
        },
      ),
    );
  }
}
