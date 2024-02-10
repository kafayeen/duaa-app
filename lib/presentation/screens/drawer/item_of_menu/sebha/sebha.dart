import 'package:duaa/presentation/screens/drawer/item_of_menu/sebha/sebha_screen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

class Sebha extends StatelessWidget {
  const Sebha({super.key});

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
                child: const SebhaScreen(),
                alignment: Alignment.center));
      },
      title: Row(
        children: [
          Icon(
            EvaIcons.plus,
            color: Theme.of(context).primaryColor,
            size: 25.r,
          ),
          SizedBox(
            width: 5.w,
          ),
          Text(
            "السبحة",
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                color: Theme.of(context).primaryColor),
          )
        ],
      ),
    );
  }
}
