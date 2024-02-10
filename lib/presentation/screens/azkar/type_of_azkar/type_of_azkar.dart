import 'package:duaa/core/local_service/database/azkar/azkar.dart';
import 'package:duaa/presentation/components/reusable_components/constant.dart';
import 'package:duaa/presentation/screens/azkar/read_azkar/hundred_duaa.dart';
import 'package:duaa/presentation/screens/azkar/read_azkar/azkar.dart';
import 'package:duaa/presentation/screens/azkar/read_azkar/azkar_sala.dart';
import 'package:duaa/presentation/screens/azkar/read_azkar/hesn_elwaky.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

class TypeOfAzkarScreen extends StatelessWidget {
  const TypeOfAzkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, text: "قائمة الأذكار"),
      body: Padding(
        padding: EdgeInsets.all(8.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            listTile(
                context: context,
                number: "1.",
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.scale,
                          duration: const Duration(milliseconds: 500),
                          child: const HesnElWakyScreen(),
                          alignment: Alignment.center));
                },
                title: "حصن الواقى"),
            SizedBox(
              height: 10.h,
            ),
            listTile(
                context: context,
                number: "2.",
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.scale,
                          duration: const Duration(milliseconds: 500),
                          child: const ListOfDuaa(),
                          alignment: Alignment.center));
                },
                title: "مئة دعاء من كتاب و سنة الصحيحة"),
            SizedBox(
              height: 10.h,
            ),
            listTile(
                context: context,
                number: "3.",
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.scale,
                          duration: const Duration(milliseconds: 500),
                          child: const AzkarSalaScreen(),
                          alignment: Alignment.center));
                },
                title: "أذكار بعد كل صلاة"),
            SizedBox(
              height: 10.h,
            ),
            listTile(
                context: context,
                number: "4.",
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.scale,
                          duration: const Duration(milliseconds: 500),
                          child: AzkarScreen(zekr: AzkarDataBase.azkar),
                          alignment: Alignment.center));
                },
                title: "أذكار متنوعة"),
          ],
        ),
      ),
    );
  }
}

Widget listTile(
    {required String number,
    required Function() onTap,
    required String title,
    required BuildContext context}) {
  return Card(
    color: Theme.of(context).primaryColor,
    child: ListTile(
      leading: Text(
        number,
        style: TextStyle(
            fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
            color: Theme.of(context).scaffoldBackgroundColor),
      ),
      onTap: onTap,
      title: Text(
        title,
        style: TextStyle(
            fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
            color: Theme.of(context).scaffoldBackgroundColor),
      ),
    ),
  );
}
