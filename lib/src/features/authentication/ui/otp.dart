import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kulobal/src/constant/text.dart';
import 'package:kulobal/src/features/authentication/repo/authctl.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../components/buttons.dart';
import '../../../constant/style.dart';

class OtpPage extends ConsumerStatefulWidget {
  static const otpName = "/otp";
  const OtpPage(this.phone, {super.key});
  final String phone;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OtpfieldState();
}

class _OtpfieldState extends ConsumerState<OtpPage> {
  TextEditingController smsCode = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    final controller = ref.watch(authControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: hpad,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  width: size.width,
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () => context.pop(),
                                icon: const Icon(Icons.close,
                                    size: 30, color: KBlack)),
                            const Spacer(),
                            const Headertext(
                                text: "Verification", color: KBlack),
                            const Spacer()
                          ]),
                      gapH16,
                      Text(
                        "Enter the code we have sent to\n+23355477284",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: KBlack,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 40)),
              SliverToBoxAdapter(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 5,
                          ),
                          child: PinCodeTextField(
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
                            animationDuration:
                                const Duration(milliseconds: 300),
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
                        ),
                      ),
                      30.heightBox,
                      ListenableBuilder(
                        listenable: smsCode,
                        builder: (context, child) => MainButton(
                                color: (smsCode.text.isNotEmpty &&
                                        smsCode.text.length == 6)
                                    ? KPrimary
                                    : KGrey,
                                action: (smsCode.text.isNotEmpty &&
                                        smsCode.text.length == 6)
                                    ? () async {
                                        FocusScope.of(context).unfocus();
                                        final va =
                                            formKey.currentState!.validate();

                                        if (currentText.length != 6 ||
                                            va == false) {
                                          errorController!
                                              .add(ErrorAnimationType.shake);
                                        }

                                        bool value = await controller.verifyOtp(
                                            context,
                                            phonenumber: widget.phone,
                                            otp: smsCode.text);

                                        if (value) {
                                          context.go("/signin");
                                        }
                                      }
                                    : null,
                                text: "Verify OTP")
                            .px12()
                            .centered(),
                      ),
                      30.heightBox,
                      Maintext(
                              data: "Didn't receive code?",
                              color: KBlack,
                              align: TextAlign.center)
                          .centered(),
                      10.heightBox,
                      InkWell(
                        onTap: () async {
                          print(widget.phone);
                          bool value = await controller.resendOtp(context,
                              phonenumber: "0${widget.phone}");
                          print(value);
                        },
                        child: Underlinetext(
                          color: Colors.blue,
                          data: "Resend code",
                        ),
                      ).centered()
                    ]).px20(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
