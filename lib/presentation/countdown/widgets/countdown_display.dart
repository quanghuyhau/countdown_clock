import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/countdown_cubit.dart';
import '../cubit/countdown_state.dart';


class CountdownDisplay extends StatelessWidget {
  const CountdownDisplay({super.key});

  String _formatDuration(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$h:$m:$s";
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountdownCubit, CountdownState>(
      builder: (context, state) {
        return Center(
          child: Text(
            _formatDuration(state.remaining),
            style: TextStyle(
              fontSize: 150,
              fontWeight: FontWeight.bold,
              color: state.isCompleted ? Colors.greenAccent : Colors.white,
            ),
          ),
        );
      },
    );
  }
}
