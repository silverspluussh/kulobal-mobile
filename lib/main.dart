import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kulobal/src/constant/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/routing/approuting.dart';
import 'startup.dart';
import 'package:timezone/data/latest.dart' as tz;

late SharedPreferences prefs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  tz.initializeTimeZones();

  runApp(ProviderScope(
      child: AppStartupWidget(onLoaded: (context) => const Kulobal())));
}

class Kulobal extends ConsumerWidget {
  const Kulobal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      routerConfig: goRouter,
      theme: theme,
      debugShowCheckedModeBanner: false,
      title: "Kulobal",
    );
  }
}
