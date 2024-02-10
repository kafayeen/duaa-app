import 'package:animate_do/animate_do.dart';
import 'package:duaa/core/local_service/shared_pref_service/shared_pref_service.dart';
import 'package:duaa/presentation/screens/drawer/zoom_drawer/zoom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController pageController = PageController();

  int i = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          children: [
            Expanded(
                child: FadeInRight(
              child: PageView(
                controller: pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    onBoarding(index);
                  });
                },
                children: [
                  column(
                      text: "تطبيق يحتوى على كل ما يخص المسلم",
                      context: context),
                  column(
                      text: "يُوفر خاصية قراءة القرآن الكريم",
                      context: context),
                  column(
                      text: "يحتوي على مختلف الأذكار و الأحاديث",
                      context: context),
                  column(text: "مواقيت الصلاة و قبلة", context: context),
                  column(text: "العديد من الاذكار الصحيحة", context: context),
                  column(text: "السنن المهجورة عن النبى", context: context),
                ],
              ),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SmoothPageIndicator(
                        controller: pageController,
                        count: 6,
                        effect: ExpandingDotsEffect(
                            dotColor: Colors.yellow,
                            activeDotColor: Theme.of(context).primaryColor,
                            dotHeight: 8.5.h,
                            dotWidth: 8.5.w,
                            spacing: 7.w,
                            expansionFactor: 3.5)),
                    SizedBox(
                      height: 12.h,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.w),
                            color: Theme.of(context).primaryColor),
                        child: MaterialButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            setState(() {
                              if (i < 5) {
                                pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.decelerate);
                              } else if (i == 5) {
                                CacheHelper.putData("onBoard", true)
                                    .then((value) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) =>
                                              const ZoomDrawerWidget()),
                                      (route) => false);
                                });
                              }
                            });
                          },
                          child: Text(i == 5 ? "موافق" : "التالى",
                              style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .fontSize,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor)),
                        )),
                  ],
                )
              ],
            )
          ],
        ),
      )),
    );
  }

  void onBoarding(int index) {
    i = index;
  }
}

Widget column({required String text, required BuildContext context}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
          width: 250.w,
          height: 250.h,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: Image.asset(
            "assets/png/logo.png",
          )),
      Text(text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium),
    ],
  );
}
