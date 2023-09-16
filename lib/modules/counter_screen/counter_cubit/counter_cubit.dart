import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitial());
  int counter = 0;

  static CounterCubit get(context) => BlocProvider.of(context);

  void minus() {
    counter--;
    emit(CounterMinus(counter));
  }

  void plus() {
    counter++;
    emit(CounterPlus(counter));
  }
}
