import 'package:duaa/domain/entites/sonan_entites/sonan_mahgora_database.dart';
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

class SonanMahgoraScreen extends StatelessWidget {
  final List<SonanMahgoraEntites> sona;
  const SonanMahgoraScreen({super.key, required this.sona});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DuaaCubit, DuaaStates>(
        builder: (context, state) {
          var cubit = DuaaCubit.get(context);

          return Scaffold(
            appBar: appBar(context: context, text: "سنن مهجورة"),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            List sonan = [];
                            for (var element in cubit.favorites) {
                              if (element["type"] == "سنن مهجورة") {
                                sonan.add(element["hadith"]);
                              }
                            }

                            return card(
                                context: context,
                                check: sonan.isNotEmpty
                                    ? (sonan.contains(sona[index].textHadith)
                                        ? true
                                        : false)
                                    : false,
                                favorites:
                                    sonan.contains(sona[index].textHadith)
                                        ? () {
                                            cubit.deleteDataHadith(
                                                hadith: sona[index].textHadith);
                                          }
                                        : () {
                                            cubit.insert(
                                              type: "سنن مهجورة",
                                              hadith: sona[index].textHadith,
                                              name: sona[index].sona,
                                              sona: sona[index].name,
                                            );
                                            // cubit.popScope = true;
                                            // Navigator.push(
                                            //         context,
                                            //         PageTransition(
                                            //             type: PageTransitionType.scale,
                                            //             duration: const Duration(
                                            //                 milliseconds: 300),
                                            //             child: Details(
                                            //                 textAppBar: "سنن مهجورة",
                                            //                 text: sona[index].textHadith,
                                            //                 sona: sona[index].sona,
                                            //                 name: sona[index].name),
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
                                              textAppBar: "سنن مهجورة",
                                              text: sona[index].textHadith,
                                              sona: sona[index].sona,
                                              name: sona[index].name),
                                          alignment: Alignment.center));
                                },
                                hadith: sona[index].textHadith,
                                name: sona[index].sona,
                                sona: sona[index].name,
                                type: sona[index].type);
                          },
                          itemCount: sona.length,
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
    required String sona,
    required String name,
    required Function() favorites,
    required String type,
    required Function() onTap,
    required bool check,
    required String hadith}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        type,
        style: TextStyle(
            fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
            color: Theme.of(context).primaryColor),
      ),
      SizedBox(
        height: 8.h,
      ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 5.w,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .fontSize,
                              color: Theme.of(context).scaffoldBackgroundColor),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          sona,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .fontSize,
                              color: Theme.of(context).scaffoldBackgroundColor),
                        ),
                      ],
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
                                Share.share("$type\n$sona\n$name\n$hadith",
                                    subject: "$name\n$hadith");
                              },
                              icon: Icon(
                                EvaIcons.share,
                                size: 25.r,
                                color: Theme.of(context).primaryColor,
                              )),
                          IconButton(
                              onPressed: () {
                                Clipboard.setData(ClipboardData(
                                        text: "$sona\n$name\n$hadith"))
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
      ),
    ],
  );
}
