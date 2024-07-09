import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kulobal/src/components/alert_dialogs.dart';
import 'package:kulobal/src/components/appbar.dart';
import 'package:kulobal/src/components/buttons.dart';
import 'package:kulobal/src/constant/style.dart';
import 'package:kulobal/src/constant/text.dart';
import 'package:kulobal/src/features/rapidtesting/model/rapidtestmodel.dart';
import 'package:kulobal/src/features/rapidtesting/ui/conductest.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class RapidTestDetail extends ConsumerStatefulWidget {
  const RapidTestDetail({super.key, required this.rapid});
  final RapidModel rapid;
  static const String id = "/rapidtest";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RapidTestDetailState();
}

class _RapidTestDetailState extends ConsumerState<RapidTestDetail> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = YoutubePlayerController(
      initialVideoId: widget.rapid.id!,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    videoMetaData = const YoutubeMetaData();
    playerState = PlayerState.unknown;
  }

  late PlayerState playerState;
  late YoutubeMetaData videoMetaData;
  bool _isPlayerReady = false;

  void listener() {
    if (_isPlayerReady && mounted && !controller.value.isFullScreen) {
      setState(() {
        playerState = controller.value.playerState;
        videoMetaData = controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        mini: true,
        tooltip: "Ask Kulobal bot",
        onPressed: () {},
        child: Image.asset(
          "assets/icons/aibot.png",
          height: 30,
          width: 30,
        ),
      ),
      appBar: CustomBar(
        title: widget.rapid.title,
      ),
      body: CustomScrollView(
        slivers: [
          10.heightBox.sliverToBoxAdapter(),
          SliverToBoxAdapter(
            child: YoutubePlayerBuilder(
                player: YoutubePlayer(
                    onReady: () {
                      _isPlayerReady = true;
                    },
                    thumbnail: SvgPicture.asset(appLogo.first).px12(),
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: KPrimary,
                    controller: controller),
                builder: (context, player) =>
                    Container(margin: const EdgeInsets.all(5), child: player)),
          ),
          SliverPadding(
            padding: hpadx,
            sliver: SliverList(
                delegate: SliverChildListDelegate([
              15.heightBox,
              VStack(crossAlignment: CrossAxisAlignment.start, [
                Headtext(
                  data: "Instructions",
                ),
                10.heightBox,
                ...widget.rapid.instructions!.map((e) => _hintTile(e)).toList()
              ]),
              10.heightBox,
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        width: 1,
                        color: const Color.fromARGB(255, 1, 65, 117))),
                child: Maintext(
                    color: const Color.fromARGB(255, 1, 65, 117),
                    data:
                        "Always read and follow the instructions provided with each test kit.\nStore test kits in a cool, dry place and check expiration dates."),
              ),
              10.heightBox,
              MainButton(
                  action: () {
                    controller.pause();
                    showAlertDialog(
                        context: context,
                        title: "Feature not yet available",
                        content:
                            "Conduct test is still under development and will be available soon.");
                    //  context.push(ConductTest.id, extra: widget.rapid.title);
                  },
                  text: "Conduct test (coming soon)")
            ])),
          )
        ],
      ),
    );
  }

  HStack _hintTile(String body) {
    return HStack([
      Checkbox.adaptive(
        value: true,
        onChanged: (v) {},
      ),
      10.widthBox,
      Expanded(
        child: Maintext(
          data: body,
        ),
      ),
    ]);
  }
}
