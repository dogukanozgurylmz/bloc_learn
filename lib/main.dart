import 'package:bloc_learn/infinite_list/infinite_list_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'infinite_list/simple_bloc_observer.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(const InfiniteListApp()),
    blocObserver: SimpleBlocObserver(),
  );
}
