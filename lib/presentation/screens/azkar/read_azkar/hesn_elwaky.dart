import 'package:duaa/core/local_service/database/azkar/hesn_elwaky.dart';
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

class HesnElWakyScreen extends StatelessWidget {
  const HesnElWakyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DuaaCubit, DuaaStates>(
        builder: (context, state) {
          var cubit = DuaaCubit.get(context);
          List hesn = [];
          for (var element in cubit.favorites) {
            if (element["type"] == "حصن الواقى") {
              hesn.add(element["hadith"]);
            }
          }
          return Scaffold(
            appBar: appBar(context: context, text: "الحصن الواقى"),
            body: Padding(
              padding: EdgeInsets.all(12.r),
              child: Column(
                children: [
                  Text(
                    "جميع الأحاديث الصحيحة",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "لم يتم ذكر الفاتحة لأنها لم ترد عن الرسول انها ورد يومى و إنما وردت علاجاََ فهى للحاجة فقط",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "صفد الله لك الشياطين فى رمضان،و رزقك الأذكار لتصفدهم فى كل آن",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Padding(
                      padding: EdgeInsets.all(8.r),
                      child: Divider(
                        color: Theme.of(context).primaryColor,
                      )),
                  Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) => card(
                                check: hesn.isNotEmpty
                                    ? (hesn.contains(
                                        "${HesnElWakyDataBase.hesn[index].azkar}\n${HesnElWakyDataBase.hesn[index].fadlha}",
                                      )
                                        ? true
                                        : false)
                                    : false,
                                favorites: hesn.contains(
                                  "${HesnElWakyDataBase.hesn[index].azkar}\n${HesnElWakyDataBase.hesn[index].fadlha}",
                                )
                                    ? () {
                                        cubit.deleteDataHadith(
                                          hadith:
                                              "${HesnElWakyDataBase.hesn[index].azkar}\n${HesnElWakyDataBase.hesn[index].fadlha}",
                                        );
                                      }
                                    : () {
                                        cubit.insert(
                                          type: "حصن الواقى",
                                          hadith:
                                              "${HesnElWakyDataBase.hesn[index].azkar}\n${HesnElWakyDataBase.hesn[index].fadlha}",
                                          name: HesnElWakyDataBase
                                              .hesn[index].tariqa,
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
                                        //                 textAppBar: "حصن الواقى",
                                        //                 text:
                                        //                     "${HesnElWakyDataBase.hesn[index].azkar}\n${HesnElWakyDataBase.hesn[index].fadlha}",
                                        //                 name: HesnElWakyDataBase
                                        //                     .hesn[index].tariqa),
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
                                              const Duration(milliseconds: 300),
                                          child: Details(
                                              textAppBar: "حصن الواقى",
                                              text:
                                                  "${HesnElWakyDataBase.hesn[index].azkar}\n${HesnElWakyDataBase.hesn[index].fadlha}",
                                              name: HesnElWakyDataBase
                                                  .hesn[index].tariqa),
                                          alignment: Alignment.center));
                                },
                                context: context,
                                zekr: HesnElWakyDataBase.hesn[index].azkar,
                                tariqa: HesnElWakyDataBase.hesn[index].tariqa,
                                fadlha: HesnElWakyDataBase.hesn[index].fadlha,
                              ),
                          separatorBuilder: (context, index) => Divider(
                                thickness: 0.6,
                                color: Theme.of(context).primaryColor,
                              ),
                          itemCount: HesnElWakyDataBase.hesn.length))
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
    required Function() onTap,
    required Function() favorites,
    required String zekr,
    required String tariqa,
    required String fadlha,
    required bool check}) {
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
              Expanded(
                child: Text(
                  tariqa,
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
                            Share.share("$tariqa\n$zekr\n$fadlha",
                                subject: "$tariqa\n$zekr\n$fadlha");
                          },
                          icon: Icon(
                            EvaIcons.share,
                            size: 25.r,
                            color: Theme.of(context).primaryColor,
                          )),
                      IconButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(
                                    text: "$tariqa\n$zekr\n$fadlha"))
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
              "$zekr\n$fadlha",
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
