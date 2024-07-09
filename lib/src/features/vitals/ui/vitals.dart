import 'package:flutter/material.dart';

import '../../../components/appbar.dart';

class Vitals extends StatelessWidget {
  const Vitals({super.key});
  static const String id = "/vitals";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: CustomBar(title: "Vitals"),

    );
  }
}