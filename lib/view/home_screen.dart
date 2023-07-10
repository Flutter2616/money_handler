import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_handler/controller/expanse_controller.dart';
import 'package:money_handler/utils/database_helper.dart';
import 'package:money_handler/view/budget_screen.dart';
import 'package:money_handler/view/data_screen.dart';
import 'package:money_handler/view/more_screen.dart';
import 'package:money_handler/view/stats_screen.dart';
import 'package:sizer/sizer.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  TextEditingController txtamount = TextEditingController();
  TextEditingController txtcategory = TextEditingController();
  TextEditingController txttype = TextEditingController();

  Expansecontroller controller = Get.put(Expansecontroller());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(backgroundColor: Colors.white,
        bottomNavigationBar: Obx(
          () => FloatingNavbar(
              items: [
                FloatingNavbarItem(icon: Icons.home, title: "Home",),
                FloatingNavbarItem(icon: Icons.pie_chart, title: "Budget"),
                FloatingNavbarItem(icon: Icons.bar_chart, title: "stats"),
                FloatingNavbarItem(icon: Icons.menu, title: "More"),
              ],
              onTap: (val) {
                controller.pageindex.value = val;
              },
              width: 100.w,borderRadius: 0,
              itemBorderRadius: 25.sp,margin: EdgeInsets.all(0),
              elevation: 0,
              selectedBackgroundColor: Colors.indigo.shade200,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.blueGrey.shade500,
              fontSize: 12.sp,
              iconSize: 15.sp,
              currentIndex: controller.pageindex.value,
              backgroundColor: Colors.white),
        ),
        body: Obx(
          () => IndexedStack(
            children: [
              Datascreen(),
              Budgetscreen(),
              Statsscreen(),
              Morescreen(),
            ],
            index: controller.pageindex.value,
          ),
        ),
      ),
    );
  }

  TextField insertdata({controller, type}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          label: Text("$type"),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
    );
  }
}
