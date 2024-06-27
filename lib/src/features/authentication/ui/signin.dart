import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:kulobal/src/components/alert_dialogs.dart';
import 'package:kulobal/src/components/regex.dart';
import 'package:kulobal/src/components/textfield.dart';
import 'package:kulobal/src/features/authentication/repo/authctl.dart';
import 'package:kulobal/src/features/render/ui/render.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../components/buttons.dart';
import '../../../constant/style.dart';
import '../../../constant/text.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../onboarding/repo/onboard.dart';

class Signin extends ConsumerStatefulWidget {
  const Signin({super.key});
  static const signInname = "/signin";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SigninState();
}

class _SigninState extends ConsumerState<Signin> {
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool readOff = false;
  bool isObscured = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: hpad,
          child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 0.6,
                    height: size.height * 0.15,
                    child: SvgPicture.asset(
                      appLogo[0],
                      height: size.height * 0.15,
                    ),
                  ).centered(),
                  Headtext(data: "Sign in to Kulobal"),
                  15.heightBox,
                  const Labletext(text: "Phone Number"),
                  gapH4,
                  IntlPhoneField(
                    pickerDialogStyle: phonestyle,
                    validator: (value) {
                      if (value == null) {
                        return "You need to enter a valid phone number";
                      } else if (!value.toString().startsWith("0")) {
                        return "number is invalid";
                      }
                      return null;
                    },
                    initialCountryCode: "GH",
                    readOnly: readOff,
                    onChanged: (newValue) => setState(() {
                      phone.text = newValue.completeNumber;
                    }),
                    decoration: InputDecoration(
                      hintStyle: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: KGrey),
                      hintText: "Enter phone number",
                      fillColor: KGrey.withOpacity(0.1),
                      filled: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: KBlack)),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  10.heightBox,
                  const Labletext(text: "Password"),
                  gapH4,
                  TextFormField(
                    controller: password,
                    keyboardType: TextInputType.visiblePassword,
                    readOnly: readOff,
                    obscureText: isObscured,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'password must be provided';
                      } else if (!value.isPasswordvalid()) {
                        return "must contain 1letter, 1number and 8characters ";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        color: KGrey,
                        onPressed: () {
                          setState(() {
                            isObscured = !isObscured;
                          });
                        },
                        icon: isObscured
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                      hintText: "eg. ********",
                      fillColor: KGrey.withOpacity(0.1),
                      filled: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: KBlack)),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  gapH12,
                  HStack(alignment: MainAxisAlignment.end, [
                    const Spacer(),
                    InkWell(
                      onTap: () => showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: KWhite,
                          isDismissible: false,
                          enableDrag: false,
                          builder: (context) =>
                              //  ResetPassword(phone: "+233557466718")
                              SendResetRequest(size: size)),
                      child: Underlinetext(
                        color: Colors.blue,
                        data: "Forgot password?",
                      ),
                    )
                  ]),
                  30.heightBox,
                  ListenableBuilder(
                      listenable: Listenable.merge([phone, password]),
                      builder: (context, child) {
                        bool done =
                            phone.text.isNotEmpty && password.text.isNotEmpty;
                        return MainButton(
                            action: () async {
                              final controller =
                                  ref.watch(authControllerProvider);

                              bool validate = formkey.currentState!.validate();

                              if (validate && done) {
                                final value = await controller.login(context,
                                    phonenumber: "0557466718",
                                    password: password.text);
                                if (value) {
                                  await ref
                                      .watch(onBoardRepoProvider)
                                      .requireValue
                                      .setSignin();
                                  context.go(KulobalRender.renderName);
                                }
                                context.go(KulobalRender.renderName);
                              } else {
                                showExceptionAlertDialog(
                                    context: context,
                                    title: "Sign in error",
                                    exception:
                                        "Complete all fields to continue");
                              }
                            },
                            text: "Sign in",
                            color: done ? KPrimary : KGrey);
                      }),
                  gapH16,
                  HStack(alignment: MainAxisAlignment.center, [
                    Maintext(data: "Not yet a user?"),
                    gapW8,
                    GestureDetector(
                      onTap: () => context.go("/signup"),
                      child: Underlinetext(
                        data: "Sign up",
                        color: Colors.blue,
                      ),
                    )
                  ]).centered(),
                  gapH32
                ],
              )),
        ),
      ),
    );
  }
}

