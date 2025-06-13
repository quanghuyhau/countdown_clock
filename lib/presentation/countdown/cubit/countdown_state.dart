class CountdownState {
  final Duration remaining;
  final bool isCompleted;
  final bool isRunning;

  CountdownState({
    required this.remaining,
    this.isCompleted = false,
    this.isRunning = false,
  });
}
