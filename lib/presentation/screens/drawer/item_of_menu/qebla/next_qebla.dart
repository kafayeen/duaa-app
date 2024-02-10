import 'package:duaa/presentation/controller/duaa_cubit/duaa_cubit.dart';
import 'package:duaa/presentation/controller/duaa_states/duaa_states.dart';
import 'package:duaa/presentation/screens/drawer/item_of_menu/qebla/qebla_screen.dart';
import 'package:duaa/presentation/screens/drawer/zoom_drawer/zoom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NextQebla extends StatelessWidget {
  const NextQebla({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DuaaCubit, DuaaStates>(
      builder: (context, state) {
        var cubit = DuaaCubit.get(context);
        cubit.qibla(context: context);
        return state is! DuaaQeblaState
            ? Scaffold(
                body: Container(),
              )
            : const Scaffold();
      },
      listener: (context, state) {
        var cubit = DuaaCubit.get(context);
        if (cubit.check) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const QeblaScreen()));
        }
        if (!cubit.check) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const ZoomDrawerWidget()));
        }
      },
    );
  }
}
