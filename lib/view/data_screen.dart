import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  @override
  void initState() {
    super.initState();
    controller.readdata();
  }

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
                      onTap: () {
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
                        expansetype(0),
                        expansetype(1),
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
                                      leading: Icon(Icons.account_balance),
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
