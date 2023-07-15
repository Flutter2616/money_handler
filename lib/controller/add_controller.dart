import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class Addcontroller extends GetxController {
  RxBool addincome = false.obs;
  RxBool addexpanse = true.obs;
  RxString selectcategory="Shopping".obs;
  RxInt categorycolor=0.obs;
  List expanse_category = [
    "Bills and utilities",
    "Food and Drinks",
    "Entertainment",
    "Investment",
    "Transportation",
    "Shopping",
    "Medical",
    "Education",
    "Gifts and Donation",
    "Insurance",
    "Taxes",
    "other",
  ];
  List<Icon> expanse_logo = [
    Icon(Icons.receipt,color: Colors.white,size: 18.sp),
    Icon(Icons.fastfood,color: Colors.white,size: 18.sp),
    Icon(Icons.videogame_asset_rounded,color: Colors.white,size: 18.sp),
    Icon(Icons.show_chart,color: Colors.white,size: 18.sp),
    Icon(Icons.directions_transit,color: Colors.white,size: 18.sp),
    Icon(Icons.shopping_cart,color: Colors.white,size: 18.sp),
    Icon(Icons.medical_services_rounded,color: Colors.white,size: 18.sp),
    Icon(Icons.school,color: Colors.white,size: 18.sp),
    Icon(Icons.card_giftcard,color: Colors.white,size: 18.sp),
    Icon(Icons.verified_user,color: Colors.white,size: 18.sp),
    Icon(Icons.account_balance,color: Colors.white,size: 18.sp),
    Icon(Icons.interests,color: Colors.white,size: 18.sp),
  ];
  List income_category = [
    "Salary",
    "Sales",
    "Awards",
    "Other",
  ];
  List<Icon> income_logo = [
    Icon(Icons.money,color: Colors.white,size: 18.sp),
    Icon(Icons.discount_outlined,color: Colors.white,size: 18.sp),
    Icon(Icons.emoji_events,color: Colors.white,size: 18.sp),
    Icon(Icons.account_balance,color: Colors.white,size: 18.sp),
  ];
  RxString expansedate = "${DateTime.now()}".obs;
  RxString expansetime = "${TimeOfDay.now()}".obs;

  String setDateFormat(DateTime dt)
  {
    var f = DateFormat("dd-MM-yyyy");
    return f.format(dt);
  }

}
