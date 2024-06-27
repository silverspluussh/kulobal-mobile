// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:kulobal/src/components/alert_dialogs.dart';
import 'package:kulobal/src/components/appbar.dart';
import 'package:kulobal/src/components/buttons.dart';
import 'package:kulobal/src/components/textfield.dart';
import 'package:kulobal/src/constant/style.dart';
import 'package:kulobal/src/constant/text.dart';
import 'package:kulobal/src/features/medication/model/medication.dart';
import 'package:kulobal/src/features/medication/model/reminders.dart';
import 'package:kulobal/src/features/medication/repo/medicationcontroller.dart';
import 'package:kulobal/src/features/medication/repo/medicationrepo.dart';
import 'package:kulobal/src/features/medication/repo/remindersrepo.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../notification/repo/notification.dart';

class Medicationinfo extends ConsumerStatefulWidget {
  const Medicationinfo({super.key, required this.medication});
  final Medication medication;
  static const String id = "/info";

  @override
  ConsumerState<Medicationinfo> createState() => _MedicationinfoState();
}

class _MedicationinfoState extends ConsumerState<Medicationinfo> {
  Notifications n = Notifications();

  List<ActiveNotification> active = [];
  List<PendingNotificationRequest> pending = [];

  @override
  void initState() {
    super.initState();
    initAlarms();
  }

