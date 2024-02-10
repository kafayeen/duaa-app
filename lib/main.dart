import 'package:duaa/core/bloc_observer/bloc_observer.dart';
import 'package:duaa/core/flutter_local_notification/flutter_local_notification.dart';
import 'package:duaa/core/local_service/shared_pref_service/shared_pref_service.dart';
import 'package:duaa/core/local_service/init_database/init_database.dart';
import 'package:duaa/core/utlis/shared/themes/themes.dart';
import 'package:duaa/presentation/controller/duaa_cubit/duaa_cubit.dart';
import 'package:duaa/presentation/controller/duaa_states/duaa_states.dart';
import 'package:duaa/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// responsive
//bloc
void main() async {
  // tz.initializeTimeZones();
  //dart pub run flutter_native_splash:create
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp();
  InitDataBase.init();
  await ScreenUtil.ensureScreenSize();
  // FlutterNativeSplash.preserve(
  //     widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  bool? mode = CacheHelper.getData("mode") ?? false;
  FlutterLocalNotificationService.init(
      descMorning: "هل أخذت حظك من الأذكار اليوم");
  runApp(MyApp(
    mode: mode!,
  ));
}
// notification
//git

class MyApp extends StatelessWidget {
  final bool mode;
  const MyApp({super.key, required this.mode});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => DuaaCubit()
        ..toogleMode(change: mode)
        ..getCountry()
        ..create(),
      child: BlocConsumer<DuaaCubit, DuaaStates>(
        builder: (context, state) {
          var cubit = DuaaCubit.get(context);
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (ctx, child) {
              return MaterialApp(
                  theme: ThemeDuaa.themeLight,
                  themeMode: cubit.mode ? ThemeMode.light : ThemeMode.dark,
                  darkTheme: ThemeDuaa.themeDark,
                  localizationsDelegates: const [
                    GlobalCupertinoLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  supportedLocales: const [
                    Locale("ar"),
                  ],
                  locale: const Locale("ar"),
                  title: "منارة التوحبد",
                  debugShowCheckedModeBanner: false,
                  home: const SplashScreen());
            },
            // const SplashScreen()
          );
        },
        listener: (ctx, state) {},
      ),
    );
  }
}
