import 'package:flutter/material.dart';
import 'package:kulobal/src/features/medication/model/medication.dart';
import 'package:kulobal/src/features/medication/model/reminders.dart';
import 'package:kulobal/src/features/medication/repo/medicationrepo.dart';
import 'package:kulobal/src/features/medication/repo/remindersrepo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'medicationcontroller.g.dart';

abstract class MedController {
  Future<void> addMedicine(BuildContext context, Medication medicine);
  Future<void> updateMedicine(BuildContext context, Medication medicine);
  Future<void> deleteMedicine(BuildContext context, int id);
  Future<List<Medication>> getMedicines();
  Future<Medication?> getMedicine(int id);
}

@Riverpod(keepAlive: true)
MedController medController(MedControllerRef ref) => Medicationrepo();

abstract class RemController {
  Future<void> addReminder(Reminders reminder);
  Future<void> deleteReminder(int remindId);
  Future<List<Reminders>> getReminders();
  Future<Reminders?> getReminder(int medId);
}

@Riverpod(keepAlive: true)
RemController remController(RemControllerRef ref) => Remindersrepo();
