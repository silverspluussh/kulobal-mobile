import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kulobal/src/components/alert_dialogs.dart';
import 'package:kulobal/src/components/regex.dart';
import 'package:kulobal/src/components/textfield.dart';
import 'package:kulobal/src/features/onboarding/ui/privacy.dart';
import 'package:kulobal/src/features/onboarding/ui/termandcond.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../components/buttons.dart';
import '../../../constant/style.dart';
import '../../../constant/text.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../repo/authctl.dart';

class Signup extends ConsumerStatefulWidget {
  const Signup({super.key});
  static const id = "/signup";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupState();
}

class _SignupState extends ConsumerState<Signup> {
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController location = TextEditingController();

  bool readOff = false;
  bool isObscured = true;

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: hpad,
          child: Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * 0.6,
                      height: size.height * 0.1,
                      child: SvgPicture.asset(
                        appLogo[0],
                        height: size.height * 0.15,
                      ),
                    ).centered(),
                    Headtext(data: "Register with Kulobal"),
                    15.heightBox,
                    const Labletext(text: "Email"),
                    gapH4,
                    CustomTextField(
                      ctx: context,
                      controller: email,
                      readOnly: readOff,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'email must be provided.';
                        }
                        return null;
                      },
                      hint: "eg. user@kulobal.gh",
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
                    10.heightBox,
                    const Labletext(text: "Phone Number"),
                    gapH4,
                    IntlPhoneField(
                      controller: phone,
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
                      // onChanged: (newValue) => setState(() {
                      //   phone.text = newValue.completeNumber;
                      // }),
                      pickerDialogStyle: phonestyle,
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
                    const Labletext(text: "First Name"),
                    gapH4,
                    CustomTextField(
                      ctx: context,
                      controller: firstname,
                      readOnly: readOff,
                      hint: "eg. Akwasi",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'firstname must be provided';
                        }
                        return null;
                      },
                    ),
                    10.heightBox,
                    const Labletext(
                      text: "Last Name",
                    ),
                    gapH4,
                    CustomTextField(
                      ctx: context,
                      controller: lastname,
                      readOnly: readOff,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'lastname must be provided';
                        }
                        return null;
                      },
                      hint: "eg. Ntow",
                    ),
                    10.heightBox,
                    const Labletext(text: "Location"),
                    gapH4,
                    CustomTextField(
                      controller: location,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'location must be provided';
                        }
                        return null;
                      },
                      ctx: context,
                      readOnly: readOff,
                      hint: "eg. Accra",
                    ),
                    20.heightBox,
                    ListenableBuilder(
                        listenable: Listenable.merge([
                          phone,
                          email,
                          lastname,
                          firstname,
                          location,
                          password
                        ]),
                        builder: (context, child) {
                          bool done = phone.text.isNotEmpty &&
                              email.text.isNotEmpty &&
                              lastname.text.isNotEmpty &&
                              firstname.text.isNotEmpty &&
                              location.text.isNotEmpty &&
                              password.text.isNotEmpty;
                          return MainButton(
                              action: () async {
                                final controller =
                                    ref.watch(authControllerProvider);
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  readOff = !readOff;
                                });
                                bool validate =
                                    formkey.currentState!.validate();
                                if (validate && done) {
                                  bool value = await controller.register(
                                      context,
                                      email: email.text,
                                      password: password.text,
                                      firstname: firstname.text,
                                      lastname: lastname.text,
                                      phonenumber: "0${phone.text}"
                                          .removeAllWhiteSpace(),
                                      location: location.text);
                                  setState(() {
                                    readOff = false;
                                  });
                                  if (value) {
                                    context.push("/otp", extra: phone.text);
                                  }
                                } else {
                                  showExceptionAlertDialog(
                                      context: context,
                                      title: "Problem occurred",
                                      exception:
                                          "Complete All Fields to continue");
                                }

                                //  context.push("/otp");
                              },
                              text: "Next",
                              color: done ? KPrimary : KGrey);
                        }),
                    gapH8,
                    HStack(alignment: MainAxisAlignment.center, [
                      Maintext(data: "Already have an account?"),
                      gapW8,
                      GestureDetector(
                        onTap: () => context.go("/signin"),
                        child: Underlinetext(
                          data: "Log in",
                          color: Colors.blue,
                        ),
                      )
                    ]).centered(),
                    gapH32,
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Maintext(
                            color: KGrey,
                            align: TextAlign.start,
                            data: "By signing up you agree to our "),
                        InkWell(
                          onTap: () => context.push(TandCs.tandC),
                          child: Text(
                            tandc,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    decoration: TextDecoration.underline,
                                    color: KBlack),
                          ),
                        ),
                        Maintext(
                            color: KGrey,
                            align: TextAlign.start,
                            data: " and "),
                        InkWell(
                          onTap: () => context.push(Privacy.privacy),
                          child: Text(
                            "Privacy Policy.",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    decoration: TextDecoration.underline,
                                    color: KBlack),
                          ),
                        ),
                      ],
                    ).centered(),
                    gapH8
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
