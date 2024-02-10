import 'package:duaa/presentation/controller/duaa_cubit/duaa_cubit.dart';
import 'package:duaa/presentation/controller/duaa_states/duaa_states.dart';
import 'package:duaa/presentation/screens/drawer/item_of_menu/qebla/next_qebla.dart';
import 'package:duaa/presentation/screens/drawer/item_of_menu/qebla/qebla_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class Qebla extends StatelessWidget {
  const Qebla({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DuaaCubit, DuaaStates>(
        builder: (context, state) {
          var cubit = DuaaCubit.get(context);
          return ListTile(
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.scale,
                      duration: const Duration(milliseconds: 500),
                      child:
                          cubit.check ? const QeblaScreen() : const NextQebla(),
                      alignment: Alignment.center));
            },
            title: Row(
              children: [
                Icon(
                  EvaIcons.compass,
                  color: Theme.of(context).primaryColor,
                  size: 25.r,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  "أتجاه القبلة",
                  style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleLarge!.fontSize,
                      color: Theme.of(context).primaryColor),
                )
              ],
            ),
          );
        },
        listener: (context, state) {});
  }
}
