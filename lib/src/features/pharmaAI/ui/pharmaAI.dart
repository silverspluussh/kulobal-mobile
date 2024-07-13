import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kulobal/src/components/appbar.dart';
import 'package:kulobal/src/components/buttons.dart';
import 'package:kulobal/src/components/textfield.dart';
import 'package:kulobal/src/constant/style.dart';
import 'package:kulobal/src/constant/text.dart';
import 'package:kulobal/src/features/pharmaAI/ui/chatpage.dart';
import 'package:velocity_x/velocity_x.dart';

class PharmaAI extends StatefulWidget {
  const PharmaAI({super.key});
  static const String id = "/pharmaAI";

  @override
  State<PharmaAI> createState() => _PharmaAIState();
}

class _PharmaAIState extends State<PharmaAI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBar(
        leading: BackButton(color: KBlack),
        title: "Pharma AI Help Bot",
      ),
      body: Padding(
        padding: hpadx,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("assets/logo/covid.png"),
                  ),
                  gapW12,
                  Headtext(data: "Pharma AI", fontsize: 24, color: KBlack)
                ],
              ),
              gapH8,
              Wrap(
                children: [
                  Maintext(
                    data: "Direct pharmacy-based answers to medical questions.",

                  ),
                  Underlinetext(
                      data: "Read terms and conditions", color: Colors.blue)
                ],
              ),
              gapH12,
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(width: 0.5, color: KRed)),
                child: Maintext(
                  color: KRed,
                  data:
                      "Pharma AI is not a substitute for pharmacy/Medical professionals. Kindly seek the opinions of health professional when your condition is severe.",
                ).p8(),
              ),
              gapH20,
              CustomTextField(
                  ctx: context,
                  hint: "Type a health question or upload an image",
                  inputType: TextInputType.text),
              gapH8,
              (45 > 32)
                  ? const SizedBox.shrink()
                  : Image.asset("assets/logo/glucose.png"),
              Row(
                children: [
                  SizedBox(
                      width: 200,
                      child: MainButton(action: () => context.push(Chat.id), text: "Generate")),
                  gapW4,
                  IconButton(
                      tooltip: "upload file",
                      onPressed: () {},
                      icon: Icon(Icons.upload_file))
                ],
              ),
              gapH32,
              Underlinetext(data: "Suggested prompts:", color: KPrimary),
              gapH12,
              Wrap(
                children: [
                  ...[
                    "Is fibroid curable",
                    "What is a proper diet for gym",
                    "What is 75 hard challenge",
                    "What are calories?",
                    "What rapid tests can I take at home?"
                  ].map((r) => Chip(
                          label: Maintext(
                        data: r,
                      )).px4())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
