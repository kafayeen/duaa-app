import 'package:duaa/presentation/components/reusable_components/constant.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List icon = [
      EvaIcons.messageSquare,
      EvaIcons.messageCircle,
      EvaIcons.person,
      EvaIcons.bookOpen,
      EvaIcons.bookOpen,
      EvaIcons.bookOpen,
      Icons.attach_money_rounded,
    ];
    List text = [
      "تابعنا على الإنستجرام",
      "للشكاوى و المقترحات راسلنا",
      "نسألكم الدعاء لنا. حديث دعاء اربعين شخص غريب مستجابة 'لايصح' ",
      "تم الاستعانة بكتاب الأربعين فى ضحك الصادق الأمين - الشيخ محمد بن شمس الدين",
      "الحصن الواقى مختصرة من كتاب الحصن الواقى - الشيخ عبدالله بن محمد السدحان",
      "مئة دعاء من الكتاب والسنة الصحيحة - محمد صالح المنجد",
      "التطبيق مجانى خالى من الاعلانات",
    ];
    List<Function()> onTap = [
      () async {
        if (await canLaunchUrl(
            Uri.parse("https://www.instagram.com/kafayeen/"))) {
          launchUrl(Uri.parse("https://www.instagram.com/kafayeen/"));
        }
      },
      () async {
        if (await canLaunchUrl(Uri.parse("mailto:kabatchawork@gmail.com"))) {
          launchUrl(Uri.parse("mailto:kabatchawork@gmail.com"));
        }
      },
      () {},
      () {},
      () {},
      () {},
      () {},
    ];
    return Scaffold(
      appBar: appBar(context: context, text: "عن التطبيق"),
      body: SingleChildScrollView(
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
                  )),
            ),
            Padding(
              padding: EdgeInsets.all(10.r),
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) => listTile(
                      onTap: onTap[index],
                      context: context,
                      text: text[index],
                      iconData: icon[index]),
                  separatorBuilder: (ctx, index) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Divider(
                          color: Theme.of(context).textTheme.titleLarge!.color,
                        ),
                      ),
                  itemCount: text.length),
            ),
          ],
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
          size: 25.r,
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
