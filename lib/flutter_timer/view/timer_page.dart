import 'package:bloc_learn/flutter_timer/bloc/timer_bloc.dart';
import 'package:bloc_learn/flutter_timer/ticker.dart';
import 'package:bloc_learn/flutter_timer/view/timer_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerBloc(ticker: const Ticker()),
      child: const TimerView(),
    );
  }
}
