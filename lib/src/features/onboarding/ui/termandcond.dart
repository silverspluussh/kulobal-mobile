import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kulobal/src/constant/style.dart';
import 'package:kulobal/src/constant/text.dart';
import 'package:velocity_x/velocity_x.dart';

class TandCs extends ConsumerWidget {
  const TandCs({super.key});
  static const tandC = "/termsandconditions";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: KWhite,
          elevation: 0,
          leading: const BackButton(
            color: KBlack,
          ),
        ),
        body: Container(
          color: KWhite,
          height: size.height,
          width: size.width,
          child: VStack(
              alignment: MainAxisAlignment.start,
              crossAlignment: CrossAxisAlignment.start,
              [
                Headertext(text: "Terms and Conditions", color: KBlack),
                gapH12,
                Labletext(
                    text:
                        "Please kindly read our Terms and Conditions carefully."),
                gapH32,
                Maintext(
                    data:
                        "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?",
                    color: KBlack,
                    align: TextAlign.start)
              ]).px24(),
        ));
  }
}
