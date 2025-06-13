import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/countdown_cubit.dart';
import '../cubit/countdown_state.dart';

class ActionButtons extends StatelessWidget {
  final TextEditingController hoursController;
  final TextEditingController minutesController;
  final TextEditingController secondsController;
  final VoidCallback onOpenDrawer;

  const ActionButtons({
    super.key,
    required this.hoursController,
    required this.minutesController,
    required this.secondsController,
    required this.onOpenDrawer,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountdownCubit, CountdownState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: state.isRunning
                  ? null
                  : () {
                final h = int.tryParse(hoursController.text) ?? 0;
                final m = int.tryParse(minutesController.text) ?? 0;
                final s = int.tryParse(secondsController.text) ?? 0;
                final duration = Duration(hours: h, minutes: m, seconds: s);
                if (duration.inSeconds > 0) {
                  context.read<CountdownCubit>().start(duration);
                }
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text("Bắt đầu"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => context.read<CountdownCubit>().reset(),
              icon: const Icon(Icons.refresh),
              label: const Text("Đặt lại"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onOpenDrawer,
              icon: const Icon(Icons.timer),
              label: const Text("Nhập thời gian"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            ),
          ],
        );
      },
    );
  }
}
