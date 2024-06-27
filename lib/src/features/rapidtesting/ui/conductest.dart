import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kulobal/src/components/appbar.dart';
import 'package:kulobal/src/components/buttons.dart';
import 'package:kulobal/src/components/textfield.dart';
import 'package:kulobal/src/constant/style.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../../constant/text.dart';

class ConductTest extends ConsumerStatefulWidget {
  const ConductTest({super.key, this.test});
  final String? test;

  static const String id = "/conductest";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConductTestState();
}

class _ConductTestState extends ConsumerState<ConductTest> {
  TextEditingController test = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController pharmacy = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  final ImageCropper _cropper = ImageCropper();

  File? idPhoto;
  final formkey = GlobalKey<FormState>();

  Future<File?> cropImage({
    required File image,
  }) async {
    try {
      CroppedFile? croppedfile =
          await _cropper.cropImage(sourcePath: image.path, uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: KPrimary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings()
      ]);
      if (croppedfile == null) return null;
      //  log(croppedfile.path);
      return File(croppedfile.path);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  idUpload({required BuildContext context, required ImageSource src}) async {
    if (context.mounted) {
      try {
        final value = await _picker.pickImage(source: src, imageQuality: 80);
        if (value == null) return;
        File? image = File(value.path);
        image = await cropImage(image: image);
        setState(() {
          idPhoto = image;
        });
      } on PlatformException catch (e) {
        log(e.message.toString());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    test.text = widget.test ?? "";
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    // Enum uploadtype = ref.watch(uploadtypeProvider);
    return Scaffold(
      appBar: CustomBar(title: "Home Test"),
      body: Padding(
        padding: hpad,
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Labletext(text: "Test Type *"),
              10.heightBox,
              DropdownButtonFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: KGrey.withOpacity(0.1),
                    isDense: true,
                    hintText: test.text,
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                  ),
                  items: ["Covid", "Typhoid", "Malaria"]
                      .map((e) =>
                          DropdownMenuItem(value: e, child: Maintext(data: e)))
                      .toList(),
                  onChanged: (tes) {
                    setState(() {
                      if (tes != null) {
                        test.text = tes;
                      }
                    });
                  }),
              20.heightBox,
              const Labletext(text: "Select Pharmacy *"),
              10.heightBox,
              DropdownButtonFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: KGrey.withOpacity(0.1),
                    isDense: true,
                    border: const OutlineInputBorder(),
                    hintText: "Select pharmacy *",
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                  ),
                  items: ["Test 1", "Test 2", "Test 3"]
                      .map((e) => DropdownMenuItem(
                          value: e,
                          child: Maintext(
                            data: e,
                          )))
                      .toList(),
                  onChanged: (pharm) {
                    setState(() {
                      pharmacy.text = pharm!;
                    });
                  }),
              20.heightBox,
              const Labletext(text: "Test image "),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Labletext(
              //         text: uploadtype == UploadType.image
              //             ? "Test image "
              //             : "Input manually"),
              //     uploadtype == UploadType.image
              //         ? Maintext(data: "*", color: KRed)
              //         : SizedBox.shrink(),
              //     const Spacer(),
              //     GestureDetector(
              //       onTap: () => ref.watch(uploadtypeProvider.notifier).state =
              //           uploadtype == UploadType.image
              //               ? UploadType.text
              //               : UploadType.image,
              //       child: Card(
              //         color: KPrimary,
              //         elevation: 5,
              //         child: Maintext(
              //           data: uploadtype == UploadType.image
              //               ? "Input manually"
              //               : "Upload image",
              //           weight: FontWeight.w600,
              //           color: KWhite,
              //         ).px16().py8(),
              //       ),
              //     ),
              //     // const Tooltip(
              //     //   message:
              //     //       "Images are only allowed to mitigate the errors in mistyping.\nTake a picture of the device with the final readings",
              //     //   margin: EdgeInsets.all(15),
              //     //   child:
              //     //       Icon(Icons.lightbulb_circle_outlined, color: KPrimary),
              //     // )
              //   ],
              // ),
              10.heightBox,
              DottedBorder(
                  borderType: BorderType.RRect,
                  child: Container(
                      decoration: BoxDecoration(
                          image: idPhoto != null
                              ? DecorationImage(
                                  image: FileImage(idPhoto!), fit: BoxFit.cover)
                              : null),
                      width: size.width * 0.9,
                      height: size.height * 0.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () => showModalBottomSheet(
                                  context: context,
                                  backgroundColor: KWhite,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  elevation: 10,
                                  builder: (_) => Container(
                                        height: 70,
                                        width: size.width * 0.8,
                                        padding: const EdgeInsets.all(15),
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: HStack([
                                          InkWell(
                                              onTap: () {
                                                context.pop();
                                                idUpload(
                                                    context: context,
                                                    src: ImageSource.camera);
                                              },
                                              child: SvgPicture.asset(
                                                  "assets/icons/camera.svg",
                                                  height: 45,
                                                  width: 50)),
                                          const Spacer(),
                                          InkWell(
                                              onTap: () {
                                                context.pop();
                                                idUpload(
                                                    context: context,
                                                    src: ImageSource.gallery);
                                              },
                                              child: SvgPicture.asset(
                                                  "assets/icons/gallery.svg",
                                                  height: 45,
                                                  width: 50)),
                                        ]),
                                      ).safeArea()),
                              icon: SvgPicture.asset(
                                "assets/icons/cam.svg",
                                height: 45,
                                width: 50,
                              )),
                          20.heightBox,
                          idPhoto == null
                              ? Maintext(
                                  align: TextAlign.center,
                                  data:
                                      "Click here to take picture of the test kit with results readings.",
                                )
                              : const SizedBox.shrink()
                        ],
                      )))
              // uploadtype == UploadType.text
              //     ? Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           const Labletext(text: "Diastolic reading *"),
              //           10.heightBox,
              //           CustomTextField(
              //             ctx: context,
              //             hint: "diastolic (mmHg)",
              //             inputType: TextInputType.number,
              //           ),
              //           20.heightBox,
              //           const Labletext(text: "Systolic reading *"),
              //           10.heightBox,
              //           CustomTextField(
              //             ctx: context,
              //             hint: "systolic (mmHg)",
              //             inputType: TextInputType.number,
              //           ),
              //           20.heightBox,
              //           const Labletext(text: "Pulse rate *"),
              //           10.heightBox,
              //           CustomTextField(
              //             ctx: context,
              //             hint: 'pulse (bpm)',
              //             inputType: TextInputType.number,
              //           ),
              //         ],
              //       )
              //     : const SizedBox.shrink(),
              ,
              20.heightBox,
              const Labletext(text: "Add Notes (optional)"),
              10.heightBox,
              TextFormField(
                minLines: 3,
                maxLines: 3,
                controller: note,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: KGrey.withOpacity(0.1),
                  isDense: true,
                  border: const OutlineInputBorder(),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
              ),
              30.heightBox,
              ListenableBuilder(
                  listenable: Listenable.merge([test, pharmacy]),
                  builder: ((context, child) {
                    bool complete =
                        test.text.isNotEmpty && pharmacy.text.isNotEmpty;

                    return MainButton(
                      action: complete ? () {} : null,
                      text: "Submit",
                      color: complete ? KPrimary : KGrey,
                    );
                  }))
            ]),
          ),
        ),
      ),
    );
  }
}

// final uploadtypeProvider = StateProvider<UploadType>((ref) {
//   return UploadType.image;
// });

// enum UploadType { image, text }
