import 'package:duaa/presentation/controller/duaa_cubit/duaa_cubit.dart';
import 'package:duaa/presentation/controller/duaa_states/duaa_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DuaaCubit, DuaaStates>(
      builder: (context, state) {
        var app = DuaaCubit.get(context);
        return ListTile(
          splashColor: Colors.transparent,
          onTap: () {
            app.notifications();
          },
          title: Row(
            children: [
              app.notification
                  ? Icon(
                      Icons.notifications_rounded,
                      color: Theme.of(context).primaryColor,
                      size: 25.r,
                    )
                  : Icon(
                      Icons.notifications_off_rounded,
                      color: Theme.of(context).primaryColor,
                      size: 25.r,
                    ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                "الإشعارات",
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                    color: Theme.of(context).primaryColor),
              )
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
