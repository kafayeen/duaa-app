import 'package:duaa/presentation/controller/duaa_cubit/duaa_cubit.dart';
import 'package:duaa/presentation/controller/duaa_states/duaa_states.dart';
import 'package:duaa/presentation/screens/choose/choose.dart';
import 'package:duaa/presentation/screens/drawer/menu_screen/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class ZoomDrawerWidget extends StatelessWidget {
  const ZoomDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DuaaCubit, DuaaStates>(
        builder: (ctx, state) {
          var cubit = DuaaCubit.get(ctx);

          return ZoomDrawer(
            controller: cubit.zoomDrawerController,
            menuScreen: const MenuScreen(),
            mainScreen: const Choose(),
            angle: 0,
            openCurve: Curves.bounceOut,
            closeCurve: Curves.bounceIn,
            borderRadius: 24,
            showShadow: true,
            menuBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
            drawerShadowsBackgroundColor: Theme.of(context).primaryColor,
            slideWidth: MediaQuery.of(context).size.width * 0.65,
          );
        },
        listener: (ctx, state) {});
  }
}
