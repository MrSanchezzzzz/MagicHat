import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:magic_hat/Utils/cache.dart';
import 'package:magic_hat/Wigets/house_button.dart';

import '../models/personage.dart';
import '../Utils/provider.dart';
import '../Wigets/character_sheet.dart';
import '../Wigets/counters_fragment.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  Future<void> checkHouse(String house) async {
    final personage = (ref.read(randomPersonageProvider)).value;
    if (personage != null) {
      bool correct = personage.house == house;
      if (correct) {
        ref.read(successCounterProvider.notifier).increment();
        personage.isGuessedCorrect = true;
      } else {
        ref.read(failedCounterProvider.notifier).increment();
      }

      await FileManager.appendPersonage(personage);
      ref.refresh(guessedPersonagesProvider);
      ref.read(totalCounterProvider.notifier).increment();
      await FileManager.writeCounters(
        ref.read(totalCounterProvider).value,
        ref.read(successCounterProvider).value,
        ref.read(failedCounterProvider).value,
      );
    }
     ref.refresh(randomPersonageProvider);
  }

  @override
  Widget build(BuildContext context) {
    final double buttonHeight = MediaQuery.of(context).size.height * 0.075;
    AsyncValue<Personage> personage = ref.watch(randomPersonageProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.refresh(randomPersonageProvider.future);
      },
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: constraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CountersFragment(),
                  Expanded(
                    child: personage.value == null
                        ? Container()
                        : CharacterSheet(
                      url: personage.value!.image,
                      name: personage.value!.name,
                    )
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            HouseButton(house: 'gryffindor', onTap: () => checkHouse('Gryffindor')),
                            HouseButton(house: 'slytherin', onTap: () => checkHouse('Slytherin')),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            HouseButton(house: 'hufflepuff', onTap: () => checkHouse('Hufflepuff')),
                            HouseButton(house: 'ravenclaw', onTap: () => checkHouse('Ravenclaw')),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: SizedBox(
                            height: buttonHeight,
                            child: ElevatedButton(
                              onPressed: () => checkHouse(''),
                              child: Text(
                                "Not in house",
                                style: TextStyle(fontSize: 28, fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
