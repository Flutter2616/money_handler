import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_handler/controller/add_controller.dart';
import 'package:money_handler/controller/expanse_controller.dart';
import 'package:money_handler/expanse_modal/budgetmodal.dart';
import 'package:money_handler/utils/database_helper.dart';
import 'package:sizer/sizer.dart';

class Budgetscreen extends StatefulWidget {
  const Budgetscreen({super.key});

  @override
  State<Budgetscreen> createState() => _BudgetscreenState();
}

class _BudgetscreenState extends State<Budgetscreen> {
  Addcontroller add = Get.put(Addcontroller());
  Expansecontroller controller = Get.put(Expansecontroller());
  TextEditingController txtbudget = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon:
                          Icon(Icons.arrow_back_ios_new, color: Colors.black)),
                  SizedBox(width: 15),
                  Text("july 2023",
                      style: TextStyle(color: Colors.black, fontSize: 15.sp)),
                  SizedBox(width: 15),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_forward_ios, color: Colors.black)),
                ],
              ),
              backgroundColor: Colors.grey.shade200,
              elevation: 0),
          body: Obx(
            () => ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        "${controller.budgetlist[index]['categoryname']}",
                        style: TextStyle(color: Colors.black, fontSize: 15.sp)),
                    subtitle: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => LinearProgressIndicator(
                              backgroundColor: Colors.grey.shade400,
                              value: controller.budgetlist[index]['budget'] ==
                                      null
                                  ? (controller.spentlist[index]['spent'] / 100)
                                  : (controller.spentlist[index]['spent'] /
                                      controller.budgetlist[index]['budget']),
                              minHeight: 0.5.h,
                              color: Colors.indigo),
                        ),
                        SizedBox(height: 2),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                                "Spent:${controller.spentlist[index]['spent']}",
                                style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 11.sp)),
                            Spacer(),
                            Text(
                                "Limit:${controller.budgetlist[index]['budget']}",
                                style: TextStyle(
                                    color: Colors.indigo,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ],
                    ),
                    leading: Container(
                      height: 10.w,
                      width: 10.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade400,
                        borderRadius: BorderRadius.circular(6.sp),
                      ),
                      child: add.expanse_logo[index],
                    ),
                    trailing: InkWell(
                      onTap: () {
                        print(
                            "${(controller.spentlist[index]['spent'] / controller.budgetlist[index]['budget'])}");
                        txtbudget.clear();
                        Get.dialog(
                            AlertDialog(
                                actions: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      Databasehelper db = Databasehelper();
                                      Budgetmodal b = Budgetmodal(
                                          category: controller.budgetlist[index]
                                              ['categoryname'],
                                          id: controller.budgetlist[index]
                                              ['id'],
                                          amount: int.parse(txtbudget.text));
                                      db.budgetupdate(b);
                                      controller.readdata();
                                      Get.back();
                                    },
                                    child: Text("Set",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp)),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.indigo),
                                  )
                                ],
                                title: Text("Set budget",
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Colors.indigo,
                                        fontWeight: FontWeight.w500)),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      cursorColor: Colors.indigo,
                                      controller: txtbudget,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.sp),
                                      decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.sp),
                                              borderSide: BorderSide(
                                                  color: Colors.indigo)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.sp),
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade300)),
                                          hintText: "Set budget",
                                          hintStyle: TextStyle(
                                              color: Colors.grey.shade500,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15.sp)),
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                )),
                            barrierDismissible: true);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 20.w,
                        height: 4.h,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.sp),
                            border: Border.all(color: Colors.black)),
                        child: Text("SET LIMIT",
                            style: TextStyle(
                                color: Colors.black, fontSize: 11.sp)),
                      ),
                    ),
                  );
                },
                itemCount: controller.budgetlist.length),
          ),
        ),
      ),
    );
  }
}
