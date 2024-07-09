import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kulobal/src/features/authentication/ui/signup.dart';
import 'package:kulobal/src/features/medication/ui/medication.dart';
import 'package:kulobal/src/features/medication/ui/medicationinfo.dart';
import 'package:kulobal/src/features/medication/model/medication.dart';

import 'package:kulobal/src/features/onboarding/ui/privacy.dart';
import 'package:kulobal/src/features/onboarding/ui/termandcond.dart';
import 'package:kulobal/src/features/profile/ui/editprofile.dart';
import 'package:kulobal/src/features/profile/ui/loyalty.dart';
import 'package:kulobal/src/features/profile/ui/settings.dart';
import 'package:kulobal/src/features/rapidtesting/model/rapidtestmodel.dart';
import 'package:kulobal/src/features/rapidtesting/ui/conductest.dart';
import 'package:kulobal/src/features/rapidtesting/ui/myrapidtest/mytests.dart';
import 'package:kulobal/src/features/rapidtesting/ui/myrapidtest/testresults.dart';
import 'package:kulobal/src/features/rapidtesting/ui/rtestdetail.dart';
import 'package:kulobal/src/features/render/ui/render.dart';
import 'package:kulobal/src/features/vitals/ui/vitals.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../startup.dart';
import '../features/authentication/ui/otp.dart';
import '../features/authentication/ui/signin.dart';
import '../features/onboarding/repo/onboard.dart';
import '../features/onboarding/ui/onboarding.dart';
import '../features/splash/ui/splash.dart';

part 'approuting.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> mainMenuNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'main-menu');

