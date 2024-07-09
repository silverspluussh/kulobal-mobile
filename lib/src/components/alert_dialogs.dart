// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kulobal/src/constant/style.dart';
import 'package:kulobal/src/constant/text.dart';
import 'package:velocity_x/velocity_x.dart';

const kDialogDefaultKey = Key('dialog-default-key');

Future<bool?> showAlertDialog({
  required BuildContext context,
  required String title,
  VoidCallback? action,
  String? content,
  String? cancelActionText,
  String defaultActionText = 'OK',
}) async {
  Size size = MediaQuery.sizeOf(context);
  return showDialog(
    context: context,
    barrierDismissible: cancelActionText != null,
    builder: (context) => AlertDialog.adaptive(
      backgroundColor: KWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Maintext(data: title, weight: FontWeight.w600).centered(),
      content: content != null
          ? Maintext(data: content, align: TextAlign.center)
          : null,
      actionsAlignment: cancelActionText == null
          ? MainAxisAlignment.center
          : MainAxisAlignment.spaceBetween,
      contentPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
      actionsPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      titlePadding: const EdgeInsets.all(10),
      actions: kIsWeb || !Platform.isIOS
          ? <Widget>[
              if (cancelActionText != null)
                TextButton(
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStatePropertyAll(Size(size.width * 0.3, 50)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                      side: const MaterialStatePropertyAll(
                          BorderSide(width: 1, color: KGrey))),
                  child:
                      Maintext(data: cancelActionText, weight: FontWeight.w700),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
              TextButton(
                style: ButtonStyle(
                    minimumSize:
                        MaterialStatePropertyAll(Size(size.width * 0.3, 50)),
                    backgroundColor: const MaterialStatePropertyAll(KRed),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    side: const MaterialStatePropertyAll(
                        BorderSide(width: 1, color: KRed))),
                key: kDialogDefaultKey,
                onPressed: action ?? () {},
                child: Maintext(
                    data: defaultActionText,
                    color: KWhite,
                    weight: FontWeight.w700),
              ),
            ]
          : <Widget>[
              if (cancelActionText != null)
                CupertinoDialogAction(
                  child:
                      Maintext(data: cancelActionText, weight: FontWeight.w700),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              CupertinoDialogAction(
                key: kDialogDefaultKey,
                onPressed: action??() => Navigator.of(context).pop(false),
                child: Maintext(
                    data: defaultActionText,
                    color: KRed,
                    weight: FontWeight.w700),
              ),
            ],
    ),
  );
}

Future<void> showExceptionAlertDialog({
  required BuildContext context,
  required String title,
  required dynamic exception,
}) =>
    showAlertDialog(
      context: context,
      title: title,
      content: exception.toString(),
      defaultActionText: 'OK',
    );

Future<void> showNotImplementedAlertDialog({required BuildContext context}) =>
    showAlertDialog(
      context: context,
      title: 'Not implemented',
    );

Future showLoadingDialog(
        {required BuildContext context,
        required GlobalKey key,
        required String label}) async =>
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => PopScope(
              canPop: false,
              child: AlertDialog.adaptive(
                key: key,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: KWhite,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator.adaptive(
                        strokeWidth: 1.5,
                      ),
                    ),
                    gapW12,
                    Maintext(
                      data: label,
                    ),
                  ],
                ),
              ),
            ));

Future<void> customToast(BuildContext context,
        {String? message,
        VxToastPosition? pos,
        Color? color,
        Color? textColor}) async =>
    VxToast.show(context,
        msg: message ?? "",
        position: pos ?? VxToastPosition.bottom,
        bgColor: color ?? KWhite,
        pdHorizontal: 20,
        pdVertical: 15,
        textSize: 14,
        textColor: textColor ?? KBlack);
