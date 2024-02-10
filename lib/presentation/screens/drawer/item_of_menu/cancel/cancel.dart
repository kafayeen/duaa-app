import 'package:duaa/presentation/controller/duaa_cubit/duaa_cubit.dart';
import 'package:duaa/presentation/controller/duaa_states/duaa_states.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Cancel extends StatelessWidget {
  const Cancel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DuaaCubit, DuaaStates>(
        builder: (context, state) {
          var cubit = DuaaCubit.get(context);
          return ListTile(
            splashColor: Colors.transparent,
            onTap: () {
              cubit.toggle();
            },
            title: Row(
              children: [
                Icon(
                  EvaIcons.close,
                  color: Theme.of(context).primaryColor,
                  size: 30.r,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  "خروج",
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