  initAlarms() async {
    final a = await n.getActivetAlarm() as List<ActiveNotification>;
    final p = await n.getPendingAlarms() as List<PendingNotificationRequest>;

    setState(() {
      active = a;
      pending = p;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomBar(
        title: widget.medication.medicine?.capitalized,
        actions: [
          IconButton(
              onPressed: () => showAlertDialog(
                  context: context,
                  action: () async {
                    Navigator.of(context).pop(true);
                    await ref
                        .watch(medControllerProvider)
                        .deleteMedicine(context, widget.medication.id);
                    await n.removeAlarm(widget.medication.id);
                    context.pop();
                    ref.refresh(getMedicinesProvider);
                  },
                  title: "Delete medication.",
                  cancelActionText: "cancel",
                  content: "Do you want to delete the medication?",
                  defaultActionText: "delete"),
              icon: Icon(Icons.delete, size: 25, color: KRed))
        ],
      ),
      body: Padding(
        padding: hpad,
        child: CustomScrollView(
          slivers: [
            SliverList.list(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Headertext(text: "Medicine", color: KBlack),
                  trailing: Maintext(
                    data: widget.medication.medicine,
                  ),
                ),
                const Divider(
                  height: 1,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title:
                      Headertext(text: "Strenght of Medicine", color: KBlack),
                  trailing: Maintext(
                    data: widget.medication.strength,
                  ),
                ),
                const Divider(
                  height: 1,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Headertext(text: "Dosage Form", color: KBlack),
                  trailing: Maintext(
                    data: widget.medication.dosage,
                  ),
                ),
                const Divider(
                  height: 1,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Headertext(text: "Age Group", color: KBlack),
                  trailing: Maintext(
                    data: widget.medication.age,
                  ),
                ),
                const Divider(
                  height: 1,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Headertext(text: "Instructions", color: KBlack),
                  subtitle: Maintext(
                    data:
                        "Malafan 100 is the instructions needed for this drug ${widget.medication.medId}",
                  ),
                ),
                25.heightBox,
              ],
            ),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Headtext(data: "Reminders"),
                  const Spacer(),
                  TextButton.icon(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  side: BorderSide(width: 1, color: KGrey),
                                  borderRadius: BorderRadius.circular(20)))),
                      icon: Icon(Icons.add, color: KPrimary),
                      onPressed: () => showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: KWhite,
                          isDismissible: false,
                          enableDrag: false,
                          builder: (context) =>
                              SetAlarm(medication: widget.medication)),
                      label: Maintext(data: "Add", color: KPrimary))
                ],
              ),
            ),
            20.heightBox.sliverToBoxAdapter(),
            ref.watch(getRemindersProvider).maybeWhen(orElse: () {
              return SliverToBoxAdapter(
                child: SizedBox(
                    height: 300,
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Headtext(data: "No reminders set"),
                      ],
                    )),
              );
            }, data: (rems) {
              if (rems.isEmpty) {
                return SliverToBoxAdapter(
                  child: SizedBox(
                      height: 300,
                      width: size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Headtext(data: "No reminders set"),
                        ],
                      )),
                );
              } else {
                return SliverList.separated(
                    itemCount: rems.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: size.width,
                        height: 90,
                        color: KWhite,
                        child: Stack(
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Maintext(
                                      data: rems[index].title,
                                      weight: FontWeight.w600,
                                      fontsize: 14),
                                  3.heightBox,
                                  Row(children: [
                                    Icon(Icons.book, color: KPrimary, size: 18),
                                    5.widthBox,
                                    Maintext(
                                        data: rems[index].note, fontsize: 12),
                                  ]),
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                    leading: Icon(
                                      Icons.alarm_rounded,
                                      size: 25,
                                      color: KRed,
                                    ),
                                    title: Maintext(
                                        weight: FontWeight.w700,
                                        data: rems[index].time),
                                  )
                                ]),
                            Positioned(
                              right: 0,
                              top: 3,
                              child: Column(
                                children: [
                                  PopupMenuButton(
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                          onTap: () => showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              backgroundColor: KWhite,
                                              isDismissible: false,
                                              enableDrag: false,
                                              builder: (context) =>
                                                  EditAlarm(size: size)),
                                          child: Row(
                                            children: [
                                              Icon(Icons.mode_edit_outlined),
                                              5.widthBox,
                                              Maintext(data: "Edit"),
                                            ],
                                          )),
                                      PopupMenuItem(
                                          onTap: () => showAlertDialog(
                                              action: () async {
                                                Notifications n =
                                                    Notifications();
                                                Navigator.of(context)
                                                    .pop(false);
                                                await n.removeAlarm(
                                                    widget.medication.id);

                                                await ref
                                                    .watch(
                                                        remControllerProvider)
                                                    .deleteReminder(
                                                        rems[index].id);
                                                ref.refresh(
                                                    getRemindersProvider);
                                              },
                                              context: context,
                                              cancelActionText: "Cancel",
                                              defaultActionText: "Delete",
                                              content:
                                                  "Confirm delete of reminder?",
                                              title: "Delete reminder"),
                                          child: Row(
                                            children: [
                                              Icon(Icons.delete_outline),
                                              5.widthBox,
                                              Maintext(data: "Delete")
                                            ],
                                          )),
                                    ],
                                    child: Icon(Icons.more_vert),
                                  ),
                                  5.heightBox,
                                  Transform.scale(
                                    scale: 0.7,
                                    child: Switch.adaptive(
                                        value: true, onChanged: (value) {}),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ).scale95();
                    },
                    separatorBuilder: (context, child) => const Divider());
              }
            }),
            20.heightBox.sliverToBoxAdapter()
          ],
        ),
      ),
    );
  }
}

class SetAlarm extends ConsumerStatefulWidget {
  const SetAlarm({
    super.key,
    required this.medication,
  });

  final Medication medication;

  @override
  ConsumerState<SetAlarm> createState() => _SetAlarmState();
}

class _SetAlarmState extends ConsumerState<SetAlarm> {
  TextEditingController time = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();

  @override
  void dispose() {
    time.dispose();
    title.dispose();
    note.dispose();
    super.dispose();
  }

