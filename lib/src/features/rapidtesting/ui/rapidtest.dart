import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kulobal/src/constant/style.dart';
import 'package:kulobal/src/features/onboarding/repo/onboardcontroller.dart';
import 'package:kulobal/src/features/rapidtesting/model/rapidtestdata.dart';
import 'package:kulobal/src/features/rapidtesting/ui/rtestdetail.dart';
import 'package:kulobal/src/features/rapidtesting/ui/widgets/testcard.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../constant/text.dart';

class RapidTest extends ConsumerStatefulWidget {
  const RapidTest({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RapidTestState();
}

class _RapidTestState extends ConsumerState<RapidTest> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () => ref.refresh(onBoardCtlProvider.future),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            //floating: true,
            centerTitle: false,
            title: Headtext(
              data: "Home Rapid Testing Guide",
            ),

            // bottom: PreferredSize(
            //     preferredSize: const Size.fromHeight(60),
            //     child: SearchWidget(
            //       action: () {},
            //     ).px20()),
          ),
          20.heightBox.sliverToBoxAdapter(),
          SliverPadding(
            padding: hpadx,
            sliver: SliverList.separated(
                itemCount: rapidtestData.length,
                itemBuilder: (context, index) {
                  return TestCard(
                      action: () => context.push(RapidTestDetail.id,
                          extra: rapidtestData[index]),
                      body: rapidtestData[index].body,
                      image: rapidtestData[index].image,
                      title: rapidtestData[index].title);
                },
                separatorBuilder: (context, _) => 15.heightBox),
          )
        ],
      ),
    );
  }
}
