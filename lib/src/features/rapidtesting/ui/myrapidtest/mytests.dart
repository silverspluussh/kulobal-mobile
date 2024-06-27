import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kulobal/src/components/appbar.dart';
import 'package:kulobal/src/constant/style.dart';
import 'package:kulobal/src/constant/text.dart';
import 'package:kulobal/src/features/rapidtesting/ui/myrapidtest/testresults.dart';

class MyTests extends ConsumerWidget {
  const MyTests({super.key});
  static const String id = "/mytests";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: CustomBar(title: "Rapid Tests"),
        body: ListView(
          padding: hpad,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: () => context.push(
                TestResults.id,
                extra: "Cholesterol Test Results",
              ),
              title: Headtext(data: "Cholesterol Test", fontsize: 14),
              trailing: const Icon(Icons.arrow_forward_ios, size: 15),
            ),
            const Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: () => context.push(
                TestResults.id,
                extra: "Typhoid Test Results",
              ),
              title: Headtext(data: "Typhoid Test", fontsize: 14),
              trailing: const Icon(Icons.arrow_forward_ios, size: 15),
            ),
            const Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: () => context.push(
                TestResults.id,
                extra: "HB Anaemia Test Results",
              ),
              title: Headtext(data: "HB Anaemia Test", fontsize: 14),
              trailing: const Icon(Icons.arrow_forward_ios, size: 15),
            ),
            const Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: () => context.push(
                TestResults.id,
                extra: "Blood Sugar Test Results",
              ),
              title: Headtext(data: "Blood Sugar Test", fontsize: 14),
              trailing: const Icon(Icons.arrow_forward_ios, size: 15),
            ),
            const Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: () => context.push(
                TestResults.id,
                extra: "Hepatitis B Test Results",
              ),
              title: Headtext(data: "Hepatitis B Test", fontsize: 14),
              trailing: const Icon(Icons.arrow_forward_ios, size: 15),
            ),
            const Divider(),
            // ListTile(
            //   contentPadding: EdgeInsets.zero,
            //   onTap: () {},
            //   title: Headtext(data: "BMI Test", fontsize: 14),
            //   trailing: const Icon(Icons.arrow_forward_ios, size: 15),
            // ),
            // const Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: () => context.push(
                TestResults.id,
                extra: "Blood Pressure Test Results",
              ),
              title: Headtext(data: "Blood Pressure Test", fontsize: 14),
              trailing: const Icon(Icons.arrow_forward_ios, size: 15),
            ),
            const Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: () => context.push(
                TestResults.id,
                extra: "Pregnancy Test Results",
              ),
              title: Headtext(data: "Pregnancy Test", fontsize: 14),
              trailing: const Icon(Icons.arrow_forward_ios, size: 15),
            ),
            const Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: () => context.push(
                TestResults.id,
                extra: "PSA Test Results",
              ),
              title: Headtext(data: "PSA Test", fontsize: 14),
              trailing: const Icon(Icons.arrow_forward_ios, size: 15),
            ),
            // const Divider(),
            // ListTile(
            //   contentPadding: EdgeInsets.zero,
            //   onTap: () {},
            //   title: Headtext(data: "Sickle Cell Test", fontsize: 14),
            //   trailing: const Icon(Icons.arrow_forward_ios, size: 15),
            // ),
            const Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: () => context.push(
                TestResults.id,
                extra: "Malaria Test Results",
              ),
              title: Headtext(data: "Malaria Test", fontsize: 14),
              trailing: const Icon(Icons.arrow_forward_ios, size: 15),
            ),
            const Divider(),
            // ListTile(
            //   contentPadding: EdgeInsets.zero,
            //   onTap: () => context.push(
            //     TestResults.id,
            //     extra: "Blood Group Test Results",
            //   ),
            //   title: Headtext(data: "Blood Group Test", fontsize: 14),
            //   trailing: const Icon(Icons.arrow_forward_ios, size: 15),
            // ),
            // const Divider(),
          ],
        ));
  }
}
