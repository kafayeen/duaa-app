import 'package:animate_do/animate_do.dart';
import 'package:duaa/presentation/components/reusable_components/constant.dart';
import 'package:duaa/presentation/screens/details/details.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share_plus/share_plus.dart';
import 'package:duaa/presentation/controller/duaa_cubit/duaa_cubit.dart';
import 'package:duaa/presentation/controller/duaa_states/duaa_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, text: "المفضلات"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<DuaaCubit, DuaaStates>(
                  builder: (context, state) {
                    var cubit = DuaaCubit.get(context);

                    return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => FadeInRight(
                        child: card(
                            favorites: () {
                              cubit.deleteDataId(
                                  id: cubit.favorites.reversed.toList()[index]
                                      ["id"]);
                            },
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.scale,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      child: Details(
                                          textAppBar: "المفضلة",
                                          text: cubit.favorites.reversed
                                              .toList()[index]["hadith"],
                                          // hadith,sona,name
                                          sona: cubit.favorites.reversed
                                                          .toList()[index]
                                                      ["sona"] ==
                                                  ""
                                              ? null
                                              : cubit.favorites.reversed
                                                  .toList()[index]["sona"],
                                          name: cubit.favorites.reversed
                                              .toList()[index]["name"]),
                                      alignment: Alignment.center));
                            },
                            context: context,
                            name: cubit.favorites.reversed.toList()[index]
                                ["name"],
                            hadith: cubit.favorites.reversed.toList()[index]
                                ["hadith"],
                            sona: cubit.favorites.reversed.toList()[index]
                                ["sona"]),
                      ),
                      itemCount: cubit.favorites.reversed.toList().length,
                      separatorBuilder: (context, index) => Padding(
                        padding: EdgeInsets.all(8.r),
                        child: Divider(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                    );
                  },
                  listener: (context, state) {}),
            ),
          ],
        ),
      ),
    );
  }
}

Widget card({
  required BuildContext context,
  required Function() onTap,
  required Function() favorites,
  required String hadith,
  required String sona,
  required String name,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8.r)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: name != ""
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.end,
            children: [
              if (name != "") ...[
                SizedBox(
                  width: 5.w,
                ),
                Expanded(
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleLarge!.fontSize,
                        color: Theme.of(context).scaffoldBackgroundColor),
                  ),
                ),
              ],
              Container(
                  width: 160.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(12.r),
                          topLeft: Radius.circular(8.r)),
                      color: Theme.of(context).scaffoldBackgroundColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Share.share("$name\n$hadith\n$sona",
                                subject: "$name\n$hadith\n$sona");
                          },
                          icon: Icon(
                            EvaIcons.share,
                            size: 25.r,
                            color: Theme.of(context).primaryColor,
                          )),
                      IconButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(
                                    text: "$sona\n$hadith\n$name"))
                                .then((value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      content: Text(
                                        "تم النسخ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      )));
                            });
                          },
                          icon: Icon(Icons.copy,
                              size: 25.r,
                              color: Theme.of(context).primaryColor)),
                      IconButton(
                          onPressed: favorites,
                          icon: Icon(
                            EvaIcons.bookmark,
                            size: 25.r,
                            color: Theme.of(context).primaryColor,
                          )),
                    ],
                  )),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.all(4.r),
            child: sona != ""
                ? Text(
                    "$sona\n$hadith",
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodySmall!.fontSize,
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).scaffoldBackgroundColor),
                  )
                : Text(
                    hadith,
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodySmall!.fontSize,
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).scaffoldBackgroundColor),
                  ),
          )
        ],
      ),
    ),
  );
}
