import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_handler/controller/expanse_controller.dart';
import 'package:money_handler/controller/stat_controller.dart';
import 'package:sizer/sizer.dart';

class Statsscreen extends StatefulWidget {
  const Statsscreen({super.key});

  @override
  State<Statsscreen> createState() => _StatsscreenState();
}

class _StatsscreenState extends State<Statsscreen> {
  Expansecontroller controller = Get.put(Expansecontroller());
  Statcontroller stat = Get.put(Statcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Row(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.arrow_back_ios_new,
                      color: Colors.black, size: 13.sp),
                  SizedBox(width: 15),
                  Text("WED,JUL 5,2023",
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                  SizedBox(width: 15),
                  Icon(Icons.arrow_forward_ios,
                      color: Colors.black, size: 13.sp),
                ],
              ),
              InkWell(
                onTap: () {},
                child: CircleAvatar(
                    radius: 15.sp,
                    backgroundColor: Colors.indigo,
                    child: Icon(Icons.tune, color: Colors.white, size: 18.sp)),
              ),
            ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
            SizedBox(height: 15),
            Container(
              height: 25.h,
              color: Colors.indigo.shade50,
              alignment: Alignment.center,
              child: Text("coming soon"),
            ),
            SizedBox(height: 10),
            Container(width: 100.w,
              child: DataTable(dividerThickness: 1,
                  border: TableBorder.all(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(8.sp)),
                  columns: [
                    DataColumn(label: Text("Type")),
                    DataColumn(label: Text("Amount"))
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text("Income")),
                      DataCell(Text("${controller.totalincome}")),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("Expanse")),
                      DataCell(Text("${controller.totalexpanse}")),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("Overall")),
                      DataCell(Text("${controller.overall}")),
                    ]),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  option(0,stat.income),
                  option(1,stat.expanse),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget option(int i,RxBool o) {
    return Obx(
                      () => Container(
                    height: 5.5.h,
                    width: 40.w,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: o.value == true ? Colors.indigo.shade100 : Colors.white,
                        borderRadius: BorderRadius.circular(25.sp)),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          i == 0 ? "Income" : "Expanse",
                          style: TextStyle(
                              color: o.value == true ? Colors.black : Colors.grey.shade400,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp),
                        ),
                        CircleAvatar(
                            backgroundColor: o.value == true
                                ? Colors.white
                                : i == 0
                                ? Colors.green.shade100
                                : Colors.red.shade100,
                            radius: 8.sp,
                            child: Icon(
                                i == 0
                                    ? Icons.call_received_outlined
                                    : Icons.call_made_outlined,
                                size: 12.sp,
                                color:
                                i == 0 ? Colors.green.shade800 : Colors.red.shade800)),
                      ],
                    ),
                  ),
                );
  }
}
