// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_result

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kulobal/src/features/medication/model/medication.dart' as model;
import 'package:kulobal/src/components/buttons.dart';
import 'package:kulobal/src/components/textfield.dart';
import 'package:kulobal/src/constant/style.dart';
import 'package:kulobal/src/features/medication/repo/medicationcontroller.dart';
import 'package:kulobal/src/features/medication/repo/medicationrepo.dart';
import 'package:kulobal/src/features/medication/ui/medicationinfo.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../components/appbar.dart';
import '../../../constant/text.dart';

class Medication extends ConsumerStatefulWidget {
  const Medication({super.key});
  static const String id = '/medication';

  @override
  ConsumerState<Medication> createState() => _MedicationState();
}

class _MedicationState extends ConsumerState<Medication> {
  TextEditingController medicine = TextEditingController();
  TextEditingController strength = TextEditingController();
  TextEditingController dosage = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController instructions = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: CustomBar(title: "Medications"),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: KWhite,
          isDismissible: false,
          enableDrag: false,
          builder: (context) {
            return AddMedication(
              size: size,
              age: age,
              dosage: dosage,
              medicine: medicine,
              instructions: instructions,
              strenght: strength,
              action: () async {
                final med = model.Medicmodel()
                  ..age = age.text
                  ..dosage = dosage.text
                  ..instructions = instructions.text
                  ..medicine = medicine.text
                  ..strength = strength.text;

                // ignore: unused_local_variable
                final value = await ref
                    .watch(medControllerProvider)
                    .addMedicine(context, med);
                ref.refresh(getMedicinesProvider);

                context.pop();
              },
            );
          },
        ),
        tooltip: 'Add new medication',
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async => ref.refresh(getMedicinesProvider),
        child: Padding(
            padding: hpad,
            child: ref.watch(getMedicinesProvider).maybeWhen(orElse: () {
              return ListView.separated(
                  itemBuilder: ((context, index) => Container(
                        height: 50,
                        width: size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                            color: KPrimary,
                            borderRadius: BorderRadius.circular(10)),
                      ).shimmer(
                          duration: 1.seconds,
                          primaryColor: Vx.gray200,
                          secondaryColor: KGrey)),
                  separatorBuilder: ((context, index) => 5.heightBox),
                  itemCount: 10);
            }, data: (meds) {
              if (meds.isEmpty) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/logo/empty.png"),
                    Headtext(
                      data: "No medications added.",
                    ),
                    gapH32
                  ],
                ));
              } else {
                return ListView.separated(
                    separatorBuilder: (context, index) =>
                        const Divider(height: 5),
                    itemCount: meds.length,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        onTap: () =>
                            context.push(Medicationinfo.id, extra: meds[index]),
                        leading: Maintext(
                          data: "${index + 1}.",
                        ),
                        title: Headtext(
                            data: meds[index].medicine?.capitalized,
                            fontsize: 14),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 12),
                      );
                    }));
              }
            })),
      ),
    );
  }
}

// ignore: must_be_immutable
class AddMedication extends StatefulWidget {
  AddMedication({
    super.key,
    required this.size,
    this.medicine,
    this.strenght,
    this.dosage,
    this.age,
    this.action,
    this.instructions,
  });
  VoidCallback? action;
  TextEditingController? medicine;
  TextEditingController? strenght;
  TextEditingController? dosage;
  TextEditingController? age;
  TextEditingController? instructions;

  final Size size;

  @override
  State<AddMedication> createState() => _AddMedicationState();
}

class _AddMedicationState extends State<AddMedication> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width,
      height: widget.size.height * 0.65,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                BackButton(),
                const Spacer(),
                Headertext(text: "Add Medication", color: KBlack),
                const Spacer(),
              ],
            ),
            20.heightBox,
            CustomTextField(
                ctx: context,
                hint: "Name of medicine",
                controller: widget.medicine,
                inputType: TextInputType.name),
            15.heightBox,
            CustomTextField(
                ctx: context,
                controller: widget.strenght,
                hint: "Strenght of medicine",
                trailing: DropdownButton(
                    value: "mg",
                    items: ["mg", "ml"]
                        .map((e) => DropdownMenuItem(
                            value: e, child: Maintext(data: e)))
                        .toList(),
                    onChanged: (e) {}),
                inputType: TextInputType.number),
            15.heightBox,
            DropdownButtonFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: KGrey.withOpacity(0.1),
                  isDense: true,
                  border: const OutlineInputBorder(),
                  hintText: "Dosage form",
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                ),
                items: [
                  "tablet",
                  "capsule",
                  "liquid",
                  "lotion",
                  'syringe',
                  "spray"
                ]
                    .map((e) => DropdownMenuItem(
                        value: e,
                        child: Maintext(
                          data: e,
                        )))
                    .toList(),
                onChanged: (d) {
                  setState(() {
                    widget.dosage!.text = d!;
                  });
                }),
            15.heightBox,
            DropdownButtonFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: KGrey.withOpacity(0.1),
                  isDense: true,
                  border: const OutlineInputBorder(),
                  hintText: "Age Group",
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                ),
                items: ageGroups
                    .map((e) => DropdownMenuItem(
                        value: e,
                        child: Maintext(
                          data: e,
                        )))
                    .toList(),
                onChanged: (gg) {
                  setState(() {
                    widget.age!.text = gg!;
                  });
                }),
            15.heightBox,
            CustomTextField(
              ctx: context,
              hint: "Dosage instructions",
              controller: widget.instructions,
              inputType: TextInputType.number,
              trailing: DropdownButton(
                  value: "tablets daily",
                  icon: SizedBox(
                    width: 10,
                  ),
                  items: [
                    DropdownMenuItem(
                      value: "tablets daily",
                      child: Maintext(
                        data: "tablets daily",
                      ),
                    )
                  ],
                  onChanged: (v) {}),
            ),
            20.heightBox,
            MainButton(action: widget.action, text: "Add medication")
          ],
        ),
      ),
    );
  }

  List<String> ageGroups = [
    "Infants (0-2 years)",
    "Children (3-12 years)",
    "Adolescents (13-17 years)",
    "Adults (18-64 years)",
    "Older Adults (65+ years)"
  ];
}
