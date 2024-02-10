import 'package:duaa/presentation/components/reusable_components/constant.dart';
import 'package:duaa/presentation/controller/duaa_cubit/duaa_cubit.dart';
import 'package:duaa/presentation/controller/duaa_states/duaa_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SebhaScreen extends StatelessWidget {
  const SebhaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DuaaCubit, DuaaStates>(
        builder: (context, state) {
          var cubit = DuaaCubit.get(context);
          return Scaffold(
            appBar: appBar(context: context, text: "السبحة"),
            body: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    cubit.sebhaCount();
                  },
                  child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "عدد الدورات : ${cubit.dawraOfSebha}",
                            style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .fontSize,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text("${cubit.count}",
                              style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .fontSize,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor)),
                        ],
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.r, right: 10.r, left: 10.r),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          cubit.reset();
                        },
                        child: Container(
                          padding: EdgeInsets.all(25.r),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor),
                          child: Text(
                            "إعادة",
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .fontSize,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          cubit.disposeVibrate();
                        },
                        child: Container(
                          padding: EdgeInsets.all(25.r),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor),
                          child: cubit.mute
                              ? Icon(
                                  Icons.music_off_rounded,
                                  size: 25.r,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                )
                              : Icon(
                                  Icons.music_note_rounded,
                                  size: 25.r,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        listener: (context, state) {});
  }
}
