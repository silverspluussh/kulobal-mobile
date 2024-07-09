// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:kulobal/src/components/alert_dialogs.dart';
import 'package:kulobal/src/constant/style.dart';
import 'package:kulobal/src/features/medication/model/medication.dart';
import 'package:kulobal/src/features/medication/repo/medicationcontroller.dart';
import 'package:kulobal/startup.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:velocity_x/velocity_x.dart';

part 'medicationrepo.g.dart';

class Medicationrepo extends MedController {
  final GlobalKey<State> medKey = GlobalKey<State>();

  @override
  Future<void> addMedicine(BuildContext context, Medicmodel medicine) async {
    showLoadingDialog(
        context: context, key: medKey, label: "Adding medication");
    try {
      await isar.writeTxn(() => isar.medicmodels.put(medicine));
      Navigator.of(context, rootNavigator: true).pop();
      customToast(context,
          message: "Medication created successfully.",
          color: Vx.green500,
          textColor: KWhite);
    } catch (e) {
      log(e.toString());
      Navigator.of(context, rootNavigator: true).pop();
      showExceptionAlertDialog(
          context: context,
          title: "Error",
          exception: "Medication could not be created");
    }
  }

  @override
  Future<void> deleteMedicine(BuildContext context, int id) async {
    showLoadingDialog(
        context: context, key: medKey, label: "Deleting medication entry");
    try {
      await isar.writeTxn(() => isar.medicmodels.delete(id));
      Navigator.of(context, rootNavigator: true).pop();
      customToast(context,
          message: "Medication deleted successfully.",
          color: Vx.green500,
          textColor: KWhite);
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      showExceptionAlertDialog(
          context: context,
          title: "Error",
          exception: "Medication could not be deleted.");
    }
  }

  @override
  Future<Medicmodel?> getMedicine(int id) async {
    try {
      return await isar.medicmodels.get(id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Medicmodel>> getMedicines() async {
    return await isar.medicmodels.where().findAll();
  }

  @override
  Future<void> updateMedicine(BuildContext context, Medicmodel medicine) async {
    showLoadingDialog(
        context: context, key: medKey, label: "Updating medication");
    try {
      await isar.medicmodels.put(medicine);
      Navigator.of(context, rootNavigator: true).pop();
      customToast(context,
          message: "Medication updated successfully.",
          color: Vx.green500,
          textColor: KWhite);
    } on IsarError catch (e) {
      //log(e.message);
      Navigator.of(context, rootNavigator: true).pop();
      showExceptionAlertDialog(
          context: context, title: "Update Error", exception: e.message);
    }
  }
}

@riverpod
Future<List<Medicmodel>> getMedicines(GetMedicinesRef ref) {
  final c = ref.watch(medControllerProvider);
  return c.getMedicines();
}