  DateTime? alarmTime;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Container(
      width: size.width,
      height: size.height * 0.6,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                BackButton(),
                Spacer(),
                Headertext(text: "Set Reminder", color: KBlack),
                Spacer(),
              ],
            ),
            20.heightBox,
            const Labletext(text: "Title"),
            5.heightBox,
            CustomTextField(
                controller: title, ctx: context, inputType: TextInputType.name),
            15.heightBox,
            const Labletext(text: "Add note"),
            5.heightBox,
            CustomTextField(
              ctx: context,
              inputType: TextInputType.multiline,
              controller: note,
            ),
            15.heightBox,
            const Labletext(text: "Time"),
            5.heightBox,
            TextFormField(
              controller: time,
              decoration: InputDecoration(
                hintText: TimeOfDay.now().format(context),
                filled: true,
                suffixIcon: IconButton(
                    onPressed: () async {
                      final now = DateTime.now();

                      TimeOfDay? timeOfDay = await showTimePicker(
                          initialEntryMode: TimePickerEntryMode.input,
                          context: context,
                          initialTime: TimeOfDay.now());

                      if (timeOfDay != null) {
                        alarmTime = DateTime(now.year, now.month, now.day,
                            timeOfDay.hour, timeOfDay.minute);
                        time.text = timeOfDay.format(context);
                      }
                    },
                    icon: Icon(Icons.alarm, color: KPrimary, size: 25)),
                fillColor: KGrey.withOpacity(0.1),
                isDense: true,
                border: const OutlineInputBorder(),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              ),
            ),
            10.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Maintext(data: "Repeat"),
                20.widthBox,
                Radio.adaptive(
                    toggleable: true,
                    value: true,
                    groupValue: true,
                    onChanged: (v) {})
              ],
            ),
            15.heightBox,
            MainButton(
                action: () async {
                  Notifications notif = Notifications();
                  bool value = await notif.scheduleReminder(
                      alarmTime: alarmTime, id: widget.medication.id);
                  log(value.toString());
                  if (value) {
                    await ref
                        .watch(remControllerProvider)
                        .addReminder(Reminders()
                          ..medId = widget.medication.medId
                          ..note = note.text
                          ..time = time.text
                          ..title = title.text);
                    ref.refresh(getRemindersProvider);
                    context.pop();
                  }
                },
                text: "Set Reminder")
          ],
        ),
      ),
    );
  }
}

class EditAlarm extends StatefulWidget {
  const EditAlarm({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<EditAlarm> createState() => _EditAlarmState();
}

class _EditAlarmState extends State<EditAlarm> {
  TimeOfDay? timeOfDay = TimeOfDay.now();
  TextEditingController time = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();

  @override
  void dispose() {
    time.dispose();
    title.dispose();
    note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width,
      height: widget.size.height * 0.54,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                BackButton(),
                Spacer(),
                Headertext(text: "Edit Reminder", color: KBlack),
                Spacer(),
              ],
            ),
            20.heightBox,
            const Labletext(text: "Title"),
            5.heightBox,
            CustomTextField(ctx: context, inputType: TextInputType.name),
            15.heightBox,
            const Labletext(text: "Add note"),
            5.heightBox,
            CustomTextField(ctx: context, inputType: TextInputType.multiline),
            15.heightBox,
            const Labletext(text: "Time"),
            5.heightBox,
            TextFormField(
              controller: time,
              decoration: InputDecoration(
                hintText: TimeOfDay.now().format(context),
                filled: true,
                suffixIcon: IconButton(
                    onPressed: () async {
                      timeOfDay = await showTimePicker(
                          initialEntryMode: TimePickerEntryMode.input,
                          context: context,
                          initialTime: timeOfDay ?? TimeOfDay.now());
                      time.text =
                          timeOfDay != null ? timeOfDay!.format(context) : "";
                      print(timeOfDay);
                    },
                    icon: Icon(Icons.alarm, color: KPrimary, size: 25)),
                fillColor: KGrey.withOpacity(0.1),
                isDense: true,
                border: const OutlineInputBorder(),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              ),
            ),
            15.heightBox,
            MainButton(action: () {}, text: "Set Reminder")
          ],
        ),
      ),
    );
  }
}
