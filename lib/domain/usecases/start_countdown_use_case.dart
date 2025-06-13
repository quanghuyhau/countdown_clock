import '../repositories/countdown_repository.dart';

class StartCountdown {
  final CountdownRepository repository;

  StartCountdown(this.repository);

  Stream<Duration> call(Duration duration) {
    return repository.startCountdown(duration);
  }
}
