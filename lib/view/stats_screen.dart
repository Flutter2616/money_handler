import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_handler/controller/add_controller.dart';
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
  Addcontroller add = Get.put(Addcontroller());
  Statcontroller stat = Get.put(Statcontroller());
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
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
                  ], mainAxisAlignment: MainAxisAlignment.center),
                  SizedBox(height: 15),
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: DChartPie(
                      data: [
                        {
                          'domain': 'Income',
                          'measure': ((controller.totalincome * 100)/(controller.totalincome+controller.totalexpanse)).toInt()
                        },
                        {
                          'domain': 'Expanse',
                          'measure': ((controller.totalexpanse *100)/(controller.totalincome+controller.totalexpanse)).toInt()
                        },
                      ],
                      fillColor: (pieData, index) =>
                          index! % 2 == 0 ? Colors.indigo : Colors.amber,
                      showLabelLine: true,
                      donutWidth: 30,
                      labelColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 100.w,
                    child: DataTable(
                        dividerThickness: 1,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              if (stat.income.value == false) {
                                stat.income.value = true;
                                stat.expanse.value = false;
                              } else {
                                stat.income.value = true;
                              }
                            },
                            child: option(0, stat.income)),
                        InkWell(
                            onTap: () {
                              if (stat.expanse.value == false) {
                                stat.income.value = false;
                                stat.expanse.value = true;
                              } else {
                                stat.expanse.value = true;
                              }
                            },
                            child: option(1, stat.expanse)),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Category",
                            style: TextStyle(
                                color: Colors.grey.shade400, fontSize: 10.sp)),
                        Text("Percentage",
                            style: TextStyle(
                                color: Colors.grey.shade400, fontSize: 10.sp)),
                      ]),
                  SizedBox(height: 10),
                  Divider(height: 1, color: Colors.grey.shade300, thickness: 1),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Obx(
            () => SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return stat.income.value != true
                    ? ListTile(
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
                        title: Text("${add.expanse_category[index]}",
                            style: TextStyle(
                                fontSize: 15.sp, color: Colors.black)),
                        subtitle: Text("0 Transactions",
                            style: TextStyle(
                                fontSize: 10.sp, color: Colors.grey.shade300)),
                        trailing: Stack(
                          alignment: Alignment(0, 0),
                          children: [
                            Text("0%"),
                            CircularProgressIndicator(
                              backgroundColor: Colors.grey.shade300,
                              color: Colors.indigo,
                              value: 0.5,
                            ),
                          ],
                        ),
                      )
                    : ListTile(
                        leading: Container(
                          height: 10.w,
                          width: 10.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade400,
                            borderRadius: BorderRadius.circular(6.sp),
                          ),
                          child: add.income_logo[index],
                        ),
                        title: Text("${add.income_category[index]}",
                            style: TextStyle(
                                fontSize: 15.sp, color: Colors.black)),
                        subtitle: Text("0 Transactions",
                            style: TextStyle(
                                fontSize: 10.sp, color: Colors.grey.shade300)),
                        trailing: Stack(
                          alignment: Alignment(0, 0),
                          children: [
                            Text("0%"),
                            CircularProgressIndicator(
                              backgroundColor: Colors.grey.shade300,
                              color: Colors.indigo,
                              value: 0.5,
                            ),
                          ],
                        ),
                      );
              },
                  childCount: stat.income.value == true
                      ? add.income_category.length
                      : add.expanse_category.length),
            ),
          ),
        ],
      ),
    );
  }

  Widget option(int i, RxBool o) {
    return Obx(
      () => Container(
        height: 5.5.h,
        width: 45.w,
        margin: EdgeInsets.symmetric(horizontal: 5),
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
