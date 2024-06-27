import 'dart:developer';
import 'package:isar/isar.dart';
import 'package:kulobal/src/features/medication/model/reminders.dart';
import 'package:kulobal/src/features/medication/repo/medicationcontroller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../startup.dart';

part 'remindersrepo.g.dart';

class Remindersrepo extends RemController {
  @override
  Future<void> addReminder(Reminders reminder) async {
    try {
      await isar.writeTxn(() => isar.reminders.put(reminder));
    } on IsarError catch (e) {
      log(e.message);
    }
  }

  @override
  Future<void> deleteReminder(int remindId) async {
    await isar.writeTxn(() => isar.reminders.delete(remindId));
  }

  @override
  Future<Reminders?> getReminder(int medId) async {
    return await isar.reminders.get(medId);
  }

  @override
  Future<List<Reminders>> getReminders() async {
    return await isar.reminders.where().findAll();
  }
}

@riverpod
Future<List<Reminders>> getReminders(GetRemindersRef ref) {
  final c = ref.watch(remControllerProvider);
  return c.getReminders();
}
