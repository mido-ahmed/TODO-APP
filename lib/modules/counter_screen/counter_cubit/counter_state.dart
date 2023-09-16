part of 'counter_cubit.dart';

@immutable
abstract class CounterState {}

class CounterInitial extends CounterState {}

class CounterPlus extends CounterState {
  final int counter;

  CounterPlus(this.counter);
}

class CounterMinus extends CounterState {
  final int counter;

  CounterMinus(this.counter);
}