enum AllRoutes {
  home,
  cart,
  products,
  prescriptions,
  checkout,
  ordertracking,
  profile,
  rapidtest,
  reports,
}

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  final startup = ref.watch(appStartupProvider);
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: Signup.id,
    debugLogDiagnostics: true,
    redirect: (contex, state) {
      if (startup.isLoading || startup.hasError) {
        return OurSplash.splashName;
      }

      final onboardrepo = ref.read(onBoardRepoProvider).requireValue;
      final onboardingdone = onboardrepo.checkonboardingcomplete();

      final path = state.uri.path;

      if (!onboardingdone) {
        if (path != "/onboarding") {
          return "/onboarding";
        }

        return null;
      }

      bool isSigned = onboardrepo.isSignedIn();
      if (isSigned) {
        if (path.startsWith("/onboarding") ||
            path.startsWith(Signup.id) ||
            path.startsWith(OurSplash.splashName)) {
          return KulobalRender.renderName;
        }
      } else {
        if (!path.startsWith("/signin")) {
          return "/signin";
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: OurSplash.splashName,
        pageBuilder: (context, state) => NoTransitionPage(
          child: AppStartupWidget(
            onLoaded: (_) => const OurSplash(),
          ),
        ),
      ),
      GoRoute(
        path: OnBoarding.onboardName,
        name: OnBoarding.onboardName,
        pageBuilder: (_, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          transitionDuration: kThemeAnimationDuration,
          reverseTransitionDuration: kThemeAnimationDuration,
          child: const OnBoarding(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: LoyaltyProgram.id,
        name: LoyaltyProgram.id,
        pageBuilder: (_, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          transitionDuration: kThemeAnimationDuration,
          reverseTransitionDuration: kThemeAnimationDuration,
          child: const LoyaltyProgram(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
          path: ConductTest.id,
          name: ConductTest.id,
          pageBuilder: (_, state) {
            final String? test = state.extra as String?;
            return CustomTransitionPage<void>(
              key: state.pageKey,
              transitionDuration: kThemeAnimationDuration,
              reverseTransitionDuration: kThemeAnimationDuration,
              child: ConductTest(test: test ?? ""),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            );
          }),
      GoRoute(
        path: Settings.id,
        name: Settings.id,
        pageBuilder: (_, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          transitionDuration: kThemeAnimationDuration,
          reverseTransitionDuration: kThemeAnimationDuration,
          child: const Settings(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: EditProfile.id,
        name: EditProfile.id,
        pageBuilder: (_, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          transitionDuration: kThemeAnimationDuration,
          reverseTransitionDuration: kThemeAnimationDuration,
          child: const EditProfile(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: KulobalRender.renderName,
        name: KulobalRender.renderName,
        pageBuilder: (_, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          transitionDuration: kThemeAnimationDuration,
          reverseTransitionDuration: kThemeAnimationDuration,
          child: const KulobalRender(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: Signin.signInname,
        name: Signin.signInname,
        pageBuilder: (_, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          transitionDuration: kThemeAnimationDuration,
          reverseTransitionDuration: kThemeAnimationDuration,
          child: const Signin(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: Signup.id,
        name: Signup.id,
        pageBuilder: (_, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          transitionDuration: kThemeAnimationDuration,
          reverseTransitionDuration: kThemeAnimationDuration,
          child: const Signup(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
          path: RapidTestDetail.id,
          name: RapidTestDetail.id,
          pageBuilder: (_, state) {
            final RapidModel rtest = state.extra as RapidModel;
            return CustomTransitionPage<void>(
              key: state.pageKey,
              transitionDuration: kThemeAnimationDuration,
              reverseTransitionDuration: kThemeAnimationDuration,
              child: RapidTestDetail(rapid: rtest),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            );
          }),
      GoRoute(
        path: Privacy.privacy,
        name: Privacy.privacy,
        pageBuilder: (_, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          transitionDuration: kThemeAnimationDuration,
          reverseTransitionDuration: kThemeAnimationDuration,
          child: const Privacy(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: TandCs.tandC,
        name: TandCs.tandC,
        pageBuilder: (_, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          transitionDuration: kThemeAnimationDuration,
          reverseTransitionDuration: kThemeAnimationDuration,
          child: const TandCs(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
          path: OtpPage.otpName,
          name: OtpPage.otpName,
          pageBuilder: (_, state) {
            final String phone = state.extra as String;

            return CustomTransitionPage<void>(
              key: state.pageKey,
              transitionDuration: kThemeAnimationDuration,
              reverseTransitionDuration: kThemeAnimationDuration,
              child: OtpPage(phone),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            );
          }),
      GoRoute(
          path: MyTests.id,
          name: MyTests.id,
          pageBuilder: (_, state) => CustomTransitionPage<void>(
                key: state.pageKey,
                transitionDuration: kThemeAnimationDuration,
                reverseTransitionDuration: kThemeAnimationDuration,
                child: const MyTests(),
                transitionsBuilder: (_, animation, __, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              )),
      GoRoute(
          path: TestResults.id,
          name: TestResults.id,
          pageBuilder: (_, state) {
            final String title = state.extra as String;
            return CustomTransitionPage<void>(
              key: state.pageKey,
              transitionDuration: kThemeAnimationDuration,
              reverseTransitionDuration: kThemeAnimationDuration,
              child: TestResults(title),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            );
          }),
      GoRoute(
        path: Vitals.id,
        name: Vitals.id,
        pageBuilder: (_, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          transitionDuration: kThemeAnimationDuration,
          reverseTransitionDuration: kThemeAnimationDuration,
          child: const Vitals(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: Medication.id,
        name: Medication.id,
        pageBuilder: (_, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          transitionDuration: kThemeAnimationDuration,
          reverseTransitionDuration: kThemeAnimationDuration,
          child: const Medication(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
          path: Medicationinfo.id,
          name: Medicationinfo.id,
          pageBuilder: (_, state) {
            final Medicmodel med = state.extra as Medicmodel;
            return CustomTransitionPage<void>(
              key: state.pageKey,
              transitionDuration: kThemeAnimationDuration,
              reverseTransitionDuration: kThemeAnimationDuration,
              child: Medicationinfo(medication: med),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            );
          }),
    ],
  );
}

// routing stream
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
