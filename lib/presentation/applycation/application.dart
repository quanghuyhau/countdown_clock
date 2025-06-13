import 'package:countdown_clock/data/repositories/coundown_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/start_countdown_use_case.dart';
import '../countdown/cubit/countdown_cubit.dart';
import '../countdown/ui/coundown_screen.dart';

class Application extends StatelessWidget {
  final countdownRepo = CountdownRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countdown Timer',
      debugShowCheckedModeBanner: false,
      home: const CountdownScreen(),
    );
  }
}
