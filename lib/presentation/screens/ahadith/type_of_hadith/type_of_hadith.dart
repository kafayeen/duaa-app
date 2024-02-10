import 'package:duaa/core/local_service/database/ahadith/hadith_database/hadith_database.dart';
import 'package:duaa/core/local_service/database/ahadith/hadith_ghadab_database/hadith_ghadab_database.dart';
import 'package:duaa/core/local_service/database/ahadith/hadith_katel_database/hadith_katel_database.dart';
import 'package:duaa/core/local_service/database/ahadith/hadith_la_ys7/hadith_la_ys7.dart';
import 'package:duaa/core/local_service/database/ahadith/hadith_tabasom_database/hadith_tabasom_database.dart';
import 'package:duaa/domain/entites/ahadiths_entites/hadith_database.dart';
import 'package:duaa/presentation/components/reusable_components/constant.dart';
import 'package:duaa/presentation/screens/ahadith/read_the_hadith/read_the_hadith.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

class TypeOfHadithScreen extends StatelessWidget {
  const TypeOfHadithScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, text: "قائمة الأحاديث"),
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
                          child: ReadTheHadithScreen(
                              text: "احاديث لا تصح",
                              hadiths: HadithsInCorrect.hadithIncorrect),
                          alignment: Alignment.center));
                },
                title: "أحاديث لا تصح"),
            SizedBox(
              height: 10.h,
            ),
            listTile(
                context: context,
                number: "2.",
                onTap: () {
                  List<Hadith> hadiths = [];
                  for (var element in HadithsTabasomDataBase.hadithTabasom) {
                    if (element.hadith == "مواقف ابتسم فيها الرسول") {
                      hadiths.add(element);
                    }
                  }
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.scale,
                          duration: const Duration(milliseconds: 500),
                          child: ReadTheHadithScreen(
                              hadiths: hadiths, text: "ضحك الرسول"),
                          alignment: Alignment.center));
                },
                title: "مواقف ضحك فيها الرسول"),
            SizedBox(
              height: 10.h,
            ),
            listTile(
                context: context,
                number: "3.",
                onTap: () {
                  List<Hadith> hadiths = [];
                  for (var element in HadithsTabasomDataBase.hadithTabasom) {
                    if (element.hadith != "مواقف ابتسم فيها الرسول") {
                      hadiths.add(element);
                    }
                  }
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.scale,
                          duration: const Duration(milliseconds: 500),
                          child: ReadTheHadithScreen(
                              hadiths: hadiths, text: "مزاح الرسول"),
                          alignment: Alignment.center));
                },
                title: "مواقف لمزاح الرسول"),
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
                          child: ReadTheHadithScreen(
                              text: "حيوانات تُقْتَل",
                              hadiths: HadithsKatel.hadithKatel),
                          alignment: Alignment.center));
                },
                title: "حيوانات يجب أن نقتلها"),
            SizedBox(
              height: 10.h,
            ),
            listTile(
                context: context,
                number: "5.",
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.scale,
                          duration: const Duration(milliseconds: 450),
                          child: ReadTheHadithScreen(
                              text: "غضب الرسول",
                              hadiths: HadithsGhadab.hadithGhadab),
                          alignment: Alignment.center));
                },
                title: "مواقف غضب فيها الرسول"),
            SizedBox(
              height: 10.h,
            ),
            listTile(
                context: context,
                number: "6.",
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.scale,
                          duration: const Duration(milliseconds: 500),
                          child: ReadTheHadithScreen(
                              text: "أحاديث متنوعة",
                              hadiths: HadithsDataBase.listhadiths),
                          alignment: Alignment.center));
                },
                title: "أحاديث متنوعة"),
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
