
import 'package:magic_hat/Utils/cache.dart';
import 'package:magic_hat/Utils/requests.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../Entities/CounterState.dart';
import '../Entities/personage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final randomPersonageProvider = FutureProvider<Personage>((ref) async {
  return await Requests.getRandomPersonage();
});


class PersonagesNotifier extends StateNotifier<List<Personage>> {
  PersonagesNotifier(List<Personage> initialPersonages) : super(initialPersonages);

  void addPersonage(Personage personage) {
    state = [...state, personage];
    FileManager.appendPersonage(personage); // Save to file
  }
}

final guessedPersonagesProvider = StateNotifierProvider<PersonagesNotifier, List<Personage>>((ref) {
  final initialPersonages = ref.watch(initialPersonagesProvider).value ?? [];
  return PersonagesNotifier(initialPersonages);
});

final initialPersonagesProvider = FutureProvider<List<Personage>>((ref) async {
  return await FileManager.getAllPersonages();
});

final totalCounterProvider = StateNotifierProvider<TotalCounterNotifier, CounterState>((ref) {
  return TotalCounterNotifier();
});

final successCounterProvider = StateNotifierProvider<SuccessCounterNotifier, CounterState>((ref) {
  return SuccessCounterNotifier();
});

final failedCounterProvider = StateNotifierProvider<FailedCounterNotifier, CounterState>((ref) {
  return FailedCounterNotifier();
});



