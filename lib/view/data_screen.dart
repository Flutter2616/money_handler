import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_handler/controller/add_controller.dart';
import 'package:money_handler/controller/expanse_controller.dart';
import 'package:money_handler/utils/database_helper.dart';
import 'package:sizer/sizer.dart';

class Datascreen extends StatefulWidget {
  const Datascreen({super.key});

  @override
  State<Datascreen> createState() => _DatascreenState();
}

class _DatascreenState extends State<Datascreen> {
  Expansecontroller controller = Get.put(Expansecontroller());
  Addcontroller add= Get.put(Addcontroller());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.toNamed("add", arguments: {"status": 0, "index": null});
            },
            child: Icon(Icons.add, color: Colors.white, size: 18.sp),
            backgroundColor: Colors.indigo),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Row(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Money",
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.indigo,
                                fontWeight: FontWeight.w500)),
                        SizedBox(width: 5),
                        Text("Handler",
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Get.bottomSheet(
                            Container(
                                height: 40.h,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        topLeft: Radius.circular(30)),
                                    color: Colors.white),
                                child: Obx(
                                  () => Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(children: [
                                        Text(
                                          "Filter",
                                          style: TextStyle(
                                              color: Colors.indigo,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20.sp),
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: () {
                                            if(controller.type.value==3&&controller.category.value=="")
                                              {
                                                controller.read_filterdata();
                                                print("common===========");
                                              }
                                            else if(controller.type.value!=3&&controller.category.value!="")
                                              {
                                                controller.read_filterdata(cate: controller.category.value,type: controller.type.value);
                                                print("sort===========");
                                              }
                                            else if(controller.type.value!=3&&controller.category.value=="")
                                              {
                                                controller.read_filterdata(type: controller.type.value);
                                              }
                                            else if(controller.type.value==3&&controller.category.value!="")
                                              {
                                                controller.read_filterdata(cate:controller.category.value);
                                              }
                                            // print("******************${controller.filterlist[controller.type.value]['value']}===============================");
                                            Get.back();
                                          },
                                          child: Container(
                                              child: Text("filter",
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      color: Colors.white)),
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15, vertical: 8),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  color: Colors.indigo)),
                                        ),
                                        SizedBox(width: 10),
                                        InkWell(
                                          onTap: () {
                                            controller.type.value = 3;
                                            controller.category.value = "";
                                            controller.readdata();
                                            Get.back();
                                          },
                                          child: Container(
                                              child: Text("clear",
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      color: Colors.white)),
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15, vertical: 8),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  color: Colors.indigo)),
                                        ),
                                      ]),
                                      SizedBox(height: 10),
                                      Text("Type",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500)),
                                      SizedBox(height: 10),
                                      SizedBox(
                                        height: 4.h,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                  onTap: () {
                                                    if (controller.type.value ==
                                                        index) {
                                                      controller.type.value = 3;
                                                    } else {
                                                      controller.type.value =
                                                          index;
                                                    }
                                                  },
                                                  child: Obx(
                                                    () => Container(
                                                      margin: EdgeInsets.only(
                                                          right: 10),
                                                      alignment: Alignment.center,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8,
                                                              vertical: 5),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.black),
                                                          color:
                                                              controller.type
                                                                          .value ==
                                                                      index
                                                                  ? Colors.indigo
                                                                      .shade100
                                                                  : Colors.grey
                                                                      .shade100),
                                                      child: Text(
                                                          "${controller.filterlist[index]}"),
                                                    ),
                                                  ));
                                            },
                                            itemCount:
                                                controller.filterlist.length),
                                      ),
                                      SizedBox(height: 10),
                                      Text("Category",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500)),
                                      SizedBox(height: 10),
                                      controller.type.value == 0
                                          ? Expanded(
                                              child: GridView.builder(
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 3,
                                                          mainAxisExtent: 6.h,
                                                          crossAxisSpacing: 5),
                                                  itemBuilder: (context, index) {
                                                    return InkWell(
                                                        onTap: () {
                                                          if (controller.category
                                                                  .value ==
                                                              controller
                                                                      .income_category[
                                                                  index]) {
                                                            controller.category
                                                                .value = "";
                                                          } else {
                                                            controller.category
                                                                .value = controller
                                                                    .income_category[
                                                                index];
                                                          }
                                                        },
                                                        child: Obx(
                                                          () => Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 10,
                                                                    bottom: 10),
                                                            alignment:
                                                                Alignment.center,
                                                            width: 20.w,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal: 8,
                                                                    vertical: 5),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black),
                                                                color: controller
                                                                            .category
                                                                            .value ==
                                                                        controller
                                                                                .income_category[
                                                                            index]
                                                                    ? Colors
                                                                        .indigo
                                                                        .shade100
                                                                    : Colors.grey
                                                                        .shade100),
                                                            child: Text(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                "${controller.income_category[index]}"),
                                                          ),
                                                        ));
                                                  },
                                                  itemCount: controller
                                                      .income_category.length),
                                            )
                                          : Expanded(
                                              child: GridView.builder(
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 3,
                                                          mainAxisExtent: 6.h,
                                                          crossAxisSpacing: 5),
                                                  itemBuilder: (context, index) {
                                                    return InkWell(
                                                        onTap: () {
                                                          if (controller.category
                                                                  .value ==
                                                              controller
                                                                      .expanse_category[
                                                                  index]) {
                                                            controller.category
                                                                .value = "";
                                                          } else {
                                                            controller.category
                                                                .value = controller
                                                                    .expanse_category[
                                                                index];
                                                          }
                                                        },
                                                        child: Obx(
                                                          () => Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 10,
                                                                    bottom: 10),
                                                            alignment:
                                                                Alignment.center,
                                                            width: 20.w,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal: 8,
                                                                    vertical: 5),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black),
                                                                color: controller
                                                                            .category
                                                                            .value ==
                                                                        controller
                                                                                .expanse_category[
                                                                            index]
                                                                    ? Colors
                                                                        .indigo
                                                                        .shade100
                                                                    : Colors.grey
                                                                        .shade100),
                                                            child: Text(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                "${controller.expanse_category[index]}"),
                                                          ),
                                                        ));
                                                  },
                                                  itemCount: controller
                                                      .expanse_category.length),
                                            ),
                                    ],
                                  ),
                                )),
                            isDismissible: true,
                            enableDrag: true);
                      },
                      child: CircleAvatar(
                          radius: 15.sp,
                          backgroundColor: Colors.indigo,
                          child: Icon(Icons.tune,
                              color: Colors.white, size: 18.sp)),
                    ),
                  ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
                  SizedBox(height: 15),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(onTap: () {
                          add.addincome.value=true;
                          add.addexpanse.value=false;
                          Get.toNamed("add", arguments: {"status": 0, "index": null});
                        },child: expansetype(0)),
                        InkWell(onTap: () {
                          add.addincome.value=false;
                          add.addexpanse.value=true;
                          Get.toNamed("add", arguments: {"status": 0, "index": null});
                        },child: expansetype(1)),
                      ]),
                  SizedBox(height: 15),
                  Text(
                    "History",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 20),
                  controller.l1.length == 0
                      ? Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/image/bg.png",
                                width: 80.w,
                                height: 80.w,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(height: 20),
                              Text(
                                "No Transaction",
                                style: TextStyle(
                                    color: Colors.black,
                                    // fontWeight: FontWeight.w400,
                                    fontSize: 18.sp),
                              ),
                              SizedBox(height: 15),
                              Text(
                                "Tap To Add new Expanse/Income",
                                style: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.sp),
                              ),
                            ],
                          ),
                        )
                      : Obx(
                          () => Column(
                            children: controller.l1
                                .asMap()
                                .entries
                                .map((e) => ListTile(
                                      onTap: () {
                                        Get.toNamed('add', arguments: {
                                          "status": 1,
                                          "index": e.key
                                        });
                                      },
                                      title: Text(
                                          "${controller.l1[e.key]['title']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18.sp,
                                              color: Colors.indigo)),
                                      leading: Container(
                                        width: 8.w,
                                        height: 8.w,
                                        child: Image.asset(
                                            controller.l1[e.key]["status"] == 0
                                                ? "assets/image/wallet.png"
                                                : "assets/image/lost.png",
                                            fit: BoxFit.fill),
                                      ),
                                      subtitle: Text(
                                          "${controller.l1[e.key]['category']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12.sp,
                                              color: Colors.black)),
                                      trailing: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                              "${controller.l1[e.key]['status'] == 0 ? '+' : '-'}${controller.l1[e.key]['amount']}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15.sp,
                                                  color: controller.l1[e.key]
                                                              ['status'] ==
                                                          0
                                                      ? Colors.green.shade800
                                                      : Colors.red.shade800)),
                                          PopupMenuButton(
                                            iconSize: 20.sp,
                                            icon: Icon(Icons.more_vert,
                                                color: Colors.indigo),
                                            itemBuilder: (context) {
                                              return [
                                                PopupMenuItem(
                                                    child: Text("Delete"),
                                                    onTap: () {
                                                      Databasehelper db =
                                                          Databasehelper();
                                                      db.deletedb(controller
                                                          .l1[e.key]['id']);
                                                      controller.readdata();
                                                      print(
                                                          "datascreen:${controller.l1.length}===============");
                                                    }),
                                              ];
                                            },
                                          )
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container expansetype(int i) {
    return Container(
      height: 8.h,
      width: 45.w,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.sp)),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(i == 0 ? "Income" : "Expanse",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400)),
              Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  "${i == 0 ? controller.totalincome : controller.totalexpanse}",
                  style: TextStyle(
                      color:
                          i == 0 ? Colors.green.shade800 : Colors.red.shade800,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500)),
            ],
          ),
          CircleAvatar(
            radius: 10.sp,
            child: Icon(
              i == 0 ? Icons.call_received_outlined : Icons.call_made,
              color: i == 0 ? Colors.green.shade800 : Colors.red.shade800,
              size: 15.sp,
            ),
            backgroundColor:
                i == 0 ? Colors.green.shade100 : Colors.red.shade100,
          )
        ],
      ),
    );
  }
}
