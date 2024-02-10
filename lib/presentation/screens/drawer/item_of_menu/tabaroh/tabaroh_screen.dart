import 'package:duaa/presentation/components/reusable_components/constant.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class TabarohScreen extends StatelessWidget {
  const TabarohScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Function()> onTap = [
      () {
        launchUrl(Uri.parse(
            "https://play.freerice.com/categories/basic-math-pre-algebra"));
      },
      () {
        launchUrl(Uri.parse("https://www.myf-egypt.org/ar/donation/"));
      },
      () {
        launchUrl(Uri.parse("https://www.ehsan.sa"));
      },
      () {
        launchUrl(Uri.parse("https://www.mekeg.org"));
      },
      () {
        launchUrl(Uri.parse("https://www.yallagive.com/ar"));
      },
      () {
        launchUrl(Uri.parse("https://www.ihrelief.org/ar"));
      }
    ];
    List text = [
      "موقع مجانى كل سؤال تجيب عليه يتبرع ب أرزة للمحتاجين",
      "لتبرع لمؤسسة مجدى يعقوب",
      "لتبرع للمحتاجين فى منصة إحسان السعودية",
      "لتبرع فى مؤسسة مصر الخير",
      "منصة إماراتية yall give",
      "هيئة الإغاثة الإنسانية الدولية",
    ];
    return Scaffold(
      appBar: appBar(context: context, text: "دعم و تبرع"),
      body: Padding(
        padding: EdgeInsets.all(10.r),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Image.asset(
                    "assets/png/logo.png",
                    fit: BoxFit.cover,
                    height: 90.h,
                    width: 90.w,
                  ),
                ),
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) => listTile(
                      onTap: onTap[index],
                      context: context,
                      text: text[index],
                      iconData: EvaIcons.search),
                  separatorBuilder: (ctx, index) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Divider(
                          color: Theme.of(context).textTheme.titleLarge!.color,
                        ),
                      ),
                  itemCount: text.length)
            ],
          ),
        ),
      ),
    );
  }
}

Widget listTile(
    {required BuildContext context,
    required String text,
    required Function() onTap,
    required IconData iconData}) {
  return Card(
    color: Theme.of(context).primaryColor,
    child: InkWell(
      onTap: onTap,
      child: ListTile(
        leading: Icon(
          iconData,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        title: Text(
          text,
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).scaffoldBackgroundColor),
        ),
      ),
    ),
  );
}
