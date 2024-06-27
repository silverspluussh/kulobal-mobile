import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constant/style.dart';
import '../constant/text.dart';

class CustomBar extends AppBar {
  CustomBar(
      {Key? key,
      String? title,
      bool? autolead,
      List<Widget>? actions,
      Widget? leading})
      : super(
            key: key,
            elevation: 0,
            actions: actions,
            leading: leading ?? const BackButton(color: KBlack),
            automaticallyImplyLeading: autolead ?? false,
            title: Headtext(data: title ?? "", color: KBlack));
}

// ignore: must_be_immutable
class LargeAppbar extends SliverPersistentHeader {
  List<Widget>? actions;
  LargeAppbar({Key? key, this.actions})
      : super(key: key, delegate: Header(actions: actions));
}

class Header extends SliverPersistentHeaderDelegate {
  List<Widget>? actions;
  Header({Key? key, this.actions});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = shrinkOffset / maxExtent;

    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedOpacity(opacity: progress, duration: 150.ms),
          AnimatedOpacity(
            opacity: 1 - progress,
            duration: 150.ms,
            child: Image.asset(
              "assets/logo/t2.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Row(children: [
            const Chip(
                padding: EdgeInsets.zero,
                backgroundColor: KWhite,
                side: BorderSide.none,
                shape: CircleBorder(side: BorderSide.none),
                label: BackButton(color: KBlack)),
            const Spacer(),
            ...actions ?? []
          ]),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 250;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
