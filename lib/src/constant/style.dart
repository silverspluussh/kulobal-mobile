// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

const KPrimary = Color.fromARGB(255, 0, 177, 124);
const KWhite = Colors.white;
const KYellow = Color.fromARGB(255, 255, 203, 107);
const KBlack = Colors.black;
const KGreen = Color.fromARGB(255, 53, 151, 53);
const KRed = Color.fromARGB(255, 255, 0, 0);
const KGrey = Colors.grey;
const List<Color> colorList = [
  KPrimary,
  Color.fromARGB(255, 182, 70, 5),
  Color.fromARGB(255, 182, 13, 185),
  Color.fromARGB(255, 199, 18, 90),
  Color.fromARGB(255, 8, 163, 91),
  Color.fromARGB(255, 6, 139, 191),
  Vx.indigo800,
  Color.fromARGB(255, 197, 221, 17),
  Vx.rose900
];

class Sizes {
  static const p4 = 4.0;
  static const p8 = 8.0;
  static const p12 = 12.0;
  static const p16 = 16.0;
  static const p20 = 20.0;
  static const p24 = 24.0;
  static const p32 = 32.0;
  static const p48 = 48.0;
  static const p64 = 64.0;
}

/// Constant gap widths
const gapW4 = SizedBox(width: Sizes.p4);
const gapW8 = SizedBox(width: Sizes.p8);
const gapW12 = SizedBox(width: Sizes.p12);
const gapW16 = SizedBox(width: Sizes.p16);
const gapW20 = SizedBox(width: Sizes.p20);
const gapW24 = SizedBox(width: Sizes.p24);
const gapW32 = SizedBox(width: Sizes.p32);
const gapW48 = SizedBox(width: Sizes.p48);
const gapW64 = SizedBox(width: Sizes.p64);

/// Constant gap heights
const gapH4 = SizedBox(height: Sizes.p4);
const gapH8 = SizedBox(height: Sizes.p8);
const gapH12 = SizedBox(height: Sizes.p12);
const gapH16 = SizedBox(height: Sizes.p16);
const gapH20 = SizedBox(height: Sizes.p20);
const gapH24 = SizedBox(height: Sizes.p24);
const gapH32 = SizedBox(height: Sizes.p32);
const gapH48 = SizedBox(height: Sizes.p48);
const gapH64 = SizedBox(height: Sizes.p64);

const navIcons = [
  "assets/icons/home-216.svg",
  "assets/icons/search-155.svg",
  "assets/icons/health-test-1.svg",
  "assets/icons/history-32.svg"
];

const appLogo = [
  "assets/logo/kulobalogo.svg",
  "assets/logo/symbologo.svg",
  "assets/logo/splashlogo.svg"
];

const fontName = ["Eu", "Eumed", "Eubold"];
const hpad = EdgeInsets.symmetric(horizontal: Sizes.p24);
const hpadx = EdgeInsets.symmetric(horizontal: Sizes.p16);

final theme = ThemeData(
  colorSchemeSeed: KPrimary,
  fontFamily: fontName.first,
  unselectedWidgetColor: Colors.grey,
  appBarTheme: const AppBarTheme(
    backgroundColor: KWhite,
    foregroundColor: Colors.white,
    elevation: 2.0,
    centerTitle: true,
  ),
  scaffoldBackgroundColor: KWhite,
  dividerColor: Colors.grey[400],
);
