import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kulobal/src/constant/style.dart';
import 'package:kulobal/src/features/medication/ui/medication.dart';
import 'package:kulobal/src/features/profile/ui/editprofile.dart';
import 'package:kulobal/src/features/profile/ui/loyalty.dart';
import 'package:kulobal/src/features/profile/ui/settings.dart';
import 'package:kulobal/src/features/rapidtesting/ui/myrapidtest/mytests.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../constant/text.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  static const String id = "/profile";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          //floating: true,
          centerTitle: false,
          title: Headtext(
            data: "Profile and Settings",
          ),

          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  radius: 19,
                  foregroundImage: AssetImage("assets/icons/Ellipse 45.png"),
                ),
                title: Headtext(data: "Frederick Boltman"),
                subtitle: Maintext(data: "+233 57438 4722", color: KGrey),
              ).px20()),
        ),
        VStack([
          listMethodcard(
              action: () => context.push(EditProfile.id),
              icon: "assets/icons/profile-circle.svg",
              title: "Personal Details"),
          listMethodcard(
              action: () => context.push(MyTests.id),
              icon: "assets/icons/rtest.svg",
              title: "Rapid Test"),
          listMethodcard(
              action: () => context.push(Medication.id),
              icon: "assets/icons/drug.svg",
              title: "My Medications"),
          listMethodcard(
              action: () => context.push(Medication.id),
              icon: "assets/icons/vitals.svg",
              title: "My Vitals"),
          listMethodcard(
              action: () => context.push(LoyaltyProgram.id),
              icon: "assets/icons/loyalty.svg",
              title: "Loyalty Program"),
          listMethodcard(
              action: () => context.push(Settings.id),
              icon: "assets/icons/settings.svg",
              title: "Settings"),
        ]).px24().sliverToBoxAdapter()
      ],
    );
  }

  ListTile listMethodcard(
      {required String title,
      required String icon,
      required VoidCallback action}) {
    return ListTile(
      onTap: action,
      contentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset(icon, width: 25, height: 25),
      title: Labletext(text: title),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 20,
      ),
    );
  }
}
