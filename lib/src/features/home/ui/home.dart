import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kulobal/src/components/appbar.dart';
import 'package:kulobal/src/constant/style.dart';
import 'package:kulobal/src/constant/text.dart';
import 'package:kulobal/src/features/medication/ui/medication.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../vitals/ui/vitals.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: hpad,
        child: CustomScrollView(slivers: [
          SliverPersistentHeader(
              pinned: true,
              delegate: CustomHeader(
                  widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Headtext(data: "Welcome", color: KBlack),
                  Maintext(
                      data: "Your  favourite pharmacy now online.",
                      color: KGrey),
                  gapH20,
                  const SearchWidget()
                ],
              ))),
          SliverGrid.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            children: [
              VitalsWidgets(
                image: "assets/icons/vitals.svg",
                action: () => context.push(Vitals.id),
              ),
              VitalsWidgets(image: "assets/icons/heart-59.svg")
            ],
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            30.heightBox,
            Headtext(data: "Actions"),
            10.heightBox,
            ActionsWidget(
              action: () => context.push(Vitals.id),
              image: "assets/icons/rtest.svg",
              subtitle: "View videos on all tests",
              title: "Rapid Test",
            ),
            gapH12,
            ActionsWidget(
              action: () => context.push(Medication.id),
              image: "assets/icons/drug.svg",
              subtitle: "View all medication records",
              title: "Medication",
            ),
            gapH12,
            ActionsWidget(
              action: () {},
              image: "assets/icons/vitals.svg",
              subtitle: "Request to test your allergies",
              title: "Lab Test Request",
            )
          ]))
        ]),
      ),
    );
  }
}

class ActionsWidget extends StatelessWidget {
  const ActionsWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.action,
  });
  final String title;
  final String subtitle;
  final String image;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Vx.gray100),
      child: ListTile(
        onTap: action,
        leading: OutlinedIxcon(image: image),
        title: Headtext(data: title, fontsize: 15, color: KBlack),
        subtitle: Maintext(
          data: subtitle,
          color: Vx.gray600,
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 15),
      ),
    );
  }
}

class VitalsWidgets extends StatelessWidget {
  const VitalsWidgets({super.key, this.action, this.image});
  final String? image;
  final VoidCallback? action;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Vx.gray100,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlinedIxcon(image: image ?? "assets/icons/vitals.svg"),
          ListTile(
              onTap: action ?? () {},
              title: Maintext(data: "Vital records"),
              contentPadding: EdgeInsets.zero,
              subtitle: Headtext(
                data: "Blood Pressure",
              ))
        ],
      ),
    );
  }
}

class OutlinedIxcon extends StatelessWidget {
  const OutlinedIxcon({
    this.image,
    super.key,
  });
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(color: KWhite, shape: BoxShape.circle),
      child: Center(
        child: SvgPicture.asset(image ?? "assets/icons/filter-134.svg",
            colorFilter: const ColorFilter.mode(KPrimary, BlendMode.srcIn)),
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
          prefixIcon: SvgPicture.asset("assets/icons/search-155.svg",
                  height: 15,
                  width: 25,
                  colorFilter: const ColorFilter.mode(KGrey, BlendMode.srcIn))
              .p12(),
          isDense: true,
          suffixIcon: SvgPicture.asset("assets/icons/filter-134.svg",
                  height: 15,
                  width: 25,
                  colorFilter: const ColorFilter.mode(KGrey, BlendMode.srcIn))
              .p12(),
          hintStyle: const TextStyle(color: KGrey, fontFamily: "Eu"),
          hintText: "search kulobal features",
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(width: 1, color: KGrey))),
    );
  }
}
