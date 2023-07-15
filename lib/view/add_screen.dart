import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_handler/controller/add_controller.dart';
import 'package:money_handler/controller/expanse_controller.dart';
import 'package:money_handler/expanse_modal/modal.dart';
import 'package:money_handler/utils/database_helper.dart';
import 'package:sizer/sizer.dart';

class Addscreen extends StatefulWidget {
  const Addscreen({super.key});

  @override
  State<Addscreen> createState() => _AddscreenState();
}

class _AddscreenState extends State<Addscreen> {
  Addcontroller add = Get.put(Addcontroller());
  Expansecontroller controller = Get.put(Expansecontroller());
  TextEditingController txtamount = TextEditingController();
  TextEditingController txttitle = TextEditingController();
  TextEditingController txtnote = TextEditingController();

  Map m = Get.arguments;

  @override
  void initState() {
    super.initState();
    add.expansedate.value = add.setDateFormat(DateTime.now());
    if (m['status'] == 1) {
      if(controller.l1[m["index"]]["status"] == 0)
        {
          add.addincome.value=true;
          add.addexpanse.value=false;
        }
      else
        {
          add.addincome.value=false;
          add.addexpanse.value=true;
        }
      txtamount =
          TextEditingController(text: "${controller.l1[m["index"]]["amount"]}");
      txtnote =
          TextEditingController(text: "${controller.l1[m["index"]]["note"]}");
      txttitle =
          TextEditingController(text: "${controller.l1[m["index"]]["title"]}");
      add.selectcategory.value = controller.l1[m["index"]]["category"];
      add.expansedate.value=controller.l1[m['index']]['date'];
      add.expansetime.value=controller.l1[m['index']]['time'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Databasehelper db = Databasehelper();
            if (m["status"] == 0) {
              Expansemodal modal = Expansemodal(
                  amount: int.parse(txtamount.text),
                  title: txttitle.text,
                  note: txtnote.text,
                  category: add.selectcategory.value,
                  date: add.expansedate.value,
                  time: add.expansetime.value,
                  status: add.addincome.value == false ? 1 : 0);
              db.insertdb(modal);
            } else {
              Expansemodal modal = Expansemodal(
                  amount: int.parse(txtamount.text),
                  title: txttitle.text,id: controller.l1[m['index']]['id'],
                  note: txtnote.text,
                  category: add.selectcategory.value,
                  date: add.expansedate.value,
                  time: add.expansetime.value,
                  status: add.addincome.value == false ? 1 : 0);
              db.updatedb(modal);
            }
            controller.readdata();
            // print("==================${controller.l1.length}===============");
            add.categorycolor.value=-1;
            Get.offAllNamed('home');
          },
          child: Icon(Icons.done, size: 18.sp, color: Colors.white),
          backgroundColor: Colors.indigo),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Add expanse",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 15.sp),
        ),
        leading: IconButton(
            onPressed: () {
              Get.offAllNamed('home');
            },
            icon: Icon(Icons.arrow_back, color: Colors.black, size: 18.sp)),
        backgroundColor: Colors.grey.shade200,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        if (add.addincome.value == false) {
                          add.addincome.value = true;
                          add.addexpanse.value = false;
                        } else {
                          add.addincome.value = true;
                        }
                      },
                      child: option(add.addincome, 0)),
                  SizedBox(width: 25),
                  InkWell(
                      onTap: () {
                        if (add.addexpanse.value == false) {
                          add.addexpanse.value = true;
                          add.addincome.value = false;
                        } else {
                          add.addexpanse.value = true;
                        }
                      },
                      child: option(add.addexpanse, 1)),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  time_date(0),
                  SizedBox(width: 20),
                  time_date(1),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                cursorColor: Colors.indigo,
                controller: txtamount,
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.w400,
                    fontSize: 25.sp),
                decoration: InputDecoration(
                    focusColor: Colors.indigo,
                    suffixIcon: Icon(Icons.calculate,
                        color: Colors.indigo, size: 20.sp),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade500)),
                    hintText: "Enter Amount",
                    focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5.sp),
                        borderSide: BorderSide(color: Colors.indigo)),
                    hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w400,
                        fontSize: 25.sp)),
              ),
              SizedBox(height: 30),
              TextField(
                cursorColor: Colors.indigo,
                controller: txttitle,
                keyboardType: TextInputType.text,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 15.sp),
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.sp),
                        borderSide: BorderSide(color: Colors.indigo)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.sp),
                        borderSide: BorderSide(color: Colors.grey.shade300)),
                    hintText: "Title",
                    hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w400,
                        fontSize: 15.sp)),
              ),
              SizedBox(height: 30),
              Container(
                width: 100.w,
                height: 20.h,alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(10.sp)),
                child: Obx(
                  () => GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 5.h,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            add.categorycolor.value = index;
                            add.selectcategory.value = add.addincome.value == true
                                ? add.income_category[index]
                                : add.expanse_category[index];
                          },
                          child: Obx(
                            () => Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(20.sp),
                                  color: add.categorycolor.value == index
                                      ? Colors.indigo.shade400
                                      : Colors.white),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                      radius: 15.sp,
                                      backgroundColor: Colors.indigo.shade400,
                                      child: add.addincome.value == true
                                          ? add.income_logo[index]
                                          : add.expanse_logo[index]),
                                  SizedBox(width: 5),
                                  Text(
                                      "${add.addincome.value == true ? add.income_category[index] : add.expanse_category[index]}",
                                      style: TextStyle(
                                          color: add.categorycolor.value == index
                                              ? Colors.white
                                              : Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: add.addincome.value == true
                          ? add.income_category.length
                          : add.expanse_category.length),
                ),
              ),
              SizedBox(height: 30),
              TextField(
                cursorColor: Colors.indigo,
                textInputAction: TextInputAction.done,
                controller: txtnote,
                keyboardType: TextInputType.text,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 15.sp),
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.sp),
                        borderSide: BorderSide(color: Colors.indigo)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.sp),
                        borderSide: BorderSide(color: Colors.grey.shade300)),
                    hintText: "Note",
                    hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w400,
                        fontSize: 15.sp)),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget time_date(int i) {
    return InkWell(
      onTap: () async {
        if (i == 0) {
          DateTime? selectdate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2001),
              lastDate: DateTime(2050));

          add.expansedate.value = add.setDateFormat(selectdate!);
        } else {
          TimeOfDay? selecttime = await showTimePicker(
              context: context, initialTime: TimeOfDay.now());
          add.expansetime.value = "$selecttime";
        }
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(20.sp),
            color: Colors.white),
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(i == 0 ? Icons.calendar_month : Icons.watch_later_outlined,
                size: 12.sp, color: Colors.black),
            SizedBox(width: 5),
            Obx(
              () => Text(
                  i == 0
                      ? "${add.expansedate.value}"
                      : "${add.expansetime.value}",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400)),
            ),
          ],
        ),
      ),
    );
  }

  Widget option(RxBool o, int i) {
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
