import 'package:flutter/material.dart';
import 'package:kulobal/src/components/appbar.dart';
import 'package:kulobal/src/components/buttons.dart';
import 'package:kulobal/src/components/textfield.dart';
import 'package:kulobal/src/constant/style.dart';
import 'package:kulobal/src/constant/text.dart';
import 'package:velocity_x/velocity_x.dart';

class Labrequest extends StatefulWidget {
  const Labrequest({super.key});
  static const String id = "/labrequest";

  @override
  State<Labrequest> createState() => _LabrequestState();
}

class _LabrequestState extends State<Labrequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBar(
        leading: const BackButton(color: KBlack),
        title: "Make Lab Request",
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.history, size: 25, color: KPrimary))
        ],
      ),
      body: Padding(
        padding: hpadx,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Labletext(text: "Full name"),
              5.heightBox,
              CustomTextField(
                  ctx: context,
                  hint: "Your Full Name",
                  // controller: widget.medicine,
                  inputType: TextInputType.name),
              20.heightBox,
              const Labletext(text: "Location"),
              5.heightBox,
              CustomTextField(
                  ctx: context,
                  // controller: widget.strenght,
                  hint: "Enter your location",
                  inputType: TextInputType.streetAddress),
              //

              20.heightBox,
              const Labletext(text: "Lab Test Type"),
              5.heightBox,
              CustomTextField(
                  ctx: context,
                  //   controller: widget.strenght,
                  hint: "select test type",
                  readOnly: true,
                  trailing: DropdownButton(
                      // value: "mg",
                      items: ["mg", "ml"]
                          .map((e) => DropdownMenuItem(
                              value: e, child: Maintext(data: e)))
                          .toList(),
                      onChanged: (e) {}),
                  inputType: TextInputType.number),
              //

              20.heightBox,
              const Labletext(text: "Comments"),
              5.heightBox,
              CustomTextField(
                  ctx: context,
                  maxlines: 4,
                  hint: "Enter any other comments here...",
                  // controller: widget.medicine,
                  inputType: TextInputType.name),
              30.heightBox,
              MainButton(action: () {}, text: "Make request")
            ],
          ),
        ),
      ),
    );
  }
}
