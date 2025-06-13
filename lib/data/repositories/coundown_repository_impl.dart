import 'dart:async';
import '../../domain/repositories/countdown_repository.dart';

class CountdownRepositoryImpl implements CountdownRepository {
  @override
  Stream<Duration> startCountdown(Duration duration) async* {
    int seconds = duration.inSeconds;
    for (int i = seconds; i >= 0; i--) {
      await Future.delayed(Duration(seconds: 1));
      yield Duration(seconds: i);
    }
  }
}
