import 'dart:async';
import 'package:countdown_clock/domain/usecases/start_countdown_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'countdown_state.dart';

class CountdownCubit extends Cubit<CountdownState> {
  final StartCountdown startCountdown;
  StreamSubscription? _subscription;

  CountdownCubit(this.startCountdown)
      : super(CountdownState(remaining: Duration.zero));

  void start(Duration duration) {
    _subscription?.cancel();
    emit(CountdownState(remaining: duration, isRunning: true));
    _subscription = startCountdown(duration).listen((remaining) {
      emit(CountdownState(
        remaining: remaining,
        isRunning: remaining.inSeconds > 0,
        isCompleted: remaining.inSeconds == 0,
      ));
    });
  }

  void reset() {
    _subscription?.cancel();
    emit(CountdownState(remaining: Duration.zero));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
