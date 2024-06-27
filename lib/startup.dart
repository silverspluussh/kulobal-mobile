import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:isar/isar.dart';
import 'package:kulobal/src/constant/text.dart';
import 'package:kulobal/src/features/notification/repo/notification.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'src/constant/style.dart';
import 'src/features/medication/model/medication.dart';
import 'src/features/medication/model/reminders.dart';
import 'src/features/onboarding/repo/onboard.dart';

part 'startup.g.dart';

late Isar isar;

@Riverpod(keepAlive: true)
Future<void> appStartup(AppStartupRef ref) async {
  ref.onDispose(() {
    ref.invalidate(onBoardRepoProvider);
  });
  final dir = await getApplicationDocumentsDirectory();
  isar =
      await Isar.open([RemindersSchema, MedicationSchema], directory: dir.path);

  await Future.wait([
    Notifications().setupNotification(),
  ]);

  await ref.watch(onBoardRepoProvider.future);
}

class AppStartupWidget extends ConsumerWidget {
  const AppStartupWidget({super.key, required this.onLoaded});
  final WidgetBuilder onLoaded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStartupState = ref.watch(appStartupProvider);
    return appStartupState.when(
      data: (_) => onLoaded(context),
      loading: () => const AppStartupLoadingWidget(),
      error: (e, st) => AppStartupErrorWidget(
        message: e.toString(),
        onRetry: () => ref.invalidate(appStartupProvider),
      ),
    );
  }
}

class AppStartupLoadingWidget extends StatelessWidget {
  const AppStartupLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(color: KPrimary),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                SvgPicture.asset(appLogo.last)
                    .animate()
                    .fadeIn(duration: 300.ms, delay: 400.ms),
                const Spacer(),
                Maintext(data: splashheadline, color: KWhite)
                    .animate()
                    .fadeIn(duration: 100.ms, delay: 500.ms),
                gapH20
              ]),
        ),
      ),
    );
  }
}

class AppStartupErrorWidget extends StatelessWidget {
  const AppStartupErrorWidget(
      {super.key, required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(appLogo.first,
                  width: MediaQuery.sizeOf(context).width * 0.7),
              gapH16,
              const Headertext(
                  text:
                      "Unfortunately Kulobal encountered an error and cannot launch properly.",
                  color: KBlack),
              gapH12,
              Text(message, style: Theme.of(context).textTheme.headlineSmall),
              gapH16,
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('Re-launch Kulobal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
