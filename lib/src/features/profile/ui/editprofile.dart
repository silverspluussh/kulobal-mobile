// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kulobal/src/components/buttons.dart';
import 'package:kulobal/src/constant/style.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../components/appbar.dart';

class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({super.key});
  static const String id = "/editprofile";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    Container imageContainer(ImageProvider<Object> imageProvider) {
      return Container(
        height: 100,
        width: size.width * 0.5,
        decoration: BoxDecoration(
          border: Border.all(width: 5, color: KPrimary.withOpacity(0.5)),
          shape: BoxShape.circle,
          image: DecorationImage(image: imageProvider, fit: BoxFit.contain),
        ),
      );
    }

    return Scaffold(
      appBar: CustomBar(title: "Personal Details"),
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            20.heightBox,
            SizedBox(
              width: size.width,
              height: 110,
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: "",
                    imageBuilder: (context, imageProvider) =>
                        imageContainer(imageProvider),
                    placeholder: (context, url) => imageContainer(
                        const AssetImage('assets/icons/Ellipse 45.png')),
                    cacheManager:
                        CacheManager(Config('pfpcache', stalePeriod: 5.days)),
                    errorWidget: (context, url, error) => imageContainer(
                        const AssetImage('assets/icons/Ellipse 45.png')),
                  ),
                  Positioned(
                      right: 50,
                      bottom: 5,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            shape: BoxShape.circle),
                        child: const Center(
                          child: Icon(Icons.camera_alt_rounded,
                              color: KPrimary, size: 25),
                        ),
                      ))
                ],
              ).centered(),
            ).centered(),
            20.heightBox,
            _label("First name"),
            10.heightBox,
            TextFormField(
              //  controller: fname,
              decoration: InputDecoration(
                hintText: "Federick",
                isDense: true,
                border: OutlineInputBorder(),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              ),
              keyboardType: TextInputType.name,
            ),
            20.heightBox,
            _label("Last name"),
            10.heightBox,
            TextFormField(
              // controller: lname,
              decoration: InputDecoration(
                hintText: "Garvey",
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              ),
              keyboardType: TextInputType.name,
            ),
            20.heightBox,
            _label("Gender"),
            10.heightBox,
            TextFormField(
              // controller: lname,
              decoration: InputDecoration(
                hintText: "Male wai",
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              ),
              keyboardType: TextInputType.text,
            ),
            20.heightBox,
            _label("Email"),
            10.heightBox,
            TextFormField(
              // controller: lname,
              decoration: InputDecoration(
                hintText: "fredobandz@g.com",
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            20.heightBox,
            _label("Contact info"),
            10.heightBox,
            TextFormField(
              // controller: phone,
              decoration: InputDecoration(
                hintText: "+233 6854 48293",
                isDense: true,
                border: OutlineInputBorder(),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              ),
              keyboardType: TextInputType.phone,
            ),
            20.heightBox,
            MainButton(action: () {}, text: "Save changes"),
            20.heightBox,
          ]))
        ],
      ).px24(),
    );
  }

  Text _label(String label) {
    return Text(label,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.bold));
  }
}
