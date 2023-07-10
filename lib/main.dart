import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_handler/view/add_screen.dart';
import 'package:money_handler/view/budget_screen.dart';
import 'package:money_handler/view/data_screen.dart';
import 'package:money_handler/view/home_screen.dart';
import 'package:money_handler/view/more_screen.dart';
import 'package:money_handler/view/stats_screen.dart';
import 'package:sizer/sizer.dart';
void main()
{
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'stats',
        routes: {
          '/':(context) => Homescreen(),
          'data':(context) => Datascreen(),
          'budget':(context) => Budgetscreen(),
          'stats':(context) => Statsscreen(),
          'more':(context) => Morescreen(),
          'add':(context) => Addscreen(),
        },
      ),
    ),
  );
}