// ignore_for_file: unused_local_variable, unused_import

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/Layout/shop_layout.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/modules/login.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/Layout/on_boarding_screen.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'shared/bloc_observer/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  Widget widget;
  await Cashe_Helper.init();
  bool? onboarding = Cashe_Helper.getdata(key: 'on boarding');
  String? token = Cashe_Helper.getdata(key:'token');
  print(token);
  if (onboarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = LoginScreen();
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget startwidget;
  MyApp(this.startwidget);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Shopcubit()..gethomedata()..getcategories()..getfavourites()..getUserData(),
      child: BlocConsumer<Shopcubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            themeMode: ThemeMode.light,
            theme: lighttheme,
            debugShowCheckedModeBanner: false,
            home: startwidget,
          );
        },
      ),
    );
  }
}
