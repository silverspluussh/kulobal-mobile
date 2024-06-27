import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:async';

import 'onboard.dart';

part 'onboardcontroller.g.dart';

@riverpod
class OnBoardCtl extends _$OnBoardCtl {
  @override
  FutureOr build() {}

  Future<void> completeOnboarding() async {
    final repo = ref.watch(onBoardRepoProvider).requireValue;

    state = const AsyncLoading();
    state = await AsyncValue.guard(repo.setOnboardingdone);
  }
}
