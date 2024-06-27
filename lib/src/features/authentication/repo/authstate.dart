Stream signedIn() async* {
  yield await Future.delayed(Duration(minutes: 10));
}
