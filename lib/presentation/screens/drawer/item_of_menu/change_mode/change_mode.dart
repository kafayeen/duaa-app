import 'package:duaa/presentation/controller/duaa_cubit/duaa_cubit.dart';
import 'package:duaa/presentation/controller/duaa_states/duaa_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangeMode extends StatelessWidget {
  const ChangeMode({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DuaaCubit, DuaaStates>(
      builder: (context, state) {
        var app = DuaaCubit.get(context);
        return ListTile(
          splashColor: Colors.transparent,
          onTap: () {
            app.toogleMode();
          },
          title: Row(
            children: [
              app.mode
                  ? Icon(
                      Icons.dark_mode,
                      color: Theme.of(context).primaryColor,
                      size: 25.r,
                    )
                  : Icon(
                      Icons.sunny,
                      color: Theme.of(context).primaryColor,
                      size: 25.r,
                    ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                "تغيير النمط",
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
