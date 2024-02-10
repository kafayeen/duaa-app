import 'package:duaa/presentation/controller/duaa_cubit/duaa_cubit.dart';
import 'package:duaa/presentation/controller/duaa_states/duaa_states.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screenshot/screenshot.dart';

class Details extends StatelessWidget {
  final String name;
  final String text;
  final String? sona;
  final String textAppBar;

  const Details(
      {super.key,
      required this.text,
      required this.textAppBar,
      required this.name,
      this.sona});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DuaaCubit, DuaaStates>(builder: (context, state) {
      var cubit = DuaaCubit.get(context);
      // if (cubit.popScope == true) {
      //   return PopScope(
      //     canPop: false,
      //     child: Scaffold(
      //       appBar: appBar(context: context, text: "ألتقاط صورة"),
      //       body: Screenshot(
      //         controller: cubit.screenshotController,
      //         key: UniqueKey(),
      //         child: Padding(
      //             padding: EdgeInsets.all(12.r),
      //             child: card(
      //                 context: context, name: name, sona: sona, hadith: text)),
      //       ),
      //     ),
      //   );
      // } else {
      // cubit.screenShot(context: context);

      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            textAppBar,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).primaryColor,
                ))
          ],
          leading: IconButton(
              onPressed: () {
                cubit.screenShot(context: context);
              },
              icon: Icon(
                EvaIcons.camera,
                size: 25.r,
                color: Theme.of(context).primaryColor,
              )),
        ),
        body: Screenshot(
          controller: cubit.screenshotController,
          key: UniqueKey(),
          child: Padding(
              padding: EdgeInsets.all(12.r),
              child:
                  card(context: context, name: name, sona: sona, hadith: text)),
        ),
      );
      // }
    }, listener: (context, state) {
      var cubit = DuaaCubit.get(context);
      if (state is DuaaScreenShotSuccessState || cubit.image != null) {
        Navigator.pop(context);
      }
    });
  }
}

Widget card(
    {required BuildContext context,
    String? sona,
    required String name,
    required String hadith}) {
  return Container(
    width: double.infinity,
    height: double.infinity,
    padding: EdgeInsets.all(4.r),
    decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(8.r)),
    child: SingleChildScrollView(
      child: Column(
        children: [
          if (sona != null) ...[
            SizedBox(
              height: 4.h,
            ),
            Text(
              sona,
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                  color: Theme.of(context).scaffoldBackgroundColor),
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
          Text(
            name,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                color: Theme.of(context).scaffoldBackgroundColor),
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
