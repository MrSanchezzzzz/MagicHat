import 'package:hooks_riverpod/hooks_riverpod.dart';

class CounterState {
  final int value;
  CounterState(this.value);
}

class TotalCounterNotifier extends StateNotifier<CounterState> {
  TotalCounterNotifier() : super(CounterState(0));

  void increment() {
    state = CounterState(state.value + 1);
  }
  void set(int value){
    state=CounterState(value);
  }
  void reset(){
    state=CounterState(0);
  }
}

class SuccessCounterNotifier extends StateNotifier<CounterState> {
  SuccessCounterNotifier() : super(CounterState(0));

  void increment() {
    state = CounterState(state.value + 1);
  }
  void set(int value){
    state=CounterState(value);
  }
  void reset(){
    state=CounterState(0);
  }
}

class FailedCounterNotifier extends StateNotifier<CounterState> {
  FailedCounterNotifier() : super(CounterState(0));

  void increment() {
    state = CounterState(state.value + 1);
  }
  void set(int value){
    state=CounterState(value);
  }
  void reset(){
    state=CounterState(0);
  }
}