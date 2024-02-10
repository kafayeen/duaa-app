import 'package:duaa/presentation/components/reusable_components/constant.dart';
import 'package:duaa/presentation/screens/quran/read_sorah/read_sorah.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quran/quran.dart' as quran;

class ChooseSorah extends StatelessWidget {
  const ChooseSorah({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, text: "أختر السورة"),
      body: Padding(
          padding: EdgeInsets.all(16.r),
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (ctx, i) => nameOfSorah(
                context: context,
                type:
                    "${quran.getPlaceOfRevelation(i + 1)} - ${quran.getVerseCount(i + 1)}",
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.scale,
                          duration: const Duration(milliseconds: 500),
                          child: ReadSorah(
                              text: quran.getSurahNameArabic(i + 1),
                              verseNumber: quran.getVerseCount(i + 1),
                              numberOfSorah: i + 1),
                          alignment: Alignment.center));
                },
                index: i,
                sorah: quran.getSurahNameArabic(i + 1)),
            itemCount: 114,
            separatorBuilder: (ctx, i) => Padding(
              padding: EdgeInsets.all(8.r),
              child: Divider(
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          )),
    );
  }
}

Widget nameOfSorah(
    {required BuildContext context,
    required Function() onTap,
    required int index,
    required String type,
    required String sorah}) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      color: Theme.of(context).primaryColor,
      child: ListTile(
        leading: Text(
          "${index + 1}. ",
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
              color: Theme.of(context).scaffoldBackgroundColor),
        ),
        title: Text(
          sorah,
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
              color: Theme.of(context).scaffoldBackgroundColor),
        ),
        trailing: Text(
          type,
          style: TextStyle(
              fontSize: 12.sp,
              color: Theme.of(context).scaffoldBackgroundColor),
        ),
      ),
    ),
  );
}
