import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../constant/style.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key, required this.action});

  final Function() action;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        onTap: action,
        readOnly: true,
        decoration: InputDecoration(
            fillColor: Color.fromARGB(31, 71, 70, 70),
            prefixIcon: SvgPicture.asset("assets/icons/search-155.svg",
                    height: 20,
                    width: 20,
                    colorFilter:
                        const ColorFilter.mode(KBlack, BlendMode.srcIn))
                .p12(),
            filled: true,
            hintText: "Search",
            hintStyle: TextStyle(color: KGrey, fontFamily: fontName.first),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(width: 1, color: KGrey)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(width: 0, color: KGrey))),
      ),
    );
  }
}

TextEditingController controller = TextEditingController();

final searchProvider = StateProvider<TextEditingController>((ref) {
  return controller;
});
