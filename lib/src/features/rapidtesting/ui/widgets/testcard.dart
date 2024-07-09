import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:kulobal/src/constant/style.dart';
import 'package:kulobal/src/constant/text.dart';
import 'package:velocity_x/velocity_x.dart';

class TestCard extends ConsumerWidget {
  const TestCard(
      {super.key, this.image, required this.action, this.body, this.title});
  final String? image;
  final String? title;
  final String? body;
  final Function() action;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
          border: const GradientBoxBorder(
              gradient: LinearGradient(colors: [Vx.indigo800, KPrimary]),
              width: 1.2),
          borderRadius: BorderRadius.circular(15)),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        onTap: action,
        contentPadding: EdgeInsets.zero,
        leading: Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(image ?? ""), fit: BoxFit.fill)),
        ),
        title: Maintext(
          data: title ?? "Rapid test title",
          fontsize: 15,
          weight: FontWeight.w600,
          color: KBlack,
        ),
        subtitle: Maintext(
          data: body ?? "Rapid test body",
          fontsize: 14,
          color: KBlack,
        ),
      ),
    );
  }
}
