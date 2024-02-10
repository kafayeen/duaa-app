import 'dart:math';

import 'package:duaa/presentation/components/reusable_components/constant.dart';
import 'package:duaa/presentation/controller/duaa_cubit/duaa_cubit.dart';
import 'package:duaa/presentation/controller/duaa_states/duaa_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';

class QeblaScreen extends StatelessWidget {
  const QeblaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DuaaCubit, DuaaStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = DuaaCubit.get(context);
          if (cubit.check == false) {
            cubit.qibla(context: context);
          }
          return Scaffold(
              appBar: appBar(context: context, text: "اتجاه القبلة"),
              body: StreamBuilder(
                  stream: FlutterQiblah.qiblahStream,
                  builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
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
                      );
                    }
                    double direction = snapshot.data!.qiblah;
                    return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DuaaCubit.get(context).check
                                    ? "${direction.ceil()}\u00B0"
                                    : "0",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset(
                                    "assets/png/cadrant.png",
                                    fit: BoxFit.cover,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  Transform.rotate(
                                    angle: direction * (pi / 180) * -1,
                                    child: Image.asset(
                                      "assets/png/compass.png",
                                      fit: BoxFit.cover,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ));
                  }));
        });
  }
}
