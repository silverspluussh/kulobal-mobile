import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../components/buttons.dart';
import '../../../components/textfield.dart';
import '../../../constant/style.dart';
import '../../../constant/text.dart';
import '../../authentication/ui/otp.dart';

class OnBoarding extends ConsumerStatefulWidget {
  const OnBoarding({super.key});
  static const String onboardName = "/onboarding";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OnBoardingState();
}

class _OnBoardingState extends ConsumerState<OnBoarding> {
  final formkey = GlobalKey<FormState>();

  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController agentcode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    Container imageContainer(String imageProvider) {
      return Container(
        height: size.height * 0.15,
        width: size.width * 0.5,
        decoration: BoxDecoration(
          color: KGrey.withOpacity(0.5),
          border: Border.all(width: 1, color: KPrimary),
          shape: BoxShape.circle,
          image: DecorationImage(
              image: AssetImage(imageProvider), fit: BoxFit.fill),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: KWhite,
        elevation: 0,
        title: const Headertext(text: "Create Account", color: KBlack),
        leading: BackButton(
          onPressed: () {},
          color: KBlack,
        ),
        actions: [TextBtn(onPressed: () {}, child: "Skip", context: context)],
      ),
      body: SafeArea(
        child: Form(
          key: formkey,
          child: CustomScrollView(slivers: [
            SliverPadding(
              padding: hpad,
              sliver: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  gapH16,
                  SizedBox(
                    height: size.height * 0.15,
                    width: size.width * 0.5,
                    child: Stack(
                      children: [
                        imageContainer("").centered(),
                        Positioned(
                            right: 50,
                            bottom: 0,
                            child: GestureDetector(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        duration: 4.seconds,
                                        behavior: SnackBarBehavior.floating,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 15),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        backgroundColor: Colors.white,
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Spacer(),
                                            TextButton.icon(
                                                onPressed: () async {},
                                                icon: const Icon(Icons.camera,
                                                    size: 30, color: KPrimary),
                                                label: const Labletext(
                                                    text: 'Camera')),
                                            const Spacer(),
                                            TextButton.icon(
                                                onPressed: () async {},
                                                icon: const Icon(
                                                    Icons.browse_gallery,
                                                    size: 30,
                                                    color: KGreen),
                                                label: const Labletext(
                                                    text: 'Gallery')),
                                            const Spacer(),
                                          ],
                                        )));
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: const Center(
                                  child: Icon(Icons.camera_alt_rounded,
                                      color: KPrimary, size: 20),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ).centered(),
                  gapH32,
                  const Labletext(text: "First Name"),
                  gapH8,
                  SizedBox(
                    height: 55,
                    child: CustomTextField(
                      ctx: context,
                      hint: "eg. Emmanuel",
                      controller: fname,
                      validator: (v) {
                        return v == null ? "field cannot be empty" : null;
                      },
                    ),
                  ),
                  gapH20,
                  const Labletext(text: "Last Name"),
                  gapH8,
                  SizedBox(
                    height: 55,
                    child: CustomTextField(
                      ctx: context,
                      controller: lname,
                      hint: "eg. Devi",
                      validator: (v) {
                        return v == null ? "field cannot be empty" : null;
                      },
                    ),
                  ),
                  gapH20,
                  const Labletext(text: "Email"),
                  gapH8,
                  SizedBox(
                    height: 55,
                    child: CustomTextField(
                      ctx: context,
                      hint: "eg. emmdevi@de.com",
                      controller: email,
                      validator: (v) {
                        return v == null ? "field cannot be empty" : null;
                      },
                    ),
                  ),
                  gapH20,
                  const Labletext(text: "Agent Code(optional)"),
                  gapH8,
                  SizedBox(
                    height: 55,
                    child: CustomTextField(
                      ctx: context,
                      hint: "eg. MDA01129",
                      controller: agentcode,
                      validator: (v) {
                        return null;
                      },
                    ),
                  ),
                  gapH48,
                  ListenableBuilder(
                      listenable: Listenable.merge([lname, fname, email]),
                      builder: (context, child) {
                        final filled = lname.text.isNotEmptyAndNotNull &&
                            fname.text.isNotEmptyAndNotNull &&
                            email.text.isNotEmptyAndNotNull;
                        return MainButton(
                                color: filled ? KPrimary : KGrey,
                                action: () {
                                  context.go(OtpPage.otpName);
                                },
                                text: "Continue")
                            .centered();
                      })
                ],
              ).sliverToBoxAdapter(),
            ),
          ]),
        ),
      ),
    );
  }
}
