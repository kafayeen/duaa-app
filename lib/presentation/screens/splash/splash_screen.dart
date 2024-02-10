import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:duaa/core/local_service/shared_pref_service/shared_pref_service.dart';
import 'package:duaa/presentation/screens/drawer/zoom_drawer/zoom_drawer.dart';
import 'package:duaa/presentation/screens/on_boarding/on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool onBoard = CacheHelper.getData("onBoard") ?? false;
  @override
  void initState() {
    super.initState();
    if (onBoard) {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (ctx) => const ZoomDrawerWidget()),
            (route) => false);
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (ctx) => const OnBoarding()),
            (route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FadeOut(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.r),
                child: Container(
                    width: 180.w,
                    height: 180.h,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: Image.asset("assets/png/logo.png")),
              ),
              Text(
                  "(كُلُّ أُمَّتي يَدْخُلُونَ الجَنَّةَ إِلَّا مَن أَبَى، قالوا: يا رَسُولَ اللَّهِ، وَمَن يَأْبَى؟ قالَ: مَن أَطَاعَنِي دَخَلَ الجَنَّةَ، وَمَن عَصَانِي فقَدْ أَبَى)",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium)
            ],
          ),
        ),
      )),
    );
  }
}
