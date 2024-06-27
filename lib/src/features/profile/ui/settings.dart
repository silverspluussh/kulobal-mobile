import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kulobal/src/components/alert_dialogs.dart';
import 'package:kulobal/src/components/appbar.dart';
import 'package:kulobal/src/components/buttons.dart';
import 'package:kulobal/src/constant/style.dart';
import 'package:kulobal/src/constant/text.dart';
import 'package:velocity_x/velocity_x.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({super.key});

  static const String id = "/settings";
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBar(title: "Settings"),
      body: Padding(
        padding: hpad,
        child: SingleChildScrollView(
          child: VStack([
            Transform.scale(
              scale: 0.95,
              child: SwitchListTile.adaptive(
                  title: const Labletext(text: "App Notifications"),
                  subtitle: Maintext(
                      data: "Get notified through our mobile app.",
                      color: KGrey),
                  value: true,
                  onChanged: (local) {}),
            ),
            Transform.scale(
              scale: 0.95,
              child: SwitchListTile.adaptive(
                  title: const Labletext(text: "SMS Notifications"),
                  subtitle: Maintext(
                      data: "Get notified through text sms.", color: KGrey),
                  value: false,
                  onChanged: (sms) {}),
            ),
            Transform.scale(
              scale: 0.95,
              child: SwitchListTile.adaptive(
                  title: const Labletext(text: "Promotional Notifications"),
                  subtitle: Maintext(
                      data: "Get notified of upcoming products and features.",
                      color: KGrey),
                  value: true,
                  onChanged: (promo) {}),
            ),
            30.heightBox,
            ListTile(
              onTap: () => showAlertDialog(
                  context: context,
                  title: "Logout?",
                  content:
                      "Are you sure you want to log out from your account?",
                  cancelActionText: "Cancel",
                  defaultActionText: "Logout"),
              leading: const Icon(Icons.logout, size: 30, color: KRed),
              title: Maintext(data: "Logout", weight: FontWeight.w700),
            ),
            ListTile(
              onTap: () => deleteaccountmodal(context),
              leading: const Icon(Icons.delete_rounded, size: 30, color: KRed),
              title: Maintext(data: "Delete Account", weight: FontWeight.w700),
            ),
          ]),
        ),
      ),
    );
  }

  Future<dynamic> deleteaccountmodal(BuildContext context) {
    return showModalBottomSheet(
        backgroundColor: KWhite,
        builder: (context) => Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              height: MediaQuery.sizeOf(context).height * 0.5,
              width: MediaQuery.sizeOf(context).width,
              child: VStack([
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Labletext(text: "Delete Account?").centered(),
                  trailing: IconButton(
                      onPressed: () => context.pop(), icon: Icon(Icons.close)),
                ),
                const Divider(),
                ...[
                  "Medbox service is expensive",
                  "I am not satisfied with the service",
                  "I no longer want to use the app",
                  "I will come back later"
                ].map((e) => CheckboxListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: Maintext(data: e, color: KBlack),
                    value: e.isNotEmpty,
                    onChanged: (e) {})),
                20.heightBox,
                MainButton(action: () {}, text: "Delete Account", color: KRed)
              ]),
            ),
        context: context);
  }
}
