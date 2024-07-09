import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kulobal/src/components/appbar.dart';
import 'package:kulobal/src/components/buttons.dart';
import 'package:kulobal/src/constant/style.dart';
import 'package:kulobal/src/constant/text.dart';
import 'package:velocity_x/velocity_x.dart';

class LoyaltyProgram extends ConsumerStatefulWidget {
  const LoyaltyProgram({super.key});
  static const String id = "/loyalty";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoyaltyProgramState();
}

class _LoyaltyProgramState extends ConsumerState<LoyaltyProgram> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: CustomBar(title: "Loyalty Program"),
      body: Padding(
        padding: hpad,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Labletext(text: "Share referral code to earn points"),
              Wrap(
                direction: Axis.horizontal,
                children: [
                  InkWell(child: Maintext(data: "Terms", color: KPrimary)),
                  gapW8,
                  Maintext(data: "and"),
                  gapW8,
                  InkWell(child: Maintext(data: "Conditions", color: KPrimary)),
                  gapW8,
                  Maintext(data: "apply.")
                ],
              ),
              gapH20,
              Card(
                child: SizedBox(
                  width: size.width * 0.9,
                  height: 150,
                  child: ListTile(
                    leading: VStack(alignment: MainAxisAlignment.center, [
                      const Labletext(text: "Points Earned"),
                      10.heightBox,
                      Headtext(
                        data: "0.00",
                      )
                    ]),
                    trailing: VStack(alignment: MainAxisAlignment.center, [
                      const Labletext(text: "Referral Code"),
                      10.heightBox,
                      Headtext(
                        data: "#1239832",
                        color: KPrimary,
                      )
                    ]),
                  ).centered(),
                ),
              ),
              20.heightBox,
              const Divider(
                color: KGrey,
                thickness: 5,
              ),
              20.heightBox,
              Card(
                surfaceTintColor: KWhite,
                color: KWhite,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(width: 0.5, color: KGrey)),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: SvgPicture.asset("assets/icons/loyal.svg",
                      height: 30, width: 30),
                  title: const Labletext(text: "Redeem Points"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 20),
                  onTap: () => loyaltymodal(context),
                ).px8(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> loyaltymodal(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: KWhite,
      builder: (context) {
        return Container(
          height: MediaQuery.sizeOf(context).height * 0.3,
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: VStack(axisSize: MainAxisSize.min, [
            const Labletext(text: "Redeem Points"),
            10.heightBox,
            TextFormField(
              // controller: phone,
              decoration: const InputDecoration(
                hintText: "#00 0000",
                isDense: true,
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              ),
              keyboardType: TextInputType.text,
            ),
            30.heightBox,
            MainButton(action: () {}, text: "Redeem Points"),
            10.heightBox
          ]).px16(),
        );
      },
    );
  }
}
