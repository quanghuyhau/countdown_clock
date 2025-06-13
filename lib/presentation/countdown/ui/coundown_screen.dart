import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/coundown_repository_impl.dart';
import '../../../domain/usecases/start_countdown_use_case.dart';
import '../cubit/countdown_cubit.dart';
import '../cubit/countdown_state.dart';

class CountdownScreen extends StatefulWidget {
  const CountdownScreen({super.key});

  @override
  State<CountdownScreen> createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> {
  final _hoursController = TextEditingController(text: "0");
  final _minutesController = TextEditingController(text: "0");
  final _secondsController = TextEditingController(text: "10");

  @override
  void dispose(){
    super.dispose();
    _hoursController.dispose();
    _minutesController.dispose();
    _secondsController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CountdownCubit(
       StartCountdown(CountdownRepositoryImpl()),
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: BlocBuilder<CountdownCubit, CountdownState>(
            builder: (context, state) {
              return Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        _formatDuration(state.remaining),
                        style: TextStyle(
                          fontSize: 120,
                          fontWeight: FontWeight.bold,
                          color: state.isCompleted ? Colors.greenAccent : Colors.white,
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _timeInputField("Giờ", _hoursController),
                          const SizedBox(height: 12),
                          _timeInputField("Phút", _minutesController),
                          const SizedBox(height: 12),
                          _timeInputField("Giây", _secondsController),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton.icon(
                                onPressed: state.isRunning
                                    ? null
                                    : () {
                                  final h = int.tryParse(_hoursController.text) ?? 0;
                                  final m = int.tryParse(_minutesController.text) ?? 0;
                                  final s = int.tryParse(_secondsController.text) ?? 0;
                                  final duration = Duration(hours: h, minutes: m, seconds: s);
                                  if (duration.inSeconds > 0) {
                                    context.read<CountdownCubit>().start(duration);
                                  }
                                },
                                icon: const Icon(Icons.play_arrow),
                                label: const Text("Bắt đầu"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  context.read<CountdownCubit>().reset();
                                },
                                icon: const Icon(Icons.refresh),
                                label: const Text("Đặt lại"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

   _timeInputField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "0",
            filled: true,
            fillColor: Colors.white10,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$h:$m:$s";
  }
}
