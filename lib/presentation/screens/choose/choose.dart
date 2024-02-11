import 'package:animate_do/animate_do.dart';
import 'package:duaa/core/local_service/database/madih_naby/madih_naby.dart';
import 'package:duaa/core/local_service/database/sonan_mahgora_database/sonan_mahgora_database.dart';
import 'package:duaa/presentation/controller/duaa_cubit/duaa_cubit.dart';
import 'package:duaa/presentation/controller/duaa_states/duaa_states.dart';
import 'package:duaa/presentation/screens/ahadith/type_of_hadith/type_of_hadith.dart';
import 'package:duaa/presentation/screens/azkar/type_of_azkar/type_of_azkar.dart';
import 'package:duaa/presentation/screens/madih_naby/madih_naby.dart';
import 'package:duaa/presentation/screens/quran/choose_sorah/choose_sorah.dart';
import 'package:duaa/presentation/screens/sala/mwakit_sala.dart';
import 'package:duaa/presentation/screens/sonan_mahgora/sonan_mahgora.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

class Choose extends StatelessWidget {
  const Choose({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DuaaCubit, DuaaStates>(
        builder: (context, state) {
          var cubit = DuaaCubit.get(context);
          cubit.position = null;
          if (cubit.delete) {
            cubit.deleteCountry();
          }
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: Text(
                "منارة التوحيد",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              actions: [
                IconButton(
                    onPressed: () {
                      cubit.toggle();
                    },
                    icon: Icon(
                      EvaIcons.menu2,
                      color: Theme.of(context).primaryColor,
                      size: 30.r,
                    ))
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 50.r),
              child: FadeInRight(
                child: PageView(
                  reverse: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    card(
                        context: context,
                        text: "القرآن الكريم",
                        image: "assets/png/quran.png",
                        function: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.scale,
                                  duration: const Duration(milliseconds: 500),
                                  child: const ChooseSorah(),
                                  alignment: Alignment.center));
                        }),
                    card(
                        context: context,
                        text: "مواقيت الصلاة",
                        image: "assets/png/islamic.png",
                        function: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.scale,
                                  duration: const Duration(milliseconds: 500),
                                  child: const MwakitSala(),
                                  alignment: Alignment.center));
                        }),
                    card(
                        context: context,
                        text: "الأحاديث النبوية",
                        image: "assets/png/dua.png",
                        function: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.scale,
                                  duration: const Duration(milliseconds: 500),
                                  child: const TypeOfHadithScreen(),
                                  alignment: Alignment.center));
                        }),
                    card(
                        context: context,
                        text: "الأذكار",
                        image: "assets/png/prayer-rug.png",
                        function: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.scale,
                                  duration: const Duration(milliseconds: 500),
                                  child: const TypeOfAzkarScreen(),
                                  alignment: Alignment.center));
                        }),
                    card(
                        context: context,
                        text: "سنن مهجورة",
                        image: "assets/png/prayer.png",
                        function: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.scale,
                                  duration: const Duration(milliseconds: 500),
                                  child: SonanMahgoraScreen(
                                    sona: HadithsMahgoraDataBase.hadithMahgora,
                                  ),
                                  alignment: Alignment.center));
                        }),
                    card(
                        context: context,
                        text: "مدح النبى",
                        image: "assets/png/play.png",
                        function: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.scale,
                                  duration: const Duration(milliseconds: 500),
                                  child: MadihNabyScreen(
                                    madih: MadihNaby.listMadihNaby,
                                  ),
                                  alignment: Alignment.center));
                        }),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}

Widget card(
    {required BuildContext context,
    required String text,
    required String image,
    required Function() function}) {
  return Padding(
    padding: EdgeInsets.all(12.r),
    child: GestureDetector(
      onTap: function,
      child: Card(
        shadowColor: Theme.of(context).primaryColor,
        elevation: 3,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.w)),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: double.infinity,
          decoration: BoxDecoration(
            border:
                Border.all(width: 0.2, color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(10.w),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).scaffoldBackgroundColor,
              ],
              stops: const [0, 0.5],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(""),
              const Text(""),
              if (image == "assets/png/play.png")
                SizedBox(
                  height: 90.h,
                  width: 90.w,
                  child: Image.asset(
                    image,
                    fit: BoxFit.fill,
                  ),
                ),
              if (image != "assets/png/play.png")
                SizedBox(
                  height: 135.h,
                  width: 135.w,
                  child: Image.asset(
                    image,
                    fit: BoxFit.fill,
                  ),
                ),
              Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Text(""),
              const Text("")
            ],
          ),
        ),
      ),
    ),
  );
}
