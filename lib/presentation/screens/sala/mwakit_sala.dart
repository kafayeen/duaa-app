import 'dart:developer';
import 'package:duaa/presentation/controller/duaa_cubit/duaa_cubit.dart';
import 'package:duaa/presentation/controller/duaa_states/duaa_states.dart';
import 'package:duaa/presentation/screens/drawer/zoom_drawer/zoom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MwakitSala extends StatelessWidget {
  const MwakitSala({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DuaaCubit, DuaaStates>(
      builder: (context, state) {
        var cubit = DuaaCubit.get(context);
        log("${cubit.country}");
        if (cubit.country == null) {
          cubit.locateUser(context: context);
        }
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.r),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                        )),
                    child: MaterialButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onPressed: () {
                        cubit.delete = true;
                        if (cubit.delete) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => const ZoomDrawerWidget()),
                              (r) => false);
                        }
                      },
                      child: Text(
                        "تغيير البلد",
                        style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .fontSize,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  "مواقيت الصلاة",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
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
          ),
          body: cubit.country != null
              ? WebView(
                  initialUrl:
                      "https://www.islamicfinder.org/world/${cubit.country}/?language=ar")
              : SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "أنتظر",
                        style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .fontSize,
                            color: Theme.of(context).primaryColor),
                      )
                    ],
                  ),
                ),
        );
      },
      listener: (context, state) {},
    );
  }

  Widget listTile(
      {required String title,
      required String time,
      required BuildContext context}) {
    return Card(
      color: Theme.of(context).primaryColor,
      child: ListTile(
        trailing: Text(
          time,
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
              color: Theme.of(context).scaffoldBackgroundColor),
        ),
        title: Text(
          title,
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
              color: Theme.of(context).scaffoldBackgroundColor),
        ),
      ),
    );
  }
}
