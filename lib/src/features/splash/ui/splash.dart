import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../constant/style.dart';
import '../../../constant/text.dart';

class OurSplash extends StatelessWidget {
  const OurSplash({super.key});
  static const String splashName = "/oursplash";
  @override
  Widget build(BuildContext context) {
    return Material(
      color: KPrimary,
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: hpad,
          child: VStack(
              alignment: MainAxisAlignment.center,
              crossAlignment: CrossAxisAlignment.center,
              [
                const Spacer(),
                SvgPicture.asset(appLogo.last)
                    .animate()
                    .fadeIn(duration: 300.ms, delay: 400.ms),
                const Spacer(),
                Maintext(data: splashheadline, color: KWhite)
                    .animate()
                    .fadeIn(duration: 100.ms, delay: 500.ms),
                gapH20
              ]),
        ),
      ),
    );
  }
}
