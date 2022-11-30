import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:flutter/material.dart';

MaterialApp setMaterialApp({Widget? home}) {
  return MaterialApp(
    theme: ThemeData.dark().copyWith(
      colorScheme: kColorScheme,
      primaryColor: kRichBlack,
      scaffoldBackgroundColor: kRichBlack,
      textTheme: kTextTheme,
    ),
    navigatorObservers: [routeObserver],
    home: home,
  );
}
