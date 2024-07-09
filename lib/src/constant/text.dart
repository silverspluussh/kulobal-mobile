import 'package:flutter/material.dart';
import 'style.dart';

class Headertext extends StatelessWidget {
  const Headertext({super.key, required this.text, required this.color});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: Theme.of(context)
            .textTheme
            .labelLarge!
            .copyWith(color: color, fontFamily: fontName[2]));
  }
}

class Labletext extends StatelessWidget {
  final String text;

  const Labletext({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .labelLarge!
          .copyWith(fontFamily: fontName[1]),
    );
  }
}

class Underlinetext extends Text {
  Underlinetext({
    Key? key,
    String? data,
    Color? color,
    FontWeight? weight,
    double? fontsize,
  }) : super(
            key: key,
            data!,
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontFamily: fontName.first,
                fontSize: fontsize ?? 14,
                decorationColor: color,
                color: color,
                fontWeight: weight));
}

class Headtext extends Text {
  Headtext({
    Key? key,
    String? data,
    double? fontsize,
    Color? color,
  }) : super(
            key: key,
            data!,
            style: TextStyle(
            //  fontWeight: FontWeight.w600,
              fontSize: fontsize ?? 18,
              fontFamily: fontName[1],
              color: color ?? KBlack,
            ));
}

class Maintext extends Text {
  Maintext(
      {Key? key,
      String? data,
      TextAlign? align,
      double? fontsize,
      Color? color,
      FontWeight? weight})
      : super(
            key: key,
            data!,
            textAlign: align ?? TextAlign.start,
            style: TextStyle(
                fontSize: fontsize ?? 14,
                fontFamily: fontName[0],
                color: color ?? KBlack,
                fontWeight: weight ?? FontWeight.w300));
}

class Fieldlabel extends StatelessWidget {
  final String text;

  const Fieldlabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: KGrey,
            ));
  }
}

class Ltext extends StatelessWidget {
  final String text;

  const Ltext({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(fontFamily: 'Eu', fontWeight: FontWeight.w400),
    );
  }
}

class Buttontext extends StatelessWidget {
  final String text;

  const Buttontext({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.labelMedium);
  }
}

class Normaltext extends StatelessWidget {
  final String text;

  const Normaltext({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.bodyMedium);
  }
}

// constant text

const splashheadline = 'Powered by DataLeap Technologies Ltd';

const tandc = "Terms & Conditions";
