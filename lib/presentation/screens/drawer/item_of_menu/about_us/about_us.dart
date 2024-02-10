import 'package:duaa/presentation/screens/drawer/item_of_menu/about_us/about_us_screen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      splashColor: Colors.transparent,
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.scale,
                duration: const Duration(milliseconds: 500),
                child: const AboutUsScreen(),
                alignment: Alignment.center));
      },
      title: Row(
        children: [
          Icon(
            EvaIcons.info,
            color: Theme.of(context).primaryColor,
            size: 25.r,
          ),
          SizedBox(
            width: 5.w,
          ),
          Text(
            "عنا",
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                color: Theme.of(context).primaryColor),
          )
        ],
      ),
    );
  }
}
