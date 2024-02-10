import 'package:duaa/presentation/screens/drawer/item_of_menu/youtube/youtube_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

class Youtube extends StatelessWidget {
  const Youtube({super.key});

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
                child: const YoutubeScreen(),
                alignment: Alignment.center));
      },
      title: Row(
        children: [
          Icon(
            Icons.youtube_searched_for_rounded,
            color: Theme.of(context).primaryColor,
            size: 25.r,
          ),
          SizedBox(
            width: 5.w,
          ),
          Expanded(
            child: Text(
              "قنوات لأخذ الفتاوى منها",
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                  color: Theme.of(context).primaryColor),
            ),
          )
        ],
      ),
    );
  }
}
