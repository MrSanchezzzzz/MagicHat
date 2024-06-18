
import 'package:magic_hat/Utils/cache.dart';
import 'package:magic_hat/Utils/requests.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/CounterState.dart';
import '../models/personage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final randomPersonageProvider = FutureProvider<Personage>((ref) async {
  return await Requests.getRandomPersonage();
});


class PersonagesNotifier extends StateNotifier<List<Personage>> {
  PersonagesNotifier(List<Personage> initialPersonages) : super(initialPersonages);

  void addPersonage(Personage personage) async{
    FileManager.appendPersonage(personage); // Save to file
    state = await FileManager.getAllPersonages();
  }
}
final guessedPersonagesProvider=FutureProvider<List<Personage>>((ref) async{
  return await FileManager.getAllPersonages();
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



