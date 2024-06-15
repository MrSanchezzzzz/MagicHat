import 'dart:convert';
import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:magic_hat/Utils/provider.dart';

import '../Entities/personage.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
  static const String _pesonagesFileName = 'personages.json';
  static const String _countersFileName = 'counters.txt';

  static Future<void> clear() async {
    File file = File(await _getPersonagesPath());
    file.writeAsString('');
    file = File(await _getCountersPath());
    file.writeAsString('');
  }


  static Future<String> _getPersonagesPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$_pesonagesFileName';
  }

  static Future<String> _getCountersPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$_countersFileName';
  }

  static Future<File> writeCounters(int total, int success, int failed) async {
    final file = File(await _getCountersPath());
    return file.writeAsString('$total,$success,$failed');
  }

  static Future<List<int>> readCounters() async {
    try {
      final file = File(await _getCountersPath());
      String contents = await file.readAsString();
      List<String> counterStrings = contents.split(',');
      List<int> counters = counterStrings.map((e) => int.parse(e)).toList();
      return counters;
    } catch (e) {
      return [0, 0, 0];
    }
  }

  static Future<void> loadCountersIntoProviders(WidgetRef ref) async {
    List<int> counters = await readCounters();
    ref.read(totalCounterProvider.notifier).set(counters[0]);
    ref.read(successCounterProvider.notifier).set(counters[1]);
    ref.read(failedCounterProvider.notifier).set(counters[2]);
  }


  static Future<void> appendPersonage(Personage personage) async {
    final filePath = await _getPersonagesPath();
    final file = File(filePath);

    List<dynamic> jsonList = [];
    bool shouldAdd = true;

    if (await file.exists()) {
      String existingContent = await file.readAsString();
      if (existingContent.isNotEmpty) {
        jsonList = jsonDecode(existingContent);

        for (var item in jsonList) {
          print(item['id']);
          print(personage.id);
          if (item['id']==personage.id) {
            item['attempts'] = (item['attempts'] ?? 0) + 1;
            shouldAdd = false;
            break;
          }
        }
      }
    }

    if (shouldAdd) {
      jsonList.add(personage.toJson());
    }

    await file.writeAsString(jsonEncode(jsonList));
  }

  static Future<Personage?> getPersonageById(String id) async {
    final filePath = await _getPersonagesPath();
    final file = File(filePath);

    if (await file.exists()) {
      String jsonString = await file.readAsString();
      List<dynamic> jsonList = jsonDecode(jsonString);

      for (var json in jsonList) {
        Personage personage = Personage.fromJson(json);
        if (personage.id == id) {
          return personage;
        }
      }
    }

    return null;
  }

  static Future<List<Personage>> getAllPersonages() async {
    final filePath = await _getPersonagesPath();
    final file = File(filePath);

    if (await file.exists()) {
      String jsonString = await file.readAsString();
      if(jsonString.isEmpty)
        return [];
      List<dynamic> jsonList = jsonDecode(jsonString);

      return jsonList.map((json) => Personage.fromJson(json)).toList();
    }

    return [];
  }

  static Future<void> removePersonage(String id) async {
    final filePath = await _getPersonagesPath();
    final file = File(filePath);

    if (await file.exists()) {
      String jsonString = await file.readAsString();
      List<dynamic> jsonList = jsonDecode(jsonString);

      jsonList.removeWhere((json) => Personage.fromJson(json).id == id);

      await file.writeAsString(jsonEncode(jsonList));
    }
  }
}
