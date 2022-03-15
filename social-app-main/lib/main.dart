import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding/onboarding.dart';
import 'package:socialapplication/cubit/blocobserver.dart';
import 'package:socialapplication/cubit/cubit.dart';
import 'package:socialapplication/cubit/states/loginstates.dart';
import 'package:socialapplication/cubit/states/socialstates.dart';
import 'package:socialapplication/modules/editprofile.dart';
import 'package:socialapplication/modules/home.dart';
import 'package:socialapplication/modules/layout.dart';
import 'package:socialapplication/modules/login.dart';
import 'package:socialapplication/modules/onboarding.dart';
import 'package:socialapplication/modules/register.dart';
import 'package:socialapplication/modules/setting.dart';
import 'package:socialapplication/modules/verifeyscreen.dart';
import 'package:socialapplication/share/component.dart';
import 'package:socialapplication/share/constant.dart';
import 'package:socialapplication/share/sharedpreference.dart';
import 'package:socialapplication/share/them.dart';
import 'cubit/logincubit.dart';
import 'cubit/registercubit.dart';

void main() async {
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  uid = CacheHelper.getData(key: 'uid');
  bool? onboard = CacheHelper.getData(key: 'onboard');
  bool? isdark = CacheHelper.getData(key: 'isdark');
  token = CacheHelper.getData(key: 'token');

  BlocOverrides.runZoned(
    () {},
    blocObserver: MyBlocObserver(),
  );
  Widget? widget;

  if (onboard == null) {
    widget = socialpplayout();
    if (uid != null) {
      widget = const socialpplayout();
    } else {
      widget = loginpagee();
    }
  } else {
    widget = onboardingscreen();
  }

  runApp(socialapp(
    isdark: isdark,
    firstwidget: widget,
  ));
}

class socialapp extends StatelessWidget {
  String? uid;
  Widget? firstwidget;
  bool? isdark;
  socialapp({this.firstwidget, this.isdark, this.uid});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => appcubit()..getUserData(),
      child: BlocConsumer<appcubit, appstates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightMode(),
            home: AnimatedSplashScreen(
                duration: 3000,
                splash: Icons.home,
                nextScreen: firstwidget!,
                splashTransition: SplashTransition.fadeTransition,
                curve: Curves.bounceInOut,
                backgroundColor: Color.fromARGB(255, 81, 162, 228)),
          );
        },
      ),
    );
  }
}
