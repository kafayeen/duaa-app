import 'package:duaa/core/local_service/database/ahadith/hadith_database/hadith_database.dart';
import 'package:duaa/core/local_service/database/ahadith/hadith_la_ys7/hadith_la_ys7.dart';
import 'package:duaa/presentation/components/reusable_components/constant.dart';
import 'package:duaa/presentation/controller/duaa_cubit/duaa_cubit.dart';
import 'package:duaa/presentation/controller/duaa_states/duaa_states.dart';
import 'package:duaa/presentation/screens/details/details.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share_plus/share_plus.dart';

class ReadTheHadithScreen extends StatelessWidget {
  final List<dynamic> hadiths;
  final String text;
  const ReadTheHadithScreen(
      {super.key, required this.text, required this.hadiths});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DuaaCubit, DuaaStates>(
        builder: (context, state) {
          var cubit = DuaaCubit.get(context);
          List readHadith = [];
          for (var element in cubit.favorites) {
            if (element["type"] == "احاديث") {
              readHadith.add(element["hadith"]);
            }
          }
          return Scaffold(
            appBar: appBar(context: context, text: text),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => card(
                                check: readHadith.isNotEmpty
                                    ? (readHadith
                                            .contains(hadiths[index].textHadith)
                                        ? true
                                        : false)
                                    : false,
                                favorites: readHadith
                                        .contains(hadiths[index].textHadith)
                                    ? () {
                                        cubit.deleteDataHadith(
                                            hadith: hadiths[index].textHadith);
                                      }
                                    : () {
                                        cubit.insert(
                                          type: "احاديث",
                                          hadith: hadiths[index].textHadith,
                                          name: hadiths[index].name,
                                          sona: "",
                                        );

                                        // cubit.popScope = true;
                                        // Navigator.push(
                                        //         context,
                                        //         PageTransition(
                                        //             type: PageTransitionType.scale,
                                        //             duration: const Duration(
                                        //                 milliseconds: 300),
                                        //             child: Details(
                                        //                 textAppBar: "قراءة الأحاديث",
                                        //                 text:
                                        //                     hadiths[index].textHadith,
                                        //                 name: hadiths[index].name),
                                        //             alignment: Alignment.center))
                                        //     .then((value) {
                                        //   ScaffoldMessenger.of(context).showSnackBar(
                                        //       SnackBar(
                                        //           backgroundColor: Theme.of(context)
                                        //               .scaffoldBackgroundColor,
                                        //           content: Text(
                                        //             "تم الألتقاط",
                                        //             style: Theme.of(context)
                                        //                 .textTheme
                                        //                 .titleLarge,
                                        //           )));
                                        // });
                                        // Timer(const Duration(seconds: 1), () {
                                        //   cubit.screenShot(context: context);
                                        // });
                                      },
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.scale,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          child: Details(
                                              textAppBar: "قراءة الأحاديث",
                                              text: hadiths[index].textHadith,
                                              name: hadiths[index].name),
                                          alignment: Alignment.center));
                                },
                                context: context,
                                name: List is HadithsInCorrect ||
                                        List is HadithsDataBase
                                    ? hadiths[index].hadith
                                    : hadiths[index].name,
                                hadith: hadiths[index].textHadith,
                              ),
                          itemCount: hadiths.length,
                          separatorBuilder: (context, index) => Padding(
                                padding: EdgeInsets.all(8.r),
                                child: Divider(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
                                ),
                              )))
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}

Widget card(
    {required BuildContext context,
    required String name,
    required Function() onTap,
    required Function() favorites,
    required bool check,
    required String hadith}) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 5.w,
              ),
              if (name != "" || name != " ")
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
                            Share.share("$name\n$hadith", subject: hadith);
                          },
                          icon: Icon(
                            EvaIcons.share,
                            size: 25.r,
                            color: Theme.of(context).primaryColor,
                          )),
                      IconButton(
                          onPressed: () {
                            Clipboard.setData(
                                    ClipboardData(text: "$name\n$hadith"))
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
                          icon: check
                              ? Icon(
                                  EvaIcons.bookmark,
                                  size: 25.r,
                                  color: Theme.of(context).primaryColor,
                                )
                              : Icon(
                                  EvaIcons.bookmarkOutline,
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
            child: Text(
              hadith,
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).scaffoldBackgroundColor),
            ),
          )
        ],
      ),
    ),
  );
}
