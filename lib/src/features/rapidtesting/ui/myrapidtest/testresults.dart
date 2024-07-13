// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:kulobal/src/components/appbar.dart';
import 'package:kulobal/src/constant/style.dart';
import 'package:kulobal/src/constant/text.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../components/alert_dialogs.dart';

class TestResults extends ConsumerStatefulWidget {
  const TestResults(this.title, {super.key});
  static const String id = "/testresults";
  final String title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TestResultsState();
}

class _TestResultsState extends ConsumerState<TestResults> {
  getdelay() async => await Future.delayed(2.seconds);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomBar(title: widget.title),
      body: RefreshIndicator.adaptive(
          child: SafeArea(
            bottom: true,
            child: FutureBuilder(
                future: getdelay(),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return ListView.separated(
                        physics: const ClampingScrollPhysics(),

                        itemBuilder: ((context, index) => Container(
                              height: size.height * 0.2,
                              width: size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              decoration: BoxDecoration(
                                  color: KPrimary,
                                  borderRadius: BorderRadius.circular(20)),
                            ).shimmer(
                                duration: 1.seconds,
                                primaryColor: Vx.gray200,

                                secondaryColor: KGrey)),
                        separatorBuilder: ((context, index) => 10.heightBox),
                        itemCount: 8);
                  }

                  return snap.data == null
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/logo/empty.png"),
                            gapH16,
                            Headtext(
                              data: "No results have been sent for this test.",
                            ),
                          ],
                        ))
                      : ListView.separated(
                    physics: const ClampingScrollPhysics(),
                          padding: hpad,
                          itemBuilder: ((context, index) => Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: GradientBoxBorder(
                                    gradient: LinearGradient(colors: [
                                      colorList[Random().nextInt(7)],
                                      colorList[Random().nextInt(6)]
                                    ]),
                                    width: 2,
                                  ),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Stack(
                                  children: [
                                    Column(
                                      children: [
                                        ListTile(
                                          title: HStack(
                                              alignment:
                                                  MainAxisAlignment.start,
                                              [
                                                const Icon(Icons.calendar_month,
                                                    size: 15),
                                                5.widthBox,
                                                Maintext(
                                                    data: "March 20, 2024.")
                                              ]),
                                          subtitle: HStack(
                                              alignment:
                                                  MainAxisAlignment.start,
                                              [
                                                const Icon(Icons.punch_clock,
                                                    size: 15),
                                                5.widthBox,
                                                Maintext(
                                                  data: "23:40 pm",
                                                )
                                              ]),
                                        ),
                                        _resultsTile("Indicator ",
                                            "This is the indicator of the rapid test results"),
                                        _resultsTile(
                                            "Lab name", "Dataleap pharmacy"),
                                        _resultsTile("Test results", "value"),
                                        _resultsTile("Amount", "GHS 260.00"),
                                        Row(
                                          children: [
                                            Maintext(
                                              data: "Description",
                                              fontsize: 13,
                                            ),
                                            Spacer(),
                                            InkWell(
                                              onTap: () {},
                                              child: Underlinetext(
                                                data: "View full description",
                                                weight: FontWeight.w600,
                                                color: KPrimary,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: PopupMenuButton(
                                        itemBuilder: (context) => [
                                          PopupMenuItem(
                                              onTap: () {},
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .file_download_outlined,
                                                    color: Vx.green800,
                                                  ),
                                                  5.widthBox,
                                                  Maintext(data: "Download"),
                                                ],
                                              )),
                                          PopupMenuItem(
                                              onTap: () => showAlertDialog(
                                                  context: context,
                                                  cancelActionText: "Cancel",
                                                  defaultActionText: "Delete",
                                                  content:
                                                      "Confirm delete of results. You will lose it permanently?",
                                                  title: "Delete test results"),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.delete_outline,
                                                      color: KRed),
                                                  5.widthBox,
                                                  Maintext(data: "Delete")
                                                ],
                                              )),
                                        ],
                                        child: Icon(Icons.more_horiz),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          separatorBuilder: ((context, index) => 10.heightBox),
                          itemCount: 3);
                }),
          ),
          onRefresh: () async {}),
    );
  }

  _resultsTile(String? label, String? value) {
    return Row(
      children: [
        Maintext(
          data: label ?? "Date time",
          fontsize: 13,
        ),
        Spacer(),
        Expanded(
          child: Maintext(
            data: value ?? "something else man",
            weight: FontWeight.w600,
          ),
        )
      ],
    ).py8();
  }
}
