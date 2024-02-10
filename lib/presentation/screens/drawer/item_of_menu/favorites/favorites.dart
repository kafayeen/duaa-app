import 'package:duaa/presentation/screens/drawer/item_of_menu/favorites/favorites_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

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
                child: const FavoritesScreen(),
                alignment: Alignment.center));
      },
      title: Row(
        children: [
          Icon(
            EvaIcons.bookmark,
            color: Theme.of(context).primaryColor,
            size: 25.r,
          ),
          SizedBox(
            width: 5.w,
          ),
          Text(
            "المفضلات",
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                color: Theme.of(context).primaryColor),
          )
        ],
      ),
    );
  }
}