class SendResetRequest extends ConsumerStatefulWidget {
  const SendResetRequest({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  ConsumerState<SendResetRequest> createState() => _SendResetRequestState();
}

class _SendResetRequestState extends ConsumerState<SendResetRequest> {
  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width,
      height: widget.size.height * 0.4,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                BackButton(),
                Spacer(),
                Headertext(text: "Send Password Reset Request", color: KBlack),
                Spacer(),
              ],
            ),
            20.heightBox,
            const Labletext(text: "Phone number"),
            5.heightBox,
            IntlPhoneField(
              controller: phone,
              pickerDialogStyle: phonestyle,
              validator: (value) {
                if (value == null) {
                  return "You need to enter a valid phone number";
                } else if (!value.toString().startsWith("0")) {
                  return "number is invalid";
                }
                return null;
              },
              initialCountryCode: "GH",
              decoration: InputDecoration(
                hintStyle: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: KGrey),
                hintText: "Enter phone number",
                fillColor: KGrey.withOpacity(0.1),
                filled: true,
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: KBlack)),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
            ),
            15.heightBox,
            ListenableBuilder(
                listenable: phone,
                builder: (context, child) => MainButton(
                    color: phone.text.isNotEmpty ? KPrimary : KGrey,
                    action: phone.text.isNotEmpty
                        ? () async {
                            final controller =
                                ref.watch(authControllerProvider);
                            final value = await controller.forgotPassword(
                                context,
                                phonenumber: phone.text);
                            if (value) {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) =>
                                      ResetPassword(phone: phone.text));
                            }
                          }
                        : null,
                    text: "Send request"))
          ],
        ),
      ),
    );
  }
}

class ResetPassword extends ConsumerStatefulWidget {
  const ResetPassword({super.key, required this.phone});
  final String phone;

  @override
  ConsumerState<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends ConsumerState<ResetPassword> {
  TextEditingController smsCode = TextEditingController();
  TextEditingController password = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width,
      height: size.height * 0.55,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                BackButton(),
                Spacer(),
                Headertext(text: "Reset Password", color: KBlack),
                Spacer(),
              ],
            ),
            20.heightBox,
            const Labletext(text: "New Password"),
            5.heightBox,
            TextFormField(
              controller: password,
              keyboardType: TextInputType.visiblePassword,
              obscureText: isObscured,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'password must be provided';
                } else if (!value.isPasswordvalid()) {
                  return "must contain 1letter, 1number and 8characters ";
                }
                return null;
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  color: KGrey,
                  onPressed: () {
                    setState(() {
                      isObscured = !isObscured;
                    });
                  },
                  icon: isObscured
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                ),
                hintText: "eg. ********",
                fillColor: KGrey.withOpacity(0.1),
                filled: true,
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: KBlack)),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
            ),
            20.heightBox,
            Text(
              "Enter the code we sent to ${widget.phone}",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: KBlack,
                  ),
            ),
            gapH12,
            PinCodeTextField(
              appContext: context,
              pastedTextStyle: const TextStyle(
                color: KPrimary,
                fontWeight: FontWeight.bold,
              ),
              length: 6,
              animationType: AnimationType.fade,
              validator: (v) {
                if (v!.length < 6) {
                  return "Code must be 6 characters long";
                }
                return null;
              },
              pinTheme: PinTheme(
                  inactiveFillColor: KGrey.withOpacity(0.2),
                  activeBorderWidth: 1,
                  inactiveColor: KGrey,
                  borderWidth: 1,
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 45,
                  fieldWidth: 40,
                  selectedColor: KPrimary,
                  activeColor: KPrimary),
              cursorColor: Colors.black,
              errorTextSpace: 25,
              errorTextMargin: hpad,
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: false,
              errorAnimationController: errorController,
              controller: smsCode,
              keyboardType: TextInputType.number,
              boxShadows: const [
                BoxShadow(
                  offset: Offset(0, 1),
                  color: Colors.black12,
                  blurRadius: 5,
                )
              ],
              onCompleted: (v) {
                debugPrint("Completed");
              },
              onChanged: (value) {
                debugPrint(value);
                currentText = value;
                if (value.length == 6) {
                  FocusScope.of(context).unfocus();
                }
              },
              beforeTextPaste: (text) {
                debugPrint("Allowing to paste $text");
                return true;
              },
            ),
            10.heightBox,
            ListenableBuilder(
                listenable: Listenable.merge([password, smsCode]),
                builder: (context, child) {
                  bool validate = password.text.isNotEmpty &&
                      smsCode.text.isNotEmpty &&
                      smsCode.text.length == 6;
                  return MainButton(
                      color: validate ? KPrimary : KGrey,
                      action: validate
                          ? () async {
                              bool value = await ref
                                  .watch(authControllerProvider)
                                  .resetPassword(context,
                                      phonenumber: widget.phone,
                                      newpassword: password.text,
                                      otp: smsCode.text);
                              if (value) {}
                            }
                          : null,
                      text: "Reset Password");
                })
          ],
        ),
      ),
    );
  }
}
