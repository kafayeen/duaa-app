import 'package:duaa/core/local_service/database/azkar/lists_of_duaa.dart';
import 'package:duaa/domain/entites/azkar_entites/azkar_entites.dart';
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

class ListOfDuaa extends StatelessWidget {
  const ListOfDuaa({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DuaaCubit, DuaaStates>(
        builder: (context, state) {
          var cubit = DuaaCubit.get(context);
          List hundred = [];
          for (var element in cubit.favorites) {
            if (element["type"] == "مئة دعاء") {
              hundred.add(element["hadith"]);
            }
          }
          List<AzkarEntites> duaa = [];
          for (var element in ListsOfDuaaDataBase.duaa) {
            if (element.text != "" && element.text != " ") {
              duaa.add(element);
            }
          }
          return Scaffold(
            appBar: appBar(context: context, text: "مئة دعاء"),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => card(
                              check: hundred.isNotEmpty
                                  ? (hundred.contains(duaa[index].text)
                                      ? true
                                      : false)
                                  : false,
                              favorites: hundred.contains(duaa[index].text)
                                  ? () {
                                      cubit.deleteDataHadith(
                                          hadith: duaa[index].text);
                                    }
                                  : () {
                                      cubit.insert(
                                        type: "مئة دعاء",
                                        hadith: duaa[index].text,
                                        name: "",
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
                                      //                 textAppBar: "مئة حديث",
                                      //                 text: duaa[index].text,
                                      //                 name: duaa[index].bab),
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
                                            textAppBar: "مئة حديث",
                                            text: duaa[index].text,
                                            name: duaa[index].bab),
                                        alignment: Alignment.center));
                              },
                              context: context,
                              bab: duaa[index].bab,
                              text: duaa[index].text),
                          itemCount: duaa.length,
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

//
Widget card(
    {required BuildContext context,
    required String bab,
    required Function() onTap,
    required Function() favorites,
    required bool check,
    required String text}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      if (bab != "" && bab != " ") ...[
        Text(
          bab,
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
              color: Theme.of(context).primaryColor),
        ),
        SizedBox(
          height: 8.h,
        ),
      ],
      GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(8.r)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                                Share.share("$bab\n$text",
                                    subject: "$bab\n$text");
                              },
                              icon: Icon(
                                EvaIcons.share,
                                size: 25.r,
                                color: Theme.of(context).primaryColor,
                              )),
                          IconButton(
                              onPressed: () {
                                Clipboard.setData(
                                        ClipboardData(text: "$bab\n$text"))
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
                  text,
                  style: TextStyle(
                      fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).scaffoldBackgroundColor),
                ),
              )
            ],
          ),
        ),
      ),
    ],
  );
}
