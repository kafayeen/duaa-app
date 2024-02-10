import 'package:duaa/presentation/screens/drawer/item_of_menu/about_us/about_us.dart';
import 'package:duaa/presentation/screens/drawer/item_of_menu/cancel/cancel.dart';
import 'package:duaa/presentation/screens/drawer/item_of_menu/change_mode/change_mode.dart';
import 'package:duaa/presentation/screens/drawer/item_of_menu/favorites/favorites.dart';
import 'package:duaa/presentation/screens/drawer/item_of_menu/notifications/notifications.dart';
import 'package:duaa/presentation/screens/drawer/item_of_menu/qebla/qebla.dart';
import 'package:duaa/presentation/screens/drawer/item_of_menu/sebha/sebha.dart';
import 'package:duaa/presentation/screens/drawer/item_of_menu/tabaroh/tabaroh.dart';
import 'package:duaa/presentation/screens/drawer/item_of_menu/youtube/youtube.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding:
            EdgeInsets.only(bottom: 10.h, top: 15.h, right: 8.w, left: 8.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                height: 100.h,
                width: 100.w,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: Image.asset("assets/png/logo.png"),
              ),
              SizedBox(
                height: 2.h,
              ),
              const ChangeMode(),
              SizedBox(
                height: 2.h,
              ),
              const Sebha(),
              SizedBox(
                height: 2.h,
              ),
              const Qebla(),
              SizedBox(
                height: 2.h,
              ),
              const Favorites(),
              SizedBox(
                height: 2.h,
              ),
              const AboutUs(),
              SizedBox(
                height: 2.h,
              ),
              const Youtube(),
              SizedBox(
                height: 2.h,
              ),
              const Notifications(),
              SizedBox(
                height: 2.h,
              ),
              const Tabaroh(),
              SizedBox(
                height: 2.h,
              ),
              const Cancel(),
              SizedBox(
                height: 2.h,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(4.r)),
                child: MaterialButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: Text(
                    "الخروج من التطبيق",
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleLarge!.fontSize,
                        color: Theme.of(context).scaffoldBackgroundColor),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
