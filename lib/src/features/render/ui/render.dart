import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kulobal/src/constant/style.dart';
import 'package:kulobal/src/features/home/ui/home.dart';
import 'package:kulobal/src/features/profile/ui/profile.dart';
import 'package:kulobal/src/features/rapidtesting/ui/rapidtest.dart';
import 'package:velocity_x/velocity_x.dart';

class KulobalRender extends ConsumerStatefulWidget {
  const KulobalRender({super.key});
  static const String renderName = "/render";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _KulobalRenderState();
}

class _KulobalRenderState extends ConsumerState<KulobalRender> {
  int _selectedPageIndex = 0;

  onSelected(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  List<Widget> pages = [];

  @override
  void initState() {
    pages = [const Home(), const RapidTest(), const Profile()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedPageIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        surfaceTintColor: KWhite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
               GestureDetector(
                onTap: () => onSelected(0),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                          _selectedPageIndex == 0
                              ? "assets/icons/home-216.svg"
                              : "assets/icons/home-216.svg",
                          width: 25,
                          height: 25,
                          colorFilter: ColorFilter.mode(
                              0 == _selectedPageIndex ? KPrimary : KBlack,
                              BlendMode.srcIn)),
                      5.heightBox,
                      Text("Home",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: 0 == _selectedPageIndex
                                ? KPrimary
                                : 0 == _selectedPageIndex
                                    ? KPrimary
                                    : KBlack,
                          )),
                    ],
                  ),
                )),
            GestureDetector(
                onTap: () => onSelected(1),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                          _selectedPageIndex == 1
                              ? "assets/icons/test-close.svg"
                              : "assets/icons/test-open.svg",
                          width: 25,
                          height: 25,
                          colorFilter: ColorFilter.mode(
                              1== _selectedPageIndex ? KPrimary : KBlack,
                              BlendMode.srcIn)),
                      5.heightBox,
                      Text("Rapid test",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: 1 == _selectedPageIndex
                                ? KPrimary
                                : 1 == _selectedPageIndex
                                    ? KPrimary
                                    : KBlack,
                          )),
                    ],
                  ),
                )),
            GestureDetector(
                onTap: () => onSelected(2),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                          _selectedPageIndex == 2
                              ? "assets/icons/profile-close.svg"
                              : "assets/icons/profile-open.svg",
                          width: 25,
                          height: 25,
                          colorFilter: ColorFilter.mode(
                              2 == _selectedPageIndex ? KPrimary : KBlack,
                              BlendMode.srcIn)),
                      5.heightBox,
                      Text("Profile",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color:
                                  2 == _selectedPageIndex ? KPrimary : KBlack)),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
