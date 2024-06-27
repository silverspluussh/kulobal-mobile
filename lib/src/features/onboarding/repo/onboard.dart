import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'onboard.g.dart';

class OnBoardRepo {
  OnBoardRepo(this.prefs);
  final SharedPreferences prefs;

  static const onboardcompletekey = "complete";
  static const authKey = "signin";

  Future<void> setOnboardingdone() async =>
      await prefs.setBool(onboardcompletekey, true);

  bool checkonboardingcomplete() => prefs.getBool(onboardcompletekey) ?? true;

  //
  Future<void> setSignin() async => await prefs.setBool(authKey, true);

  bool isSignedIn() => prefs.getBool(authKey) ?? true;
}

@Riverpod(keepAlive: true)
Future<OnBoardRepo> onBoardRepo(OnBoardRepoRef ref) async =>
    OnBoardRepo(await SharedPreferences.getInstance());
